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

dnl _ACJF_CHECK_PYTHON_SGXUTILS_TESTMACRO(
dnl   <name of lib check (pkgname)>,
dnl   <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl If not source tree location => execute code if not found
dnl If source tree location => execute code if found
m4_define([_ACJF_CHECK_PYTHON_SGXUTILS_TESTMACRO], [
  AC_MSG_CHECKING([for $1 package in ${$2_desc}])
  if test [x"$2" != x"acjf_cv_pysgxutils"]; then
    AC_MSG_ERROR([Internal error: Hardcoded variable prefix is different from expected one!])
  fi
  if test [x"${$2_type}" = x"pkg-config-bundled" -o \
           x"${$2_type}" = x"pkg-config"]; then
    if test x"$PKG_CONFIG_PATH" = x""; then
      [acjf_var_pkg_config_path="${$2_pkg_config_path}"]
    else
      [acjf_var_pkg_config_path="${$2_pkg_config_path}:${PKG_CONFIG_PATH}"]
    fi
    dnl echo "PKG_CONFIG_PATH: $acjf_var_pkg_config_path"
    if test [x"${$2_type}" = x"pkg-config-bundled"]; then
      [$2_srctreemode_pymodulepath=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG "${$2_modules}" --variable srctreemode_pymodulepath 2>/dev/null`]
    fi
    [$2_pymodulepath=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG "${$2_modules}" --variable pymodulepath 2>/dev/null`]
    unset acjf_var_pkg_config_path
    AC_MSG_RESULT([yes]);
    m4_if([$3], [], [true], [$3])
  else
    AC_MSG_RESULT([no]);
    m4_if([$4], [], [false], [$4])
  fi
])

dnl ACJF_CHECK_PYTHON_SGXUTILS check for LibSGXUtils python bindings
dnl
dnl ACJF_CHECK_PYTHON_SGXUTILS(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_PYTHON_SGXUTILS], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([LibSGXUtils], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsgxutils]]))dnl
  ACJF_SEARCHLOC_COPY([LibSGXUtils], [PySGXUtils])dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([PySGXUtils], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:LibSGXUtils],[pkgconfig:pysgxutils]]),
    [_ACJF_CHECK_PYTHON_SGXUTILS_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  [pkg_pysgxutils_srctreemode_pymodulepath="${acjf_cv_pysgxutils_srctreemode_pymodulepath}"]
  [pkg_pysgxutils_pymodulepath="${acjf_cv_pysgxutils_pymodulepath}"]
  if test [x"${PYSGXUTILS_FOUND}" = x"yes";] then
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

dnl ACJF_CHECK_LIB_SGXUTILS check for LibSGXUtils library
dnl
dnl ACJF_CHECK_LIB_SGXUTILS(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SGXUTILS], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([LibSGXUtils], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsgxutils]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([LibSGXUtils], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern:LibSGXUtils],[pkgconfig:libsgxutils]]),
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [#include <sgx.hpp>
      #include <sgxutils/RecursiveProblemGraphObjVisitor.hpp>
   
      using namespace SystemCoDesigner::SGX;
      using namespace SystemCoDesigner::SGXUtils;],
     [NetworkGraphAccess ngx("some-file.sgx");

      typedef RecursiveProblemGraphObjVisitor<Actor> RecActorVisitor;
      typedef RecActorVisitor::Objs                  Actors;

      RecActorVisitor av;
      apply_visitor(av, ngx.problemGraph());
      Actors actors = av;

      return 0;]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])
