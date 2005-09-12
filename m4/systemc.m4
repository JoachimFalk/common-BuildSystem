dnl vim: set sw=2 ts=8 syn=config:
dnl
dnl Copyright (C) Joachim Falk <joachim.falk@gmx.de> $Date: 2003/01/24 13:23:54 $
dnl
dnl systemc.m4 is part of the SysteMoC distribution of Joachim Falk;
dnl you can redistribute it and/or modify it under the terms of the
dnl GNU General Public License as published by the Free Software Foundation;
dnl either version 2 of the License, or (at your option) any later version.
dnl
dnl The jflibs distributio is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public
dnl License along with this program; If not, write to
dnl the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
dnl Boston, MA 02111-1307, USA.

dnl ACJF_SYSTEMC check for systemc library (obsolete)
AU_DEFUN([ACJF_SYSTEMC], [ACJF_CHECK_LIB_SYSTEMC],
  [ACJF_SYSTEMC is considered obsolete use ACJF_CHECK_LIB_SYSTEMC instead.])

dnl ACJF_SYSTEMC check for systemc library
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMC],
[dnl
AC_LANG_PUSH([C++])
WITH_SYSTEMC_INCLUDE=
WITH_SYSTEMC_LIB=
WITH_SYSTEMC_BASE=
AC_ARG_WITH(systemc-include,
  [  --with-systemc-include  Path to SystemC include directory],
  [WITH_SYSTEMC_INCLUDE="$withval"])
  
AC_ARG_WITH(systemc-lib,
  [  --with-systemc-lib      Path to SystemC lib directory],
  [WITH_SYSTEMC_LIB="$withval"])

if test x"$WITH_SYSTEMC_INCLUDE" != "x"; then
  WITH_SYSTEMC_BASE=`echo $WITH_SYSTEMC_INCLUDE | sed -e 's@^\(.*\)[[/\\]]include[[/\\]].*[$]@\1@'`
elif test x"$WITH_SYSTEMC_LIB" != "x"; then
  WITH_SYSTEMC_BASE=`echo $WITH_SYSTEMC_LIB | sed -e 's@^\(.*\)[[/\\]]lib[[/\\]].*[$]@\1@'`
fi

acjf_list=""
if test x"$WITH_SYSTEMC_INCLUDE" != x; then
  acjf_list="$acjf_list $WITH_SYSTEMC_INCLUDE";
fi
if test x"$WITH_SYSTEMC_BASE" != x; then
  acjf_list="$acjf_list $WITH_SYSTEMC_BASE/include";
fi
if test x"$SYSTEMC_BASE" != x; then
  acjf_list="$acjf_list $SYSTEMC_BASE/include";
fi

ACJF_CHECK_HEADER(
  [SystemC], [
#include <systemc.h>
#define  main _main

int sc_main(int argc, char *argv[]) { return 0; }],
  [SC_MODULE(foo) { SC_CTOR(foo) {} } bar("bar")],
  [$acjf_list])

acjf_list=""
if test x"$WITH_SYSTEMC_LIB" != x; then
  acjf_list="$acjf_list $WITH_SYSTEMC_LIB";
fi
if test x"$WITH_SYSTEMC_BASE" != x; then
  acjf_list="$acjf_list `echo $WITH_SYSTEMC_BASE/lib*`";
fi
if test x"$SYSTEMC_BASE" != x; then
  acjf_list="$acjf_list `echo $SYSTEMC_BASE/lib*`";
fi

acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$acjf_CPPFLAGS $SYSTEMC_INCLUDE";
ACJF_CHECK_LIBONLY(
  [SystemC], [
#include <systemc.h>
#define  main _main

int sc_main(int argc, char *argv[]) { return 0; }],
  [SC_MODULE(foo) { SC_CTOR(foo) {} } bar("bar")],
  [systemc],
  [$acjf_list])
CPPFLAGS="$acjf_CPPFLAGS"

AC_LANG_POP
])
