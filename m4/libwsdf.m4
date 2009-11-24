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
AC_DEFUN([ACJF_CHECK_LIB_WSDF],
[dnl
AC_LANG_PUSH([C++])

ACJF_CHECK_LIB_SYSTEMC
ACJF_CHECK_LIB_COSUPPORT

acjf_libwsdf_CPPFLAGS="$CPPFLAGS";
acjf_libwsdf_LDFLAGS="$LDFLAGS";
CPPFLAGS="$CPPFLAGS $SYSTEMC_INCLUDE $COSUPPORT_INCLUDE"
LDFLAGS="$LDFLAGS $SYSTEMC_LDFLAGS $COSUPPORT_LDFLAGS"
ACJF_CHECK_LIB(
  [LibWSDF],
  [LibWSDF],
  [
#include <iostream>
#include <wsdf/smoc_wsdf_edge.hpp>],
  [smoc_wsdf_edge_descr my_edge(std::cin);],
  [wsdf -lsystemc -lcosupport-streams],
  [$1], [$2])
CPPFLAGS="$acjf_libwsdf_CPPFLAGS"
LDFLAGS="$acjf_libwsdf_LDFLAGS"

if test x"$pkg_libwsdf_builddir" != x""; then
  LIBWSDF_DEPENDENCIES="$pkg_libwsdf_builddir/libwsdf.la"
else
  LIBWSDF_DEPENDENCIES=""
fi
AC_SUBST([LIBWSDF_DEPENDENCIES])

AC_LANG_POP
])
