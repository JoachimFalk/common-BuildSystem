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


dnl ACJF_CHECK_LIB_SYSTEMOCTESTMACRO(
dnl  <name of lib check (pkgname)>,
dnl  <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default does nothing>]])
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMOCTESTMACRO], [

dnl dnl ignore AM_CONDITIONAL in the called macros
dnl m4_pushdef([AM_CONDITIONAL], m4_defn([ACJF_M4_NULL]))

acjf_var_systemoc_error=""
acjf_var_systemoc_found=""
acjf_cv_systemoc_sgx_support=""
acjf_cv_systemoc_vpc_support=""
acjf_cv_systemoc_wsdf_support=""
if test x"$acjf_var_systemoc_found" != x"no"; then
  # Checks for header files.
  AC_MSG_CHECKING([for $1 package in $$2])
  AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
    [[
#include <systemoc/smoc_config.h>
    ]],
    [[
#ifndef SYSTEMOC_VERSION
# error "NO SysteMoC!"
#endif
    ]])],
   [AC_MSG_RESULT([yes]);],
   [AC_MSG_RESULT([no]); acjf_var_systemoc_found="no";])
fi
if test x"$acjf_var_systemoc_found" != x"no"; then
  # Checks for header files.
  AC_MSG_CHECKING([for SGX support in $1 package])
  AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
    [[
#include <systemoc/smoc_config.h>
    ]],
    [[
#ifndef SYSTEMOC_ENABLE_SGX
# error "NO SGX!"
#endif
    ]])],
   [AC_MSG_RESULT([yes]); acjf_cv_systemoc_sgx_support="yes";],
   [AC_MSG_RESULT([no]); acjf_cv_systemoc_sgx_support="no";])
fi
if test x"$acjf_var_systemoc_found" != x"no"; then
  # Checks for header files.
  AC_MSG_CHECKING([for VPC support in $1 package])
  AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
    [[
#include <systemoc/smoc_config.h>
    ]],
    [[
#ifndef SYSTEMOC_ENABLE_VPC
# error "NO VPC!"
#endif
    ]])],
   [AC_MSG_RESULT([yes]); acjf_cv_systemoc_vpc_support="yes";],
   [AC_MSG_RESULT([no]); acjf_cv_systemoc_vpc_support="no";])
fi
if test x"$acjf_var_systemoc_found" != x"no"; then
  # Checks for header files.
  AC_MSG_CHECKING([for WSDF support in $1 package])
  AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
    [[
#include <systemoc/smoc_config.h>
    ]],
    [[
#ifndef SYSTEMOC_ENABLE_WSDF
# error "NO WSDF!"
#endif
    ]])],
   [AC_MSG_RESULT([yes]); acjf_cv_systemoc_wsdf_support="yes";],
   [AC_MSG_RESULT([no]); acjf_cv_systemoc_wsdf_support="no";])
fi
if test x"$acjf_var_systemoc_found" != x"no"; then
  CPPFLAGS="$CPPFLAGS $SYSTEMC_INCLUDE"; LDFLAGS="$LDFLAGS $SYSTEMC_LDFLAGS"; LIBS="$LIBS -lsystemc"
  CPPFLAGS="$CPPFLAGS $TLM1_INCLUDE";
  CPPFLAGS="$CPPFLAGS $BOOST_INCLUDE"; LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"; LIBS="$LIBS -lboost_program_options$BOOST_LIBPOSTFIX"
  CPPFLAGS="$CPPFLAGS $COSUPPORT_INCLUDE"; LDFLAGS="$LDFLAGS $COSUPPORT_LDFLAGS"; LIBS="$LIBS -lcosupport-smartptr -lcosupport-systemc"
fi
if test x"$acjf_var_systemoc_found" != x"no" -a x"$acjf_cv_systemoc_sgx_support" = x"yes"; then
  if test x"$LIBSGX_FOUND" = x"yes"; then
    CPPFLAGS="$CPPFLAGS $LIBSGX_INCLUDE"; LDFLAGS="$LDFLAGS $LIBSGX_LDFLAGS"; LIBS="$LIBS -lsgx"
  else
    acjf_var_systemoc_error="LibSGX library missing"; acjf_var_systemoc_found="no";
  fi
fi
if test x"$acjf_var_systemoc_found" != x"no" -a x"$acjf_cv_systemoc_vpc_support" = x"yes"; then
  if test x"$SYSTEMC_VPC_FOUND" = x"yes"; then
    CPPFLAGS="$CPPFLAGS $SYSTEMC_VPC_INCLUDE"; LDFLAGS="$LDFLAGS $SYSTEMC_VPC_LDFLAGS"; LIBS="$LIBS -lsystemcvpc"
  else
    acjf_var_systemoc_error="SystemC VPC library missing"; acjf_var_systemoc_found="no";
  fi
fi
if test x"$acjf_var_systemoc_found" != x"no" -a x"$acjf_cv_systemoc_wsdf_support" = x"yes"; then
  if test x"$LIBWSDF_FOUND" = x"yes"; then
    CPPFLAGS="$CPPFLAGS $LIBWSDF_INCLUDE"; LDFLAGS="$LDFLAGS $LIBWSDF_LDFLAGS"; LIBS="$LIBS -lwsdf"
  else
    acjf_var_systemoc_error="LibWSDF library missing"; acjf_var_systemoc_found="no";
  fi
fi
if test x"$acjf_var_systemoc_found" != x"no" -o x"$acjf_var_systemoc_error" != x""; then
  if test x"$$2" = x"$acjf_bundled_desc"; then
    AC_MSG_CHECKING([if $1 from $$2 can compile an example])
    if test x"$acjf_var_systemoc_error" != x""; then
      AC_MSG_RESULT([$acjf_var_systemoc_error]);
    else
      AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
#include <systemoc/smoc_config.h>
#include <systemc.h>
#define main _main
int sc_main(int, char**) { return 0; }
        ]], [[
int x;
        ]])],
        [AC_MSG_RESULT([yes]); acjf_var_systemoc_found="yes"],
        [AC_MSG_RESULT([no])])
    fi
  else
    AC_MSG_CHECKING([if $1 from $$2 can compile and link an example])
    if test x"$acjf_var_systemoc_error" != x""; then
      AC_MSG_RESULT([$acjf_var_systemoc_error]);
    else
      AC_LINK_IFELSE([AC_LANG_PROGRAM([[
#include <systemoc/smoc_config.h>
#include <systemc.h>
#define main _main
int sc_main(int, char**) { return 0; }
        ]], [[
int x;
        ]])],
        [AC_MSG_RESULT([yes]); acjf_var_systemoc_found="yes"],
        [AC_MSG_RESULT([no])])
    fi
  fi
fi

dnl dnl unignore AM_CONDITIONAL
dnl m4_popdef([AM_CONDITIONAL])

unset acjf_var_systemoc_error
if test x"$acjf_var_systemoc_found" = x"yes"; then
  unset acjf_var_systemoc_found
  m4_if([$3], [], [true], [$3])
else
  unset acjf_var_systemoc_found
  unset acjf_cv_systemoc_sgx_support
  unset acjf_cv_systemoc_vpc_support
  unset acjf_cv_systemoc_wsdf_support
  m4_if([$4], [], [false], [$4])
fi
])

dnl ACJF_CHECK_LIB_SYSTEMOC(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMOC], [
  ACJF_ARG_WITHPKG([SysteMoC], [intern extern])
  
  SYSTEMOC_FOUND=""; acjf_var_systemoc_missing=""
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_BOOST([],
      [SYSTEMOC_FOUND="no"; acjf_var_systemoc_missing="boost library"])
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_SYSTEMC([],
      [SYSTEMOC_FOUND="no"; acjf_var_systemoc_missing="SystemC library"])
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_TLM1([],
      [SYSTEMOC_FOUND="no"; acjf_var_systemoc_missing="tlm1 headers"])
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_COSUPPORT([],
      [SYSTEMOC_FOUND="no"; acjf_var_systemoc_missing="CoSupport library"])
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_SGX([], [false]) dnl may be needed but may also be optional
    ACJF_CHECK_LIB_SYSTEMC_VPC([], [false]) dnl may be needed but may also be optional
    ACJF_CHECK_LIB_WSDF([], [false]) dnl may be needed but may also be optional
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    ACJF_CHECK_LIB_BOOST([],
      [SYSTEMOC_FOUND="no"; acjf_var_systemoc_missing="boost library"])
  fi
  if test x"$SYSTEMOC_FOUND" != x"no"; then
    AC_LANG_PUSH([C++])
    ACJF_CHECK_LIB_TESTER([SysteMoC], [SysteMoC],
      [ACJF_CHECK_LIB_SYSTEMOCTESTMACRO],
      [true], [false])
    AC_LANG_POP
  fi
  
  if test x"$pkg_systemoc_builddir" != x""; then
    SYSTEMOC_DEPENDENCIES="$pkg_systemoc_builddir/libsystemoc.la"
  else
    SYSTEMOC_DEPENDENCIES=""
  fi
  AC_SUBST([SYSTEMOC_DEPENDENCIES])
  
  m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
    ACJF_M4_LIST_PUSH_BACK([SYSTEMOC_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl
  
  AM_CONDITIONAL([SYSTEMOC_ENABLE_SGX], test x"$acjf_cv_systemoc_sgx_support" = x"yes")
  AM_CONDITIONAL([SYSTEMOC_ENABLE_VPC], test x"$acjf_cv_systemoc_vpc_support" = x"yes")
  AM_CONDITIONAL([SYSTEMOC_ENABLE_WSDF], test x"$acjf_cv_systemoc_wsdf_support" = x"yes")
  
  if test x"$SYSTEMOC_FOUND" = x"yes"; then
    SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $BOOST_INCLUDE $SYSTEMC_INCLUDE $TLM1_INCLUDE $COSUPPORT_INCLUDE"
    if test x"$acjf_cv_systemoc_sgx_support" = x"yes"; then
      SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $LIBSGX_INCLUDE"
    fi
    if test x"$acjf_cv_systemoc_vpc_support" = x"yes"; then
      SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $SYSTEMC_VPC_INCLUDE"
    fi
    if test x"$acjf_cv_systemoc_wsdf_support" = x"yes"; then
      SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $LIBWSDF_INCLUDE"
    fi
    m4_if([$1], [], [true;], [$1])
  else
    m4_if([$1$2], [],
     [if test x"$acjf_var_systemoc_missing" != x""; then
        AC_MSG_ERROR([Cannot find $acjf_var_systemoc_missing required by SysteMoC, bailing out!])
       else
        AC_MSG_ERROR([Cannot find SysteMoC, bailing out!])
       fi
     ], [m4_if([$2], [], [true;], [$2])])
  fi
])
