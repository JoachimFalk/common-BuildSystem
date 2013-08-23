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

dnl ACJF_CHECK_LIB_NGANALYSIS check for libnganalysis library
dnl ACJF_CHECK_LIB_NGANALYSIS(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_NGANALYSIS],
[dnl
AC_LANG_PUSH([C++])
acjf_found_libnganalysis=""
if test x"$acjf_found_libnganalysis" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find boost library required by LibSGX, bailing out!])], [])
    acjf_found_libnganalysis="no"
  fi
fi
if test x"$acjf_found_libnganalysis" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by LibSGX, bailing out!])], [])
    acjf_found_libnganalysis="no"
  fi
fi
if test x"$acjf_found_libnganalysis" != x"no"; then
  acjf_libnganalysis_CPPFLAGS="$CPPFLAGS";
  acjf_libnganalysis_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $COSUPPORT_INCLUDE $BOOST_INCLUDE"
  LDFLAGS="$LDFLAGS $COSUPPORT_LDFLAGS $BOOST_LDFLAGS"
  ACJF_CHECK_LIB(
    [LibNGAnalysis],
    [LibNGAnalysis],
    [#include <nganalysis/SDF.hpp>],
    [int dummy;],
    [nganalysis cosupport-streams],
    [acjf_found_libnganalysis="yes";],
    [acjf_found_libnganalysis="no";])
  CPPFLAGS="$acjf_libnganalysis_CPPFLAGS"
  LDFLAGS="$acjf_libnganalysis_LDFLAGS"
  if test x"$acjf_found_libnganalysis" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find LibNGAnalysis library, bailing out!])], [])
    acjf_found_libnganalysis="no"
  else
    LIBNGANALYSIS_INCLUDE="$LIBNGANALYSIS_INCLUDE $BOOST_INCLUDE $COSUPPORT_INCLUDE"
    LIBNGANALYSIS_INCPATH="$LIBNGANALYSIS_INCPATH $BOOST_INCPATH $COSUPPORT_INCPATH"
    acjf_found_libnganalysis="yes"
  fi
fi

if test x"$pkg_libnganalysis_builddir" != x""; then
  LIBNGANALYSIS_DEPENDENCIES="$pkg_libnganalysis_builddir/libnganalysis.la"
else
  LIBNGANALYSIS_DEPENDENCIES=""
fi
AC_SUBST([LIBNGANALYSIS_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([LIBNGANALYSIS_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_libnganalysis" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_libnganalysis
unset acjf_got_boost
unset acjf_got_cosupport
unset acjf_got_xerces
AC_LANG_POP
])
