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
dnl ACJF_CHECK_LIB_MAESTROMM(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROMM],
[dnl
AC_LANG_PUSH([C++])
acjf_found_maestromm=""
if test x"$acjf_found_maestromm" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find boost library required by MaestroMM, bailing out!])], [])
    acjf_found_maestromm="no"
  fi
fi
if test x"$acjf_found_maestromm" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by MaestroMM, bailing out!])], [])
    acjf_found_maestromm="no"
  fi
fi
if test x"$acjf_found_maestromm" != x"no"; then
  ACJF_CHECK_LIB_XERCES(
   [acjf_got_xerces="yes";],
   [acjf_got_xerces="no";])
  if test x"$acjf_got_xerces" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find Xerces library required by MaestroMM, bailing out!])], [])
    acjf_found_maestromm="no"
  fi
fi
if test x"$acjf_found_maestromm" != x"no"; then
  ACJF_CHECK_LIB_SYSTEMC(
   [acjf_got_systemc="yes";],
   [acjf_got_systemc="no";])
  if test x"$acjf_got_systemc" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find SystemC library required by MaestroMM, bailing out!])], [])
    acjf_found_maestromm="no"
  fi
fi
if test x"$acjf_found_maestromm" != x"no"; then
  acjf_maestromm_CPPFLAGS="$CPPFLAGS";
  acjf_maestromm_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $BOOST_INCLUDE $SYSTEMC_INCLUDE $XERCES_INCLUDE $COSUPPORT_INCLUDE"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS $SYSTEMC_LDFLAGS $XERCES_LDFLAGS $COSUPPORT_LDFLAGS"
  ACJF_ARG_WITHPKG([Maestro], [disabled intern extern])dnl
  ACJF_PKG_COPY_OPTIONS([Maestro], [MaestroMM])
  ACJF_CHECK_LIB_TESTER([MaestroMM], [Maestro/MetaMap],
    ACJF_CHECK_LIB_TESTMACROGEN(
      [#include <MetaMap/Elements.hpp>],
      [MetaMap::Node node("flups");],
      [maestro_mm]),
    [acjf_found_maestromm="yes";],
    [acjf_found_maestromm="no";])
  CPPFLAGS="$acjf_maestromm_CPPFLAGS"
  LDFLAGS="$acjf_maestromm_LDFLAGS"
  if test x"$acjf_found_maestromm" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find MaestroMM library, bailing out!])], [])
    acjf_found_maestromm="no"
  else
    MAESTROMM_INCLUDE="$MAESTROMM_INCLUDE $BOOST_INCLUDE $SYSTEMC_INCLUDE $XERCES_INCLUDE $COSUPPORT_INCLUDE"
    acjf_found_maestromm="yes"
  fi
fi

if test x"$pkg_maestromm_builddir" != x""; then
  MAESTROMM_DEPENDENCIES="$pkg_maestromm_builddir/libmaestro_mm.la"
else
  MAESTROMM_DEPENDENCIES=""
fi
AC_SUBST([MAESTROMM_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([MAESTROMM_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_maestromm" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_maestromm
unset acjf_got_boost
unset acjf_got_cosupport
unset acjf_got_xerces
unset acjf_got_systemc
AC_LANG_POP
])

dnl ACJF_CHECK_LIB_MAESTROIL check for libxxxx
dnl ACJF_CHECK_LIB_MAESTROIL(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROIL],
[dnl
AC_LANG_PUSH([C++])
acjf_found_maestroil=""
if test x"$acjf_found_maestroil" != x"no"; then
  ACJF_CHECK_LIB_SYSTEMOC(
    [acjf_got_systemoc="yes";],
    [acjf_got_systemoc="no";])
  if test x"$acjf_got_systemoc" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find SysteMoC library required by MaestroIL, bailing out!])], [])
    acjf_found_maestroil="no"
  fi
  if test x"$acjf_cv_systemoc_enable_maestromm" != x"yes"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([No MaestroMM support in SysteMoC library required by MaestroIL, bailing out!])], [])
    acjf_found_maestroil="no"
  fi
fi
if test x"$acjf_found_maestroil" != x"no"; then
  acjf_maestroil_CPPFLAGS="$CPPFLAGS";
  acjf_maestroil_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $SYSTEMOC_INCLUDE $MAESTROMM_INCLUDE"
  LDFLAGS="$LDFLAGS   $SYSTEMOC_LDFLAGS $MAESTROMM_LDFLAGS"
  ACJF_ARG_WITHPKG([Maestro], [disabled intern extern])dnl
  ACJF_PKG_COPY_OPTIONS([Maestro], [MaestroIL])
  ACJF_CHECK_LIB_TESTER([MaestroIL], [Maestro/InterfaceLibrary],
    ACJF_CHECK_LIB_TESTMACROGEN(
      [#include <iostream>],
      [std::cout << "flup" << std::endl;],
      [stdc++]),
    [acjf_found_maestroil="yes";],
    [acjf_found_maestroil="no";])
  CPPFLAGS="$acjf_maestroil_CPPFLAGS"
  LDFLAGS="$acjf_maestroil_LDFLAGS"
  if test x"$acjf_found_maestroil" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find MaestroIL library, bailing out!])], [])
    acjf_found_maestroil="no"
  else
    MAESTROIL_INCLUDE="$MAESTROIL_INCLUDE $MAESTROMM_INCLUDE $SYSTEMOC_INCLUDE"
    acjf_found_maestroil="yes"
  fi
fi

if test x"$pkg_maestroil_builddir" != x""; then
  MAESTROIL_DEPENDENCIES="$pkg_maestroil_builddir/libmaestro_il.la"
else
  MAESTROIL_DEPENDENCIES=""
fi
AC_SUBST([MAESTROIL_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([MAESTROIL_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_maestroil" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_maestroil
unset acjf_got_systemoc
AC_LANG_POP
])

dnl ACJF_CHECK_LIB_MAESTROML check for libxxxx
dnl ACJF_CHECK_LIB_MAESTROML(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_MAESTROML],
[dnl
AC_LANG_PUSH([C++])
acjf_found_maestroml=""
if test x"$acjf_found_maestroml" != x"no"; then
  ACJF_CHECK_LIB_MAESTROIL(
    [acjf_got_maestroil="yes";],
    [acjf_got_maestroil="no";])
  if test x"$acjf_got_maestroil=" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find MaestroIL library required by MaestroML, bailing out!])], [])
    acjf_found_maestroml="no"
  fi
fi
if test x"$acjf_found_maestroml" != x"no"; then
  acjf_maestroml_CPPFLAGS="$CPPFLAGS";
  acjf_maestroml_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $SYSTEMOC_INCLUDE $MAESTROIL_INCLUDE"
  LDFLAGS="$LDFLAGS   $SYSTEMOC_LDFLAGS $MAESTROIL_LDFLAGS"
  ACJF_ARG_WITHPKG([Maestro], [disabled intern extern])dnl
  ACJF_PKG_COPY_OPTIONS([Maestro], [MaestroML])
  ACJF_CHECK_LIB_TESTER([MaestroML], [Maestro/ModelLibrary],
    ACJF_CHECK_LIB_TESTMACROGEN(
      [#include <iostream>],
      [std::cout << "flup" << std::endl;],
      [stdc++])
    [acjf_found_maestroml="yes";],
    [acjf_found_maestroml="no";])
  CPPFLAGS="$acjf_maestroml_CPPFLAGS"
  LDFLAGS="$acjf_maestroml_LDFLAGS"
  if test x"$acjf_found_maestroml" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find MaestroIL library, bailing out!])], [])
    acjf_found_maestroml="no"
  else
    MAESTROML_INCLUDE="$MAESTROML_INCLUDE $MAESTROIL_INCLUDE"
    acjf_found_maestroml="yes"
  fi
fi

if test x"$pkg_maestroml_builddir" != x""; then
  MAESTROML_DEPENDENCIES="$pkg_maestroml_builddir/libmaestro_ml.la"
else
  MAESTROML_DEPENDENCIES=""
fi
AC_SUBST([MAESTROML_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([MAESTROML_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_maestroml" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_maestroml
unset acjf_got_maestroil
AC_LANG_POP
])
