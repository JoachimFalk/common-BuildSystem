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

dnl ACJF_CHECK_LIB_PIPPP check for pip++ library
dnl ACJF_CHECK_LIB_PIPPP(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_PIPPP],
[dnl
AC_LANG_PUSH([C++])
acjf_found_libpippp=""
if test x"$acjf_found_libpippp" != x"no"; then
  ACJF_CHECK_LIB_PIP(
   [acjf_got_pip="yes";],
   [acjf_got_pip="no";])
  if test x"$acjf_got_pip" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find PIP library required by pip++, bailing out!])], [])
    acjf_found_libpippp="no"
  fi
fi
if test x"$acjf_found_libpippp" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by pip++, bailing out!])], [])
    acjf_found_libpip++="no"
  fi
fi
if test x"$acjf_found_libpippp" != x"no"; then
  acjf_libpippp_CPPFLAGS="$CPPFLAGS";
  CPPFLAGS="$CPPFLAGS $BOOST_INCLUDE $COSUPPORT_INCLUDE -DPIP_CALC_PRECISION=64"
  ACJF_CHECK_LIB(
    [pip__],
    [pip++],
    [#include <piplibclasses.hpp>],    
    [fhgPipVector test(4);],
    [pip__],
    [acjf_found_libpippp="no";]
    [acjf_found_libpippp="";])
  CPPFLAGS="$acjf_libpippp_CPPFLAGS"
  if test x"$acjf_found_libpippp" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find pip++ library, bailing out!])], [])
    acjf_found_libpippp="no"
  else
    PIP___INCLUDE="$PIP___INCLUDE $PIPLIB_INCLUDE $COSUPPORT_INCLUDE"
  fi
fi

if test x"$pkg_libpippp_builddir" != x""; then
  PIP___DEPENDENCIES="$pkg_libpippp_builddir/libpip++.la"
else
  PIP___DEPENDENCIES=""
fi
AC_SUBST([PIP___DEPENDENCIES])

#m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
#  ACJF_M4_LIST_PUSH_BACK([LIBSGX_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

#if test x"$acjf_found_libsgx" = x"yes"; then
#  m4_if([$1], [], [true;], [$1])
#else
#  m4_if([$2], [], [true;], [$2])
#fi
unset acjf_found_libpippp
unset acjf_got_pip
unset acjf_got_cosupport
AC_LANG_POP
])
