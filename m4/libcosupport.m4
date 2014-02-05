dnl vim: set sw=2 ts=8 syn=config:
dnl Copyright (C) 2001 - 2014 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_CHECK_LIB_COSUPPORT_ALLOCATORS(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_ALLOCATORS], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Allocators])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Allocators], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-allocators]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_INITIALIZER(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_INITIALIZER], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Initializer])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Initializer], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-initializer]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_MATH(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_MATH], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Math])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Math], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-math]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_PATH(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_PATH], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Path])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Path], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-path]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_RANDOM(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_RANDOM], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Random])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Random], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-random]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_SMARTPTR(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_SMARTPTR], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-SmartPtr])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-SmartPtr], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-smartptr]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_STREAMS(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_STREAMS], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Streams])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Streams], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-streams]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [#include <iostream>
      #include <CoSupport/Streams/DebugOStream.hpp>],
     [CoSupport::Streams::dout << "Hello World !" << std::endl;]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_STRING(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_STRING], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-String])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-String], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-string]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_SYSTEMC(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_SYSTEMC], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-SystemC])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-SystemC], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-systemc]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_TRACING(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_TRACING], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Tracing])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Tracing], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-tracing]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT_XERCES(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_XERCES], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[extern],[pkgconfig:libcosupport]]))dnl
  ACJF_SEARCHLOC_COPY([CoSupport], [CoSupport-Xerces])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Xerces], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport-xerces]]),
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_COSUPPORT(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  acjf_var_cosupport_found="yes"
  m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
   [m4_pushdef([ACJF_VAR_CHILD_CODE_IF_FALSE], [[]])],
   [m4_pushdef([ACJF_VAR_CHILD_CODE_IF_FALSE], [[acjf_var_cosupport_found="no"; break;]])])dnl
  AC_LANG_PUSH([C++])
  while true; do
    ACJF_CHECK_LIB_COSUPPORT_ALLOCATORS(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_INITIALIZER(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_MATH(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_PATH(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_RANDOM(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_SMARTPTR(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_STREAMS(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_STRING(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_SYSTEMC(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_TRACING(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_XERCES(ACJF_VAR_TAGS,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_TESTER([CoSupport], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:Support],[pkgconfig:libcosupport]]),
      ACJF_PKG_TESTMACROGEN_DUMMY,
      [], ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    break
  done
  AC_LANG_POP
  m4_popdef([ACJF_VAR_CHILD_CODE_IF_FALSE])dnl
  
  if test x"${acjf_var_cosupport_found}" = x"yes"; then
    unset acjf_var_cosupport_found
    m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_TRUE";
      ACJF_VAR_CODE_IF_TRUE])
  else
    unset acjf_var_cosupport_found
    m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_FALSE";
      ACJF_VAR_CODE_IF_FALSE])
  fi
])])
