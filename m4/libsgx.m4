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

dnl ACJF_CHECK_PYTHON_SGX check for LibSGX python bindings
dnl
dnl ACJF_CHECK_LIB_SGX(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_PYTHON_SGX], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([LibSGX], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsgx]]))dnl
  ACJF_SEARCHLOC_COPY([LibSGX], [PySGX])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([PySGX], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:LibSGX],[pkgconfig:pysgx]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_SGX check for LibSGX library
dnl
dnl ACJF_CHECK_LIB_SGX(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SGX], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([LibSGX], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsgx]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([LibSGX], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:LibSGX],[pkgconfig:libsgx]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [#include <sgx.hpp>
     ],
     [SystemCoDesigner::SGX::NetworkGraphAccess ngx("some-file.sgx");]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])
