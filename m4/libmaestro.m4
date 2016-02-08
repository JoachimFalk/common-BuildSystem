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

dnl ACJF_CHECK_LIB_MAESTRO_BRUCKNER check for libmeastro-bruckner
dnl
dnl ACJF_CHECK_LIB_MAESTRO_BRUCKNER(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTRO_BRUCKNER], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [Maestro-Bruckner])
  ACJF_CHECK_LIB_TESTER([Maestro-Bruckner], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/Bruckner],[extern],[pkgconfig:libmaestro-bruckner]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
//    #include <Maestro/Bruckner/FSMTransition.hpp>
     ],[
      int x;
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_MAESTRO_CRESCENDO check for libmaestro_il
dnl
dnl ACJF_CHECK_LIB_MAESTRO_CRESCENDO(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTRO_CRESCENDO], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [Maestro-Crescendo])
  ACJF_CHECK_LIB_TESTER([Maestro-Crescendo], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/Crescendo],[extern],[pkgconfig:libmaestro-crescendo]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
      #include <Maestro/Crescendo/DynamicActor.hpp>
     ],[
      int x;
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_MAESTRO_METAMAP check for libmeastro-metamap
dnl
dnl ACJF_CHECK_LIB_MAESTRO_METAMAP(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTRO_METAMAP], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [Maestro-MetaMap])
  ACJF_CHECK_LIB_TESTER([Maestro-MetaMap], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/MetaMap],[extern],[pkgconfig:libmaestro-metamap]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
      #include <Maestro/MetaMap/Node.hpp>
     ],[
      MetaMap::Node node("flups");
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])

dnl ACJF_CHECK_LIB_MAESTRO_MODELLIBRARY check for libmaestro-modellibrary
dnl
dnl ACJF_CHECK_LIB_MAESTRO_MODELLIBRARY(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTRO_MODELLIBRARY], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_ARG_WITHPKG([Maestro], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro], [Maestro-ModelLibrary])
  ACJF_CHECK_LIB_TESTER([Maestro-ModelLibrary], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern:Maestro/ModelLibrary],[extern],[pkgconfig:libmaestro-modellibrary]]),
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
