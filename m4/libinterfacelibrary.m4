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

dnl ACJF_CHECK_LIB_MM check for libmm
dnl ACJF_CHECK_LIB_MM(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_INTERFACELIBRARYTESTMACRO], [
CPPFLAGS="$CPPFLAGS $INTERFACELIBRARY_INCLUDE"
LDFLAGS="$LDFLAGS $INTERFACELIBRARY_LDFLAGS"
LIBS="$LIBS -linterfacelibrary"
])

AC_DEFUN([ACJF_CHECK_LIB_INTERFACELIBRARY],
[dnl
AC_LANG_PUSH([C++])
ACJF_CHECK_LIB(
  [InterfaceLibrary],
  [InterfaceLibrary],
  [#include <iostream>],
  [std::cout << "flup" << std::endl;],
  [stdc++],
  [$1], [$2])
AC_LANG_POP
AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([InterfaceLibrary], [InterfaceLibrary],
    [ACJF_CHECK_LIB_INTERFACELIBRARYTESTMACRO],
    [true], [false])
AC_LANG_POP
dnl fi
])
