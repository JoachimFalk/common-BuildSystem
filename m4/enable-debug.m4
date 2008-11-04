dnl vim: set sw=2 ts=8 syn=config:
dnl Copyright (C) 2001 - 2006 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_ARG_DEBUG(<default yes|no>,
dnl		   <CFLAG option added if yes>,
dnl		   <CFLAG option added if no>)
AC_DEFUN([ACJF_ARG_DEBUG], 
[dnl
dnl AC_BEFORE([$0],  [ACJF_APPEND_CFLAGS])dnl
dnl AC_BEFORE([$0], [ACJF_APPEND_CXXFLAGS])dnl
AC_MSG_CHECKING([whether to build with debug])
AC_ARG_ENABLE(
  debug,
  [[  --enable-debug          enable debuging [default=$1]]],
  [case "$enableval" in
     yes) enable_debug=yes ;;
     no)  enable_debug=no  ;;
     *)   enable_debug=no  ;;
   esac],
  [enable_debug=$1]
)
AC_MSG_RESULT($enable_debug)
if test "x$enable_debug" = "xyes"; then
  if test "$ac_test_CFLAGS" = set -o "$ac_test_CPPFLAGS" = set; then
    CFLAGS="$CFLAGS $2"
  elif test $ac_cv_prog_cc_g = yes; then
    if test "$GCC" = yes; then
      CFLAGS="-Wall -ggdb $2"
    else
      CFLAGS="-g $2"
    fi
  else
    CFLAGS="$2"
  fi
  if test "$ac_test_CXXFLAGS" = set -o "$ac_test_CPPFLAGS" = set; then
    CXXFLAGS="$CXXFLAGS $2"
  elif test $ac_cv_prog_cxx_g = yes; then
    if test "$GCC" = yes; then
      CXXFLAGS="-Wall -ggdb $2"
    else
      CXXFLAGS="-g $2"
    fi
  else
    CXXFLAGS="$2"
  fi
else
  if test "$ac_test_CFLAGS" = set -o "$ac_test_CPPFLAGS" = set; then
    CFLAGS="$CFLAGS $3"
  else
    if test "$GCC" = yes; then
      CFLAGS="-O2 $3"
    else
      CFLAGS="-O $3"
    fi
  fi
  if test "$ac_test_CXXFLAGS" = set -o "$ac_test_CPPFLAGS" = set; then
    CXXFLAGS="$CXXFLAGS $3"
  else
    if test "$GCC" = yes; then
      CXXFLAGS="-O2 $3"
    else
      CXXFLAGS="-O $3"
    fi
  fi
fi
AC_SUBST([CFLAGS])dnl
AC_SUBST([CXXFLAGS])dnl
AM_CONDITIONAL([DEBUG], test x$enable_debug = xyes)dnl
])
