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

dnl ACJF_CHECK_LIB_COSUPPORT check for cosupport library
dnl ACJF_CHECK_LIB_COSUPPORT(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_COSUPPORT],
[dnl
  ACJF_ARG_WITHPKG([CoSupport], [[intern],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-allocators])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-initializer])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-math])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-path])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-random])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-smartptr])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-streams])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-string])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-systemc])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-tracing])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [libcosupport-xerces])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([libcosupport-allocators], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-initializer], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-math], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-path], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-random], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-smartptr], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-streams], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-string], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-systemc], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-tracing], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([libcosupport-xerces], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport], [Support],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  AC_LANG_POP
dnl  AC_LANG_PUSH([C++])
dnl  ACJF_CHECK_LIB(
dnl    [CoSupport],
dnl    [Support],
dnl    [
dnl  #include <iostream>
dnl  #include <CoSupport/Streams/DebugOStream.hpp>],
dnl    [CoSupport::Streams::dout << "Hello World !" << std::endl;],
dnl    [cosupport-streams],
dnl    [$1], [$2])
dnl  AC_LANG_POP
])
