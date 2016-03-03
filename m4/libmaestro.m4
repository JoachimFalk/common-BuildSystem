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
  ACJF_ARG_WITHPKG([Maestro-Crescendo], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro-crescendo]]))dnl
  ACJF_SEARCHLOC_COPY([Maestro-Crescendo], [Maestro-Bruckner])
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
  ACJF_ARG_WITHPKG([Maestro-Crescendo], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[disabled],[intern],[extern],[pkgconfig:libmaestro-crescendo]]))dnl
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

dnl _ACJF_CHECK_LIB_MAESTRO_METAMAP_TESTMACRO(
dnl   <name of lib check (pkgname)>,
dnl   <shell variable prefix set by ACJF_SEARCHLOC_EVALUATE>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default does nothing>]])
m4_define([_ACJF_CHECK_LIB_MAESTRO_METAMAP_TESTMACRO], [
  if test [x"$2" != x"acjf_cv_maestro_metamap"]; then
    AC_MSG_ERROR([Internal error: Hardcoded variable prefix is different from expected one!])
  fi
  m4_pushdef([ACJF_VAR_MAESTRO_METAMAP_TESTCODE], [AC_LANG_PROGRAM(
    [[
      #include <Maestro/MetaMap/Node.hpp>
    ]],
    [[
      MetaMap::Node node("flups");
      return 0;
    ]])])
  acjf_var_maestro_metamap_found=""
  if test [x"${$2_type}" = x"bundled" -o \
           x"${$2_type}" = x"pkg-config-bundled"]; then
    AC_MSG_CHECKING([if $1 from ${$2_desc} can compile an example])
    AC_COMPILE_IFELSE(
      [ACJF_VAR_MAESTRO_METAMAP_TESTCODE],
      [AC_MSG_RESULT([yes]); acjf_var_maestro_metamap_found="yes"],
      [AC_MSG_RESULT([no]);  acjf_var_maestro_metamap_found="no"])
  else
    AC_MSG_CHECKING([if $1 from ${$2_desc} can compile and link an example])
    AC_LINK_IFELSE(
      [ACJF_VAR_MAESTRO_METAMAP_TESTCODE],
      [AC_MSG_RESULT([yes]); acjf_var_maestro_metamap_found="yes"],
      [AC_MSG_RESULT([no]);  acjf_var_maestro_metamap_found="no"])
  fi
  m4_popdef([ACJF_VAR_MAESTRO_METAMAP_TESTCODE])dnl
  if test x"$acjf_var_maestro_metamap_found" = x"yes"; then
    [acjf_cv_maestro_enable_bruckner=""]
    [acjf_cv_maestro_enable_polyphonic=""]
    [acjf_cv_maestro_enable_crescendo=""]
    # Checks for header files.
    AC_MSG_CHECKING([for Bruckner support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <Maestro/maestro_config.h>
      ]],
      [[
  #ifndef MAESTRO_ENABLE_BRUCKNER
  # error "NO BRUCKNER!"
  #endif //MAESTRO_ENABLE_BRUCKNER
      ]])],
     [AC_MSG_RESULT([yes]); acjf_cv_maestro_enable_bruckner="yes";],
     [AC_MSG_RESULT([no]); acjf_cv_maestro_enable_bruckner="no";])
    # Checks for header files.
    AC_MSG_CHECKING([for Crescendo support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <Maestro/maestro_config.h>
      ]],
      [[
  #ifndef MAESTRO_ENABLE_CRESCENDO
  # error "NO CRESCENDO!"
  #endif //MAESTRO_ENABLE_CRESCENDO
      ]])],
     [AC_MSG_RESULT([yes]); acjf_cv_maestro_enable_crescendo="yes";],
     [AC_MSG_RESULT([no]); acjf_cv_maestro_enable_crescendo="no";])
  fi
  if test x"$acjf_var_maestro_metamap_found" = x"yes"; then
    unset acjf_var_maestro_metamap_found
    m4_if([$3], [], [true], [$3])
  else
    unset acjf_var_maestro_metamap_found
    m4_if([$4], [], [false], [$4])
  fi
])

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
    [_ACJF_CHECK_LIB_MAESTRO_METAMAP_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  MAESTRO_ENABLE_BRUCKNER="$acjf_cv_maestro_enable_bruckner"
  AM_CONDITIONAL([MAESTRO_ENABLE_BRUCKNER], test x"acjf_cv_maestro_enable_bruckner" = x"yes")
  MAESTRO_ENABLE_CRESCENDO="$acjf_cv_maestro_enable_crescendo"
  AM_CONDITIONAL([MAESTRO_ENABLE_CRESCENDO], test x"$acjf_cv_maestro_enable_crescendo" = x"yes")
  if test [x"${MAESTRO_METAMAP_FOUND}" = x"yes";] then
    m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_TRUE";
      ACJF_VAR_CODE_IF_TRUE])
  else
    m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_FALSE";
      ACJF_VAR_CODE_IF_FALSE])
  fi
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
