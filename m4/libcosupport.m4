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
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_ALLOCATORS], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Allocators])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Allocators], [[intern:Support],[pkgconfig:libcosupport-allocators $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_INITIALIZER(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_INITIALIZER], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Initializer])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Initializer], [[intern:Support],[pkgconfig:libcosupport-initializer $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_MATH(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_MATH], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Math])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Math], [[intern:Support],[pkgconfig:libcosupport-math $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_PATH(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_PATH], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Path])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Path], [[intern:Support],[pkgconfig:libcosupport-path $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_RANDOM(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_RANDOM], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Random])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Random], [[intern:Support],[pkgconfig:libcosupport-random $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_SMARTPTR(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_SMARTPTR], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-SmartPtr])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-SmartPtr], [[intern:Support],[pkgconfig:libcosupport-smartptr $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_STREAMS(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_STREAMS], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Streams])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Streams], [[intern:Support],[pkgconfig:libcosupport-streams $1]],
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [#include <iostream>
      #include <CoSupport/Streams/DebugOStream.hpp>],
     [CoSupport::Streams::dout << "Hello World !" << std::endl;]),
   [$2],
   [$3])dnl
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_STRING(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_STRING], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-String])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-String], [[intern:Support],[pkgconfig:libcosupport-string $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_SYSTEMC(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_SYSTEMC], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-SystemC])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-SystemC], [[intern:Support],[pkgconfig:libcosupport-systemc $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_TRACING(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_TRACING], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Tracing])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Tracing], [[intern:Support],[pkgconfig:libcosupport-tracing $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT_XERCES(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT_XERCES], [dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_SEARCHLOC_COPY([CoSupport], [CoSupport-Xerces])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Xerces], [[intern:Support],[pkgconfig:libcosupport-xerces $1]],
    ACJF_PKG_TESTMACROGEN_DUMMY,
    [$2], [$3])
  AC_LANG_POP
])

dnl ACJF_CHECK_LIB_COSUPPORT check for cosupport library
dnl
dnl NEW ACJF_CHECK_LIB_COSUPPORT USAGE:
dnl
dnl ACJF_CHECK_LIB_COSUPPORT(
dnl   <version check>, # version check is >=|<=|= <version>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl OBSOLETE ACJF_CHECK_LIB_COSUPPORT USAGE:
dnl
dnl ACJF_CHECK_LIB_COSUPPORT(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT], [dnl
  m4_if(m4_eval([$#>3]), [1], [m4_fatal([At most three arguments required for ACJF_CHECK_LIB_COSUPPORT])])dnl
  m4_if(m4_eval([$#<3]), [1],
   [m4_if(m4_bregexp([$1], [\(=\|<=\|>=\)[ 	][ 	]*[0-9]]), [-1],
     [m4_pushdef([ACJF_VAR_PKG_CONDITION], [[]])dnl
      m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$1]])dnl
      m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[$2]])],
     [m4_pushdef([ACJF_VAR_PKG_CONDITION], [[$1]])dnl
      m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$2]])dnl
      m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[]])dnl
   ])],
   [m4_pushdef([ACJF_VAR_PKG_CONDITION], [[$1]])dnl
    m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$2]])dnl
    m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[$3]])dnl
   ])dnl
  
  acjf_var_cosupport_found="yes"
  m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
   [m4_pushdef([ACJF_VAR_CHILD_CODE_IF_FALSE], [[]])],
   [m4_pushdef([ACJF_VAR_CHILD_CODE_IF_FALSE], [[acjf_var_cosupport_found="no"; break;]])])dnl
  AC_LANG_PUSH([C++])
  while true; do
    ACJF_CHECK_LIB_COSUPPORT_ALLOCATORS(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_INITIALIZER(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_MATH(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_PATH(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_RANDOM(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_SMARTPTR(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_STREAMS(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_STRING(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_SYSTEMC(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_TRACING(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_COSUPPORT_XERCES(ACJF_VAR_PKG_CONDITION,[],ACJF_VAR_CHILD_CODE_IF_FALSE)dnl
    ACJF_CHECK_LIB_TESTER([CoSupport], [[intern:Support],[pkgconfig:libcosupport]] ACJF_M4_QUOTE(ACJF_VAR_PKG_CONDITION),
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
  
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_PKG_CONDITION])dnl
])
