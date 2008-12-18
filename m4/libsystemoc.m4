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

dnl ACJF_CHECK_LIB_SYSTEMOC check for cosupport library
dnl ACJF_CHECK_LIB_SYSTEMOC(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMOC],
[dnl
AC_LANG_PUSH([C++])
acjf_found_systemoc=""
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_SYSTEMC(
   [acjf_got_systemc="yes";],
   [acjf_got_systemc="no";])
  if test x"$acjf_got_systemc " = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find SystemC library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_TLM1(
   [acjf_got_tlm1="yes";],
   [acjf_got_tlm1="no";])
  if test x"$acjf_got_tlm1" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find tlm1 headers required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_XERCES(
   [acjf_got_xerces="yes";],
   [acjf_got_xerces="no";])
  if test x"$acjf_got_xerces " = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find Xerces library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  ACJF_CHECK_LIB_SGX(
   [acjf_got_libsgx="yes";],
   [acjf_got_libsgx="no";])
  if test x"$acjf_got_libsgx" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find SGX library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then

  ACJF_CHECK_LIB_SYSTEMC_VPC(
   [acjf_got_systemcvpc="yes";],
   [acjf_got_systemcvpc="no";])
  if test x"$acjf_got_systemcvpc" = x"yes"; then
    LVPC="-lsystemcvpc"
  fi

  ACJF_CHECK_LIB_WSDF(
   [acjf_got_libwsdf="yes";],
   [acjf_got_libwsdf="no";])
  if test x"$acjf_got_libwsdf" = x"yes"; then
    LWSDF="-lwsdf"
  fi

  acjf_systemoc_CPPFLAGS="$CPPFLAGS";
  acjf_systemoc_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $SYSTEMC_VPC_INCLUDE $LIBWSDF_INCLUDE $LIBSGX_INCLUDE $COSUPPORT_INCLUDE $SYSTEMC_INCLUDE $XERCES_INCLUDE $BOOST_INCLUDE"
  LDFLAGS="$LDFLAGS $SYSTEMC_VPC_LDFLAGS $LIBWSDF_LDFLAGS $LIBSGX_LDFLAGS $COSUPPORT_LDFLAGS $SYSTEMC_LDFLAGS $XERCES_LDFLAGS $BOOST_LDFLAGS"
ACJF_CHECK_LIB(
    [SysteMoC],
    [SysteMoC],
    [#include <systemoc/smoc_config.h>
     #include <systemc.h>
     #define main _main
     int sc_main(int, char**) { return 0; }
    ],
    [int x;],
    [systemoc $LVPC $LWSDF -lsgx -lcosupport-streams -lcosupport-smartptr -lcosupport-systemc -lcosupport-xerces -lsystemc -lxerces-c -lboost_program_options$BOOST_LIBPOSTFIX],
    [acjf_found_systemoc="no";]
    [acjf_found_systemoc="";])
  CPPFLAGS="$acjf_systemoc_CPPFLAGS"
  LDFLAGS="$acjf_systemoc_LDFLAGS"
  if test x"$acjf_found_systemoc" = x"no"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find SysteMoC library, bailing out!])], [])
    acjf_found_systemoc="no"
  else
    SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $BOOST_INCLUDE $SYSTEMC_INCLUDE $TLM1_INCLUDE $COSUPPORT_INCLUDE $XERCES_INCLUDE $LIBSGX_INCLUDE"
  fi
fi

if test x"$pkg_systemoc_builddir" != x""; then
  SYSTEMOC_DEPENDENCIES="$pkg_systemoc_builddir/libsystemoc.la"
else
  SYSTEMOC_DEPENDENCIES=""
fi
AC_SUBST([SYSTEMOC_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([SYSTEMOC_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_systemoc" != x"no"; then
  # Check for VPC Support in SysteMoC
  AC_MSG_CHECKING([for VPC support in SysteMoC])
  AC_CACHE_VAL([acjf_cv_systemoc_vpc_support], 
   [acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$CPPFLAGS $SYSTEMOC_INCLUDE"
    # Checks for header files.
    AC_PREPROC_IFELSE(
     [AC_LANG_PROGRAM(
      [[
#include <systemoc/smoc_config.h>
      ]],
      [[
#ifndef SYSTEMOC_ENABLE_VPC
# error "No VPC Support in SysteMoC"
#endif
      ]])],
     [acjf_cv_systemoc_vpc_support=yes;],
     [acjf_cv_systemoc_vpc_support=no;])
    CPPFLAGS="$acjf_CPPFLAGS"
    unset acjf_CPPFLAGS])
  if test x"$acjf_cv_systemoc_vpc_support" = x"yes"; then
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
  fi
  AM_CONDITIONAL([SYSTEMOC_ENABLE_VPC], test x"$acjf_cv_systemoc_vpc_support" = x"yes")
  if test x"$acjf_cv_systemoc_vpc_support" = x"yes" -a \
          x"$acjf_got_systemcvpc" != x"yes"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find SystemC-VPC library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  else
    if test x"$acjf_cv_systemoc_vpc_support" != x"no"; then
      SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $SYSTEMC_VPC_INCLUDE"
    fi
    acjf_found_systemoc="yes"
  fi
fi
if test x"$acjf_found_systemoc" != x"no"; then
  # Check for WSDF Support in SysteMoC
  AC_MSG_CHECKING([for WSDF support in SysteMoC])
  AC_CACHE_VAL([acjf_cv_systemoc_wsdf_support], 
   [acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$CPPFLAGS $SYSTEMOC_INCLUDE"
    # Checks for header files.
    AC_PREPROC_IFELSE(
     [AC_LANG_PROGRAM(
      [[
#include <systemoc/smoc_config.h>
      ]],
      [[
#ifndef SYSTEMOC_ENABLE_WSDF
# error "No WSDF Support in SysteMoC"
#endif
      ]])],
     [acjf_cv_systemoc_wsdf_support=yes;],
     [acjf_cv_systemoc_wsdf_support=no;])
    CPPFLAGS="$acjf_CPPFLAGS"
    unset acjf_CPPFLAGS])
  if test x"$acjf_cv_systemoc_wsdf_support" = x"yes"; then
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
  fi
  AM_CONDITIONAL([SYSTEMOC_ENABLE_WSDF], test x"$acjf_cv_systemoc_wsdf_support" = x"yes")
  if test x"$acjf_cv_systemoc_wsdf_support" = x"yes" -a \
          x"$acjf_got_libwsdf" != x"yes"; then
    m4_if([$2], [], [AC_MSG_ERROR([Cannot find libWSDF library required by SysteMoC, bailing out!])], [])
    acjf_found_systemoc="no"
  else
    if test x"$acjf_cv_systemoc_wsdf_support" != x"no"; then
      SYSTEMOC_INCLUDE="$SYSTEMOC_INCLUDE $LIBWSDF_INCLUDE"
    fi
    acjf_found_systemoc="yes"
  fi
fi
if test x"$acjf_found_systemoc" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_systemoc
unset acjf_got_boost
unset acjf_got_systemc
unset acjf_got_tlm1
unset acjf_got_xerces
unset acjf_got_cosupport
unset acjf_got_libsgx
unset acjf_got_systemcvpc
unset acjf_got_libwsdf
AC_LANG_POP
])
