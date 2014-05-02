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

dnl _ACJF_CHECK_LIB_SYNTHESIS_XXX_TESTMACRO(
dnl   <name of lib check (pkgname)>,
dnl   <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl If not source tree location => execute code if not found
dnl If source tree location => execute code if found
m4_define([_ACJF_CHECK_LIB_SYNTHESIS_XXX_TESTMACRO], [
  AC_MSG_CHECKING([for $1 package in ${$2_desc}])
  if test [x"${$2_type}" = x"pkg-config-bundled" -o \
           x"${$2_type}" = x"pkg-config"]; then
    if test x"$PKG_CONFIG_PATH" = x""; then
      [acjf_var_pkg_config_path="${$2_pkg_config_path}"]
    else
      [acjf_var_pkg_config_path="${$2_pkg_config_path}:${PKG_CONFIG_PATH}"]
    fi
    dnl echo "PKG_CONFIG_PATH: $acjf_var_pkg_config_path"
    [$2_pkgdatadir=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG "${$2_modules}" --variable pkgdatadir 2>/dev/null`]
    [$2_bindir=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG "${$2_modules}" --variable bindir 2>/dev/null`]
    unset acjf_var_pkg_config_path
    AC_MSG_RESULT([yes]);
    m4_if([$3], [], [true], [$3])
  else
    AC_MSG_RESULT([no]);
    m4_if([$4], [], [false], [$4])
  fi
])

dnl ACJF_CHECK_LIB_SYNTHESIS_FRAMEWORK check for Synthesis Framework
dnl
dnl ACJF_CHECK_LIB_SYNTHESIS_FRAMEWORK(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SYNTHESIS_FRAMEWORK], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([Synthesis-Framework], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsmocsynth-cxx]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([Synthesis-Framework], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[pkgconfig:libsmocsynth libsmocsynth-cxx]]),
    [_ACJF_CHECK_LIB_SYNTHESIS_XXX_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  [pkg_synthesis_framework_pkgdatadir="${acjf_cv_synthesis_framework_pkgdatadir}"]
  [pkg_synthesis_framework_bindir="${acjf_cv_synthesis_framework_bindir}"]
  AC_SUBST([pkg_synthesis_framework_pkgdatadir])
  AC_SUBST([pkg_synthesis_framework_bindir])
  if test [x"${SYNTHESIS_FRAMEWORK_FOUND}" = x"yes";] then
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

dnl ACJF_CHECK_LIB_SYNTHESIS_SW check for Synthesis SW
dnl
dnl ACJF_CHECK_LIB_SYNTHESIS_SW(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SYNTHESIS_SW], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([Synthesis-SW], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsmocsynth-cxx-sw]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([Synthesis-SW], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[pkgconfig:libsmocsynth-cxx-sw]]),
    [_ACJF_CHECK_LIB_SYNTHESIS_XXX_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  [pkg_synthesis_sw_pkgdatadir="${acjf_cv_synthesis_sw_pkgdatadir}"]
  [pkg_synthesis_sw_bindir="${acjf_cv_synthesis_sw_bindir}"]
  AC_SUBST([pkg_synthesis_sw_pkgdatadir])
  AC_SUBST([pkg_synthesis_sw_bindir])
  if test [x"${SYNTHESIS_SW_FOUND}" = x"yes";] then
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

dnl ACJF_CHECK_LIB_SYNTHESIS_PTHREAD check for Synthesis PTHREAD
dnl
dnl ACJF_CHECK_LIB_SYNTHESIS_PTHREAD(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SYNTHESIS_PTHREAD], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([Synthesis-Pthread], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsmocsynth-cxx-pthread]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([Synthesis-Pthread], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[pkgconfig:libsmocsynth-cxx-pthread]]),
    [_ACJF_CHECK_LIB_SYNTHESIS_XXX_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  [pkg_synthesis_pthread_pkgdatadir="${acjf_cv_synthesis_pthread_pkgdatadir}"]
  [pkg_synthesis_pthread_bindir="${acjf_cv_synthesis_pthread_bindir}"]
  AC_SUBST([pkg_synthesis_pthread_pkgdatadir])
  AC_SUBST([pkg_synthesis_pthread_bindir])
  if test [x"${SYNTHESIS_PTHREAD_FOUND}" = x"yes";] then
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
