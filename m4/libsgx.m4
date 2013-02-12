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

dnl ACJF_CHECK_LIB_SGX check for cosupport library
dnl ACJF_CHECK_LIB_SGX(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_SGX],
[dnl
AC_LANG_PUSH([C++])
acjf_found_libsgx=""
if test x"$acjf_found_libsgx" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find boost library required by LibSGX, bailing out!])], [])
    acjf_found_libsgx="no"
  fi
fi
if test x"$acjf_found_libsgx" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by LibSGX, bailing out!])], [])
    acjf_found_libsgx="no"
  fi
fi
if test x"$acjf_found_libsgx" != x"no"; then
  ACJF_CHECK_LIB_XERCES(
   [acjf_got_xerces="yes";],
   [acjf_got_xerces="no";])
  if test x"$acjf_got_xerces" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find Xerces library required by LibSGX, bailing out!])], [])
    acjf_found_libsgx="no"
  fi
fi
if test x"$acjf_found_libsgx" != x"no"; then
  acjf_libsgx_CPPFLAGS="$CPPFLAGS";
  acjf_libsgx_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $COSUPPORT_INCLUDE $XERCES_INCLUDE $BOOST_INCLUDE"
  LDFLAGS="$LDFLAGS $COSUPPORT_LDFLAGS $XERCES_LDFLAGS $BOOST_LDFLAGS"
  ACJF_CHECK_LIB(
    [LibSGX],
    [LibSGX],
    [#include <sgx.hpp>],
    [SystemCoDesigner::SGX::NetworkGraphAccess ngx("some-file.sgx");],
    [sgx cosupport-xerces xerces-c $XERCES_AUXLIBS cosupport-initializer cosupport-streams boost_thread$BOOST_LIBMTPOSTFIX],
    [acjf_found_libsgx="yes";],
    [acjf_found_libsgx="no";])
  CPPFLAGS="$acjf_libsgx_CPPFLAGS"
  LDFLAGS="$acjf_libsgx_LDFLAGS"
  if test x"$acjf_found_libsgx" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find LibSGX library, bailing out!])], [])
    acjf_found_libsgx="no"
  else
    LIBSGX_INCLUDE="$LIBSGX_INCLUDE $BOOST_INCLUDE $COSUPPORT_INCLUDE"
    LIBSGX_INCPATH="$LIBSGX_INCPATH $BOOST_INCPATH $COSUPPORT_INCPATH"
    acjf_found_libsgx="yes"
  fi
fi

if test x"$pkg_libsgx_builddir" != x""; then
  LIBSGX_DEPENDENCIES="$pkg_libsgx_builddir/libsgx.la"
else
  LIBSGX_DEPENDENCIES=""
fi
AC_SUBST([LIBSGX_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([LIBSGX_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_libsgx" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_libsgx
unset acjf_got_boost
unset acjf_got_cosupport
unset acjf_got_xerces
AC_LANG_POP
])
