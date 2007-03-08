#! /usr/bin/env perl
# vim: set sw=2 ts=8 sts=2 syn=perl:
#
# Copyright (C) 2001 - 2007 Joachim Falk <joachim.falk@gmx.de>
# 
# This file is part of the BuildSystem distribution of Joachim Falk;
# you can redistribute it and/or modify it under the terms of the
# GNU General Public License as published by the Free Software Foundation;
# either version 2 of the License, or (at your option) any later version.
# 
# The BuildSystem is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this program; If not, write to
# the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

use strict;
use warnings;

use File::Basename;
use File::Spec;
use File::Temp;
use IO::File;

use vars qw($BASE @M4CALL);

BEGIN {
  $BASE   = dirname($0);
  @M4CALL = ( "m4", "-P", "--define", "dnl=m4_dnl",
    "-I", File::Spec->catdir(${BASE}, "m4"),
    File::Spec->catfile(${BASE}, "test-jfsugar.m4"));
}

if (defined $ARGV[0] && $ARGV[0] eq "--interactive") {
  exec @M4CALL, "-";
}

my $fhSugar = IO::File->new(File::Spec->catfile(${BASE}, "m4", "jfsugar.m4"));

die "Can't open jfsugar.m4: $!" unless defined $fhSugar;

my @testcases = ();

{
  my $testcase;
  my $goldenresult;
  my $parseMode = undef;

  sub flushTestcase {
    if (defined $parseMode) {
      die "Unexpected parse mode !" unless $parseMode == \$goldenresult;
      push @testcases, {
          "testcase"      => $testcase,
          "goldenresult"  => $goldenresult
        };
      undef $parseMode; $testcase=""; $goldenresult="";
    }
  };
  
  while (my $line = <$fhSugar>) {
    if ($line =~ m/^dnl\s+Example:\s*/) {
      flushTestcase;
      $parseMode = \$testcase; next;
    }
    if ($line =~ m/^dnl\s+Result:\s*/) {
      die "Unexpected parse mode !" unless $parseMode == \$testcase;
      $parseMode = \$goldenresult; next;
    }
    if (!($line =~ m/^dnl/) || ($line =~ m/^dnl\s*$/)) {
      flushTestcase; next;
    }
    if (defined $parseMode) {
      $line =~ s/^dnl\s*//;
      ${$parseMode} .= $line;
    }
  }
}

my $testcaseFile = File::Temp->new();

my $testcaseDelim = "==== MAGIC TESTCASE END ====";

foreach my $entry (@testcases) {
  $testcaseFile->write($entry->{testcase});
  $testcaseFile->write("[$testcaseDelim]\n");
}

my $resultFile = IO::File->new();

open $resultFile, '-|', @M4CALL, $testcaseFile->filename();


foreach my $entry (@testcases) {
  my $resultText = "";
  while (my $line = <$resultFile>) {
    last if $line eq "$testcaseDelim\n";
    $resultText .= $line;
  }
  if ($resultText ne $entry->{goldenresult}) {
    print "!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    print "!!!!!! TEST FAILED !!!!!!\n";
    print "!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    print $entry->{testcase};
    print "!!!! EXPECTED RESULT !!!!\n";
    print $entry->{goldenresult};
    print "!!!!!! REAL RESULT !!!!!!\n";
    print $resultText;
    print "!!!!!!!!!!!!!!!!!!!!!!!!!\n\n";
  }
}

exit 0
#
#my TMPDIR=`mktemp -d`
#
#[ -d "${TMPDIR}" ] || { echo "Can't create tmp dir"; exit -1; }
#
#sed -n -e \
#    '/^dnl[[:space:]]\+Example:/,/^dnl[[:space:]]\+Result:/{
#      /^dnl[[:space:]]\+Example:/d
#      p
#     }' \
#  $BASE/m4/jfsugar.m4 > "${TMPDIR}/testcases.m4"
#
#cat "${TMPDIR}/testcases.m4"
#
#sed -n -e '/^dnl[[:space:]]\+Result:/,/^dnl[[:space:]]*\|[^d]\|.[^n]\|..[l]$/p' \
#  $BASE/m4/jfsugar.m4 > "${TMPDIR}/testresults.m4"
#
#exec m4 -P --define "dnl=m4_dnl" -I "${BASE}/m4" "${BASE}/test-jfsugar.m4" "${TMPDIR}/testcases.m4"
