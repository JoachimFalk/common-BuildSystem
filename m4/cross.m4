dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2001 - 2006 Joachim Falk <joachim.falk@gmx.de>
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl 
dnl This file is part of the BuildSystem distribution of Joachim Falk;
dnl you can redistribute it and/or modify it under the terms of the
dnl GNU General Public License as published by the Free Software Foundation;
dnl either version 2 of the License, or (at your option) any later version.
dnl 
dnl The BuildSystem is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl 
dnl You should have received a copy of the GNU General Public
dnl License along with this program; If not, write to
dnl the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
dnl Boston, MA 02111-1307, USA.

dnl check for cross tool
dnl ACJF_CHECK_CROSSTOOL( <toolname>,
dnl			  <default name> )
AC_DEFUN([ACJF_CHECK_CROSSTOOL],
[m4_pattern_allow([$1_FOR_BUILD])
acjf_test_CFLAGS=${CFLAGS+set}; acjf_save_CFLAGS="$CFLAGS";
acjf_test_CXXFLAGS=${CXXFLAGS+set}; acjf_save_CXXFLAGS="$CXXFLAGS";
if test "x$host" != "x$build"; then
  dnl Supporting Canadian Cross in Configure Scripts
  if test "x$$1" = "x"; then
    $1="$host_alias-$2";
  fi
  AC_CHECK_PROGS( [$1_FOR_BUILD], $2 )
fi
ifdef([AC_PROG_$1],
  [AC_PROG_$1],
  [AC_CHECK_PROGS( $1, $2 )])
if test "x$host" = "x$build"; then
  [$1_FOR_BUILD]="$$1"
  AC_SUBST([$1_FOR_BUILD])
fi
if test x$acjf_test_CFLAGS = xset; then
  CFLAGS="$acjf_save_CFLAGS";
else
  unset CFLAGS
fi
if test x$acjf_test_CXXFLAGS = xset; then
  CFLAGS="$acjf_save_CXXFLAGS";
else
  unset CXXFLAGS
fi
])

