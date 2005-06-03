dnl vim: set sw=2 ts=8 syn=config:
dnl
dnl Copyright (C) Joachim Falk <joachim.falk@gmx.de> $Date: 2003/01/24 13:23:54 $
dnl
dnl boost.m4 is part of the SysteMoC distribution of Joachim Falk;
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

dnl ACJF_ARG_DEBUG(<default yes|no>,
dnl		   <CFLAG option added if yes>,
dnl		   <CFLAG option added if no>)
AC_DEFUN([ACJF_CHECK_LIB_BOOST],
[dnl
AC_LANG_PUSH([C++])
WITH_BOOST_INCLUDE=
WITH_BOOST_LIB=
WITH_BOOST_BASE=
AC_ARG_WITH(boost-include,
  [  --with-boost-include  Path to Boost include directory],
  [WITH_BOOST_INCLUDE="$withval"])
  
AC_ARG_WITH(boost-lib,
  [  --with-boost-lib      Path to Boost lib directory],
  [WITH_BOOST_LIB="$withval"])

if test x"$WITH_BOOST_INCLUDE" != "x"; then
  WITH_BOOST_BASE=`echo $WITH_BOOST_INCLUDE | sed -e 's@^\(.*\)[/\\]include[/\\].*$@\1@'`
elif test x"$WITH_BOOST_LIB" != "x"; then
  WITH_BOOST_BASE=`echo $WITH_BOOST_LIB | sed -e 's@^\(.*\)[/\\]lib[/\\].*$@\1@'`
fi
  
acjf_list=""
if test x"$WITH_BOOST_INCLUDE" != x; then
  acjf_list="$acjf_list $WITH_BOOST_INCLUDE";
fi
if test x"$WITH_BOOST_BASE" != x; then
  acjf_list="$acjf_list $WITH_BOOST_BASE/include";
fi
if test x"$BOOST_BASE" != x; then
  acjf_list="$acjf_list $BOOST_BASE/include";
fi
acjf_list="`pwd` $acjf_list"

ACJF_CHECK_HEADER(
  [boost],
  [#include <boost/config.hpp>],
  [#ifndef BOOST_CONFIG_HPP
   # error "not boost"
   #endif],
  [$acjf_list])

acjf_LDFLAGS="$LDFLAGS"; acjf_CPPFLAGS="$CPPFLAGS"; acjf_found=no
acjf_list=""
if test x"$WITH_BOOST_LIB" != x; then
  acjf_list="$acjf_list $WITH_BOOST_LIB";
fi
if test x"$WITH_BOOST_BASE" != x; then
  acjf_list="$acjf_list $WITH_BOOST_BASE/lib";
fi
if test x"$BOOST_BASE" != x; then
  acjf_list="$acjf_list $BOOST_BASE/lib";
fi
acjf_list="$acjf_list `pwd`"
for acjf_ldflags in $acjf_list; do
  for acjf_postfix in "" "-gcc"; do
    CPPFLAGS="$acjf_CPPFLAGS $BOOST_INCLUDE"
    LDFLAGS="$acjf_LDFLAGS -L$acjf_ldflags -lboost_regex$acjf_postfix"
    AC_MSG_CHECKING([for -lboost_regex$acjf_postfix in $acjf_ldflags])
    AC_TRY_LINK(
      [#include <boost/regex.hpp>],
      [boost::regex_constants::match_flag_type x;],
      [AC_MSG_RESULT([yes])
       BOOST_LDFLAGS="-L$acjf_ldflags"
       BOOST_LIBPOSTFIX="$acjf_postfix"
       acjf_found=yes
       break],
      [AC_MSG_RESULT([no])])
  done
  if test x"$acjf_found" = x"yes"; then
    break
  fi
done
LDFLAGS="$acjf_LDFLAGS"; CPPFLAGS="$acjf_CPPFLAGS"
if test $acjf_found = no; then
  AC_MSG_ERROR([cannot find Boost library, bailing out])
fi
AC_SUBST([BOOST_LDFLAGS])
AC_SUBST([BOOST_LIBPOSTFIX])

AC_LANG_POP
])
