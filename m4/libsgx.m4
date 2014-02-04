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

dnl ACJF_CHECK_HELPER_SET_VARS(
dnl  <arglist>,
dnl  <m4 code to evalute with var environment>)
dnl 
dnl The argument list <arglist> should conform to
dnl ([<tags>],
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl This sets the folowing m4 defined for the <m4 code to evalute with var environment>
dnl
dnl ACJF_VAR_TAGS
dnl ACJF_VAR_CODE_IF_TRUE
dnl ACJF_VAR_CODE_IF_FALSE
AC_DEFUN([ACJF_CHECK_HELPER_SET_VARS], [
  m4_pushdef([ACJF_VAR_ARGSLIST], [$1])dnl
  m4_if(m4_eval(ACJF_M4_ARG_SIZE(ACJF_VAR_ARGSLIST)>3), [1],
   [m4_fatal([At most three arguments required, but given "$1"!])])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [\<disabled\>\|\<intern:\|\<intern\>\|\<extern\>\|\<pkgconfig:\|\<configscript:\|\<version:]), [-1], 
   [m4_pushdef([ACJF_VAR_TAGS], [[]])],
   [m4_pushdef([ACJF_VAR_TAGS], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])])dnl
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_TRUE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_TRUE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_TRUE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_FALSE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_FALSE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_FALSE)"
  m4_popdef([ACJF_VAR_ARGSLIST])dnl
  $2 dnl this is <m4 code to evalute with var environment>
  dnl cleanup var environment
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
])dnl

dnl ACJF_CHECK_LIB_SGX check for cosupport library
dnl
dnl NEW ACJF_CHECK_LIB_SGX USAGE:
dnl
dnl ACJF_CHECK_LIB_SGX(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl OBSOLETE ACJF_CHECK_LIB_SGX USAGE:
dnl
dnl ACJF_CHECK_LIB_SGX(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_SGX], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([LibSGX], [[intern],[extern],[pkgconfig:libsgx]])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([LibSGX], ACJF_VAR_TAGS[,[intern],[pkgconfig:libsgx]],
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [#include <sgx.hpp>
     ],
     [SystemCoDesigner::SGX::NetworkGraphAccess ngx("some-file.sgx");]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])
