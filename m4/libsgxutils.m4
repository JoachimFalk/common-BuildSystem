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
AC_DEFUN([ACJF_CHECK_LIB_SGXUTILS],
[dnl
AC_LANG_PUSH([C++])
acjf_found_libsgxutils=""
if test x"$acjf_found_libsgxutils" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost library required by LibSGXUtils, bailing out!])], [])
    acjf_found_libsgxutils="no"
  fi
fi
if test x"$acjf_found_libsgxutils" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by LibSGXUtils, bailing out!])], [])
    acjf_found_libsgxutils="no"
  fi
fi
if test x"$acjf_found_libsgxutils" != x"no"; then
  ACJF_CHECK_LIB_SGX(
   [acjf_got_libsgx="yes";],
   [acjf_got_libsgx="no";])
  if test x"$acjf_got_libsgx" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find LibSGX library required by LibSGXUtils, bailing out!])], [])
    acjf_found_libsgxutils="no"
  fi
fi
if test x"$acjf_found_libsgxutils" != x"no"; then
  acjf_libsgxutils_CPPFLAGS="$CPPFLAGS";
  CPPFLAGS="$CPPFLAGS $BOOST_INCLUDE $COSUPPORT_INCLUDE"
  ACJF_CHECK_LIB(
    [LibSGXUtils],
    [SGXUtils],
    [#include <sgx.hpp>
     #include <sgxutils/RecursiveProblemGraphObjVisitor.hpp>

     using namespace SystemCoDesigner::SGX;
     using namespace SystemCoDesigner::SGXUtils;],
    [NetworkGraphAccess ngx("some-file.sgx");

     typedef RecursiveProblemGraphObjVisitor<Actor> RecActorVisitor;
     typedef RecActorVisitor::Objs                  Actors;

     RecActorVisitor av;
     apply_visitor(av, ngx.problemGraph());
     Actors actors = av;

     return 0;],
    [sgxutils],
    [acjf_found_libsgxutils="no";]
    [acjf_found_libsgxutils="";])
  CPPFLAGS="$acjf_libsgxutils_CPPFLAGS"
  if test x"$acjf_found_libsgxutils" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find LibSGXUtils library, bailing out!])], [])
    acjf_found_libsgxutils="no"
  else
    LIBSGXUTILS_INCLUDE="$LIBSGXUTILS_INCLUDE $LIBSGX_INCLUDE $BOOST_INCLUDE $COSUPPORT_INCLUDE"
  fi
fi

if test x"$pkg_libsgxutils_builddir" != x""; then
  LIBSGXUTILS_DEPENDENCIES="$pkg_libsgxutils_builddir/libsgxutils.la"
else
  LIBSGXUTILS_DEPENDENCIES=""
fi
AC_SUBST([LIBSGXUTILS_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([LIBSGXUTILS_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_libsgxutils" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_libsgxutils
unset acjf_got_boost
unset acjf_got_cosupport
AC_LANG_POP
])
