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

dnl ACJF_CHECK_LIB_MAESTROMM check for libmeastro_mm
dnl
dnl ACJF_CHECK_LIB_MAESTROMM(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROMM], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [MaestroMM])
  ACJF_CHECK_LIB_TESTER([MaestroMM], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/MetaMap],[extern],[pkgconfig:libmaestro_mm]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
      #include <MetaMap/Elements.hpp>
     ],[
      MetaMap::Node node("flups");
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_MAESTROIL check for libmaestro_il
dnl
dnl ACJF_CHECK_LIB_MAESTROIL(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROIL], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [MaestroIL])
  ACJF_CHECK_LIB_TESTER([MaestroIL], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/InterfaceLibrary],[extern],[pkgconfig:libmaestro_il]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
      #include <InterfaceLibrary/includes.hpp>
     ],[
      Request<bool> foo(false);
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_MAESTROML check for libmaestro_ml
dnl
dnl ACJF_CHECK_LIB_MAESTROML(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROML], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [MaestroML])
  ACJF_CHECK_LIB_TESTER([MaestroML], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/ModelLibrary],[extern],[pkgconfig:libmaestro_ml]]),
    dnl FIXME: Replace this with code that really checks for the presence of the model library!
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
      #include <iostream>
     ],[
      std::cout << "flup" << std::endl;
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])
