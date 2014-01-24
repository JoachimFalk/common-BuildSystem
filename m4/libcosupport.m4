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
  ACJF_ARG_WITHPKG([CoSupport], [[intern:Support],[extern],[pkgconfig:libcosupport]])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Allocators])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Initializer])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Math])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Path])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Random])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-SmartPtr])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Streams])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-String])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-SystemC])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Tracing])dnl
  ACJF_PKG_COPY_OPTIONS([CoSupport], [CoSupport-Xerces])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([CoSupport-Allocators], [[intern:Support],[pkgconfig:libcosupport-allocators]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Initializer], [[intern:Support],[pkgconfig:libcosupport-initializer]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Math], [[intern:Support],[pkgconfig:libcosupport-math]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Path], [[intern:Support],[pkgconfig:libcosupport-path]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Random], [[intern:Support],[pkgconfig:libcosupport-random]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-SmartPtr], [[intern:Support],[pkgconfig:libcosupport-smartptr]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Streams], [[intern:Support],[pkgconfig:libcosupport-streams]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-String], [[intern:Support],[pkgconfig:libcosupport-string]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-SystemC], [[intern:Support],[pkgconfig:libcosupport-systemc]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Tracing], [[intern:Support],[pkgconfig:libcosupport-tracing]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport-Xerces], [[intern:Support],[pkgconfig:libcosupport-xerces]],
    [ACJF_CHECK_PKG_TESTMACRO],
    [$1], [$2])
  ACJF_CHECK_LIB_TESTER([CoSupport], [[intern:Support],[pkgconfig:libcosupport]],
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
