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

dnl ACJF_CHECK_CECSIM_PYCON check for CECSIM-PyCon library
dnl ACJF_CHECK_CECSIM_PYCON(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_CECSIM_PYCON],
[dnl
AC_LANG_PUSH([C++])
ACJF_CHECK_LIB_BOOST
ACJF_CHECK_LIB_COSUPPORT

acjf_CECSIM_PYCON_CPPFLAGS="$CPPFLAGS"
acjf_CECSIM_PYCON_LDFLAGS="$LDFLAGS"
CPPFLAGS="$CPPFLAGS $SYSTEMC_INCLUDE $COSUPPORT_INCLUDE"
LDFLAGS="$LDFLAGS $SYSTEMC_LDFLAGS $COSUPPORT_LDFLAGS"
ACJF_CHECK_LIB(
  [CECSIM-PyCon],
  [CECSIM-PyCon],
  [#include <CECSim/Crossbar.hpp>],
  [CECSim::Crossbar cb;],
  [cecsim -lcosupport-streams],
  [$1], [$2])
CPPFLAGS="$acjf_CECSIM_PYCON_CPPFLAGS"
LDFLAGS="$acjf_CECSIM_PYCON_LDFLAGS"

if test x"$pkg_systemc_vpc_builddir" != x""; then
  CECSIM_PYCON_DEPENDENCIES="$pkg_cecsim_pycon_builddir/libcecsim.la"
else
  CECSIM_PYCON_DEPENDENCIES=""
fi
AC_SUBST([CECSIM_PYCON_DEPENDENCIES])

AC_LANG_POP
])