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
AC_DEFUN([ACJF_CHECK_LIB_ACX],
[dnl
AC_LANG_PUSH([C++])

acjf_found_libacx=""
if test x"$acjf_found_libacx" != x"no"; then
  ACJF_CHECK_LIB_BOOST(
   [acjf_got_boost="yes";],
   [acjf_got_boost="no";])
  if test x"$acjf_got_boost" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find boost library required by LibACX, bailing out!])], [])
    acjf_found_libacx="no"
  fi
fi
if test x"$acjf_found_libacx" != x"no"; then
  ACJF_CHECK_LIB_XERCES(
   [acjf_got_xerces="yes";],
   [acjf_got_xerces="no";])
  if test x"$acjf_got_xerces" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find Xerces library required by LibACX, bailing out!])], [])
    acjf_found_libacx="no"
  fi
fi
if test x"$acjf_found_libacx" != x"no"; then
  ACJF_CHECK_LIB_XALAN(
   [acjf_got_xalan="yes";],
   [acjf_got_xalan="no";])
  if test x"$acjf_got_xalan" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find Xalan library required by LibACX, bailing out!])], [])
    acjf_found_libacx="no"
  fi
fi
if test x"$acjf_found_libacx" != x"no"; then
  ACJF_CHECK_LIB_COSUPPORT(
   [acjf_got_cosupport="yes";],
   [acjf_got_cosupport="no";])
  if test x"$acjf_got_cosupport" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find CoSupport library required by LibACX, bailing out!])], [])
    acjf_found_libacx="no"
  fi
fi
if test x"$acjf_found_libacx" != x"no"; then
  acjf_libacx_CPPFLAGS="$CPPFLAGS";
  acjf_libacx_LDFLAGS="$LDFLAGS";
  CPPFLAGS="$CPPFLAGS $COSUPPORT_INCLUDE $XALAN_INCLUDE $XERCES_INCLUDE $BOOST_INCLUDE"
  LDFLAGS="$LDFLAGS $COSUPPORT_LDFLAGS $XALAN_LDFLAGS $XERCES_LDFLAGS $BOOST_LDFLAGS"
  ACJF_CHECK_LIB(
    [LibACX],
    [LibACX],
    [
  #include <iostream>
  #include <acx.hpp>],
    [SystemCoDesigner::ACX::ActorCollectionAccess ac("dummy.acx");
     std::vector<std::string> types = ac.getAllActorTypes();],
    [acx cosupport-xerces xerces-c $XERCES_AUXLIBS cosupport-xalan xalan-c cosupport-initializer cosupport-streams],
    [acjf_found_libacx="yes";],
    [acjf_found_libacx="no";])
  CPPFLAGS="$acjf_libacx_CPPFLAGS"
  LDFLAGS="$acjf_libacx_LDFLAGS"
  if test x"$acjf_found_libacx" = x"no"; then
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find LibACX library, bailing out!])], [])
    acjf_found_libacx="no"
  else
    LIBACX_INCLUDE="$LIBACX_INCLUDE $BOOST_INCLUDE $COSUPPORT_INCLUDE"
    acjf_found_libacx="yes"
  fi
fi

if test x"$pkg_libacx_builddir" != x""; then
  LIBACX_DEPENDENCIES="$pkg_libacx_builddir/libacx.la"
else
  LIBACX_DEPENDENCIES=""
fi
AC_SUBST([LIBACX_DEPENDENCIES])

m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
  ACJF_M4_LIST_PUSH_BACK([LIBACX_DEPENDENCIES], ACJF_VAR_SUBSTVARFIXUP)))dnl

if test x"$acjf_found_libacx" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_libacx
unset acjf_got_boost
unset acjf_got_cosupport
unset acjf_got_xalan
unset acjf_got_xerces
AC_LANG_POP
])
