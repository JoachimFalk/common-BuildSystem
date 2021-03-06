dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 FAU -- Joachim Falk <joachim.falk@fau.de>
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

dnl ACJF_CHECK_LIB_SYSTEMC(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl check for systemc library
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMC],
[AC_LANG_PUSH([C++])
ACJF_CHECK_LIB(
  [SystemC],
  [],
  [
#include <systemc.h>
#define  main _main

SC_MODULE(foo) {
public:
  SC_CTOR(foo) {}
};

int sc_main(int argc, char *argv[]) {
  foo bar("bar");
  return 0;
} ],
  [],
  [systemc],
  [$1], [$2])
AC_LANG_POP
])
