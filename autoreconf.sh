#! /bin/sh
# -*- tab-width:8; indent-tabs-mode:nil; -*-
# vim: set sw=2 ts=8 sts=2 et:
#
# Copyright (c)
#   2001 - 2009 Joachim Falk <joachim.falk@gmx.de>
#   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
#   2011 FAU -- Jens Gladigau <jens.gladigau@cs.fau.de>
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

if test -n "${BASH_VERSION+set}" && (set -o posix) >/dev/null 2>&1; then
  set -o posix
fi

# NLS nuisances.
for as_var in \
  LANG LANGUAGE LC_ADDRESS LC_ALL LC_COLLATE LC_CTYPE LC_IDENTIFICATION \
  LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER \
  LC_TELEPHONE LC_TIME
do
  if (set +x; test -n "`(eval $as_var=C; export $as_var) 2>&1`"); then
    eval $as_var=C; export $as_var
  else
    unset $as_var
  fi
done

# Name of the executable.
as_me=`basename "$0"`

BUILDSYSTEM=`readlink -fn $0`
BUILDSYSTEM=`dirname $BUILDSYSTEM`

#cd `dirname $0`
unset SHELL

DIRS=""

OPT_CLEANUP="yes"
OPT_FORCE=""
OPT_VERBOSE="--verbose"
OPT_SYMLINK="--symlink"
OPT_INSTALL="--install"
OPT_RECURSIVE=""

while test $# != 0
do
  case $1 in
    --*=*)
      ac_option=`expr "x$1" : 'x\([^=]*\)='`
      ac_optarg=`expr "x$1" : 'x[^=]*=\(.*\)'`
      ac_shift=:
      ;;
    --*)
      ac_option=$1
      ac_optarg=$2
      ac_shift=shift
      ;;
    *)
      # This is not an option, so the user has probably given explicit
      # arguments.
      ac_option=$1
      ac_shift=:
  esac
  case $ac_option in
    --aclocal-prog)
      ACLOCAL="$ac_optarg"; $ac_shift;
      ;;
    --libtoolize-prog)
      LIBTOOLIZE="$ac_optarg"; $ac_shift;
      ;;
    --automake-prog)
      AUTOMAKE="$ac_optarg"; $ac_shift;
      ;;
    --autoheader-prog)
      AUTOHEADER="$ac_optarg"; $ac_shift;
      ;;
    --autopoint-prog)
      AUTOPOINT="$ac_optarg"; $ac_shift;
      ;;
    --autoreconf-prog)
      AUTORECONF="$ac_optarg"; $ac_shift;
      ;;
    --cleanup)
      OPT_CLEANUP="yes"
      ;;
    --no-cleanup)
      OPT_CLEANUP=""
      ;;
    --force)
      OPT_CLEANUP="yes"
      OPT_FORCE="--force"
      ;;
    --no-force)
      OPT_FORCE=""
      ;;
    --fast)
      OPT_CLEANUP=""
      OPT_FORCE=""
      ;;
    --verbose)
      OPT_VERBOSE="--verbose"
      ;;
    --no-verbose)
      OPT_VERBOSE=""
      ;;
    --recursive)
      OPT_RECURSIVE=""
      ;;
    --no-recursive)
      OPT_RECURSIVE="--no-recursive"
      ;;
    --install)
      OPT_INSTALL="--install"
      ;;
    --no-install)
      OPT_INSTALL=""
      ;;
    --symlink)
      OPT_INSTALL="--install"
      OPT_SYMLINK="--symlink"
      ;;
    --no-symlink)
      OPT_INSTALL=""
      OPT_SYMLINK=""
      ;;
    --copy)
      OPT_INSTALL="--install"
      OPT_SYMLINK=""
      ;;
    --no-copy)
      OPT_INSTALL=""
      OPT_SYMLINK="--symlink"
      ;;
    --help)
      echo "$as_me [OPTIONS] DIRECTORIES

Runs \`autoconf\', \`autoheader\', \`aclocal\', \`automake\', \`autopoint\', and
\`libtoolize\' where appropriate repeatedly to remake the GNU Build System files
in specified DIRECTORIES and their subdirectories (defaulting to \`.\').

  --help                      This message.

  Program location options:

  --aclocal-prog=<prog>       Where to find aclocal (Default: aclocal)
  --libtoolize-prog=<prog>    Where to find libtoolize (Default: libtoolize)
  --automake-prog=<prog>      Where to find automake (Default: automake)
  --autoheader-prog=<prog>    Where to find autoheader (Default: autoheader)
  --autopoint-prog=<prog>     Where to find autopoint (Default: autopoint)
  --autoreconf-prog=<prog>    Where to find autoreconf (Default: autoreconf)

  Boolean options:

  --no-<option>               Disable boolean option --<option>

  --force                     Consider all files obsolete (Default: no)
  --cleanup                   Delete all autogenerated files first (Default: yes)
  --fast                      Try to reuse old stuff. May not work all the time.
                              Disables --cleanup and --force options.
  --verbose                   Verbosely report processing (Default: yes)
  --recursive                 rebuild sub-packages (Default: yes)
  --install                   Install missing auxiliary files
  --copy                      Implies install and copies missing auxiliary files
  --symlink                   Implies install and symlinks missing auxiliary files (Default)
"
        exit 0;
      ;;
    -*)
      echo "$as_me: error: unrecognized option: $1
    Try \`$0 --help' for more information."
      exit 1;
      ;;
    *)
      DIRS="$1 $DIRS";
      ;;
  esac
  shift
done

if test x"$ACLOCAL" = x""; then
  ACLOCAL="aclocal"
fi
if test x"$LIBTOOLIZE" = x""; then
  LIBTOOLIZE="libtoolize"
fi
if test x"$AUTOMAKE" = x""; then
  AUTOMAKE="automake"
fi
if test x"$AUTOHEADER" = x""; then
  AUTOHEADER="autoheader"
fi
if test x"$AUTORECONF" = x""; then
  AUTORECONF="autoreconf"
fi
if test x"$AUTOPOINT" = x""; then
  AUTOPOINT="autopoint"
fi

#ACLOCAL="$ACLOCAL -I $BUILDSYSTEM/m4"
AUTOMAKE="$AUTOMAKE --foreign"

export ACLOCAL
export LIBTOOLIZE
export AUTOMAKE
export AUTOHEADER
export AUTOPOINT

# $LIBTOOLIZE --force
# $ACLOCAL    -I BuildSystem/m4
# $AUTOMAKE   --add-missing

if test x"$OPT_CLEANUP" != x""; then
  # cleanup
  rm -f \
    $BUILDSYSTEM/config.guess           \
    $BUILDSYSTEM/config.sub             \
    $BUILDSYSTEM/depcomp                \
    $BUILDSYSTEM/install-sh             \
    $BUILDSYSTEM/ltmain.sh              \
    $BUILDSYSTEM/missing                \
    $BUILDSYSTEM/mkinstalldirs          \
    $BUILDSYSTEM/m4/libtool.m4          \
    $BUILDSYSTEM/m4/lt~obsolete.m4      \
    $BUILDSYSTEM/m4/ltoptions.m4        \
    $BUILDSYSTEM/m4/ltsugar.m4          \
    $BUILDSYSTEM/m4/ltversion.m4
fi

if test x"$DIRS" = x""; then
  DIRS="."
fi
if test x"$OPT_INSTALL" = x""; then
  OPT_SYMLINK="" # --symlink make no sense without --install
fi

for dir in $DIRS; do
  { test x"$OPT_CLEANUP" = x"" || rm -rf `find "$dir" -name "autom4te.cache"`; } &&
    $AUTORECONF $OPT_INSTALL $OPT_SYMLINK $OPT_FORCE $OPT_VERBOSE $OPT_RECURSIVE "$dir"
done
