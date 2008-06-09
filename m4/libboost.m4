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

dnl ACJF_CHECK_LIBBOOST(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_BOOST],
[AC_LANG_PUSH([C++])
ACJF_ARG_WITHPKG([boost], [])

acjf_found_pkg=""
if test x"$acjf_found_pkg" != x"no"; then
  ACJF_CHECK_HEADER(
    [boost],
    [#include <boost/config.hpp>],
    [#ifndef BOOST_CONFIG_HPP
     # error "not boost"
     #endif],
    [$acjf_boost_search_includedirs],
    [acjf_found_pkg=""],
    [acjf_found_pkg="no"])
fi
if test x"$acjf_found_pkg" = x"no"; then
  m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost headers, bailing out!])], [true;])
fi
acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$acjf_CPPFLAGS $BOOST_INCLUDE";
ACJF_M4_FOREACH([ACJF_VAR_BOOSTPOSTFIX], [[-gcc41],[-gcc],[]], [dnl
  if test x"$acjf_found_pkg" = x""; then
dnl  m4_if(
dnl    ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX), [],
dnl    [[]],
dnl    [[, with ]ACJF_VAR_BOOSTPOSTFIX[ postfix]])
    ACJF_CHECK_LIBONLY(
      [boost],
      [#include <boost/regex.hpp>],
      [boost::regex_constants::match_flag_type x;],
      [boost_regex]ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX),
      [$acjf_boost_search_libdirs],
      [acjf_found_pkg="yes";
       BOOST_LIBPOSTFIX="ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX)";],
      [false;])
  fi
])
if test x"$acjf_found_pkg" = x""; then
  acjf_found_pkg="no";
  m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost library, bailing out!])], [])
else
  acjf_found_pkg="";
fi
ACJF_M4_FOREACH([ACJF_VAR_BOOSTMTPOSTFIX], [[$BOOST_LIBPOSTFIX],[$BOOST_LIBPOSTFIX-mt]], [dnl
  if test x"$acjf_found_pkg" = x""; then
dnl  m4_if(
dnl    ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX), [],
dnl    [[]],
dnl    [[, with ]ACJF_VAR_BOOSTMTPOSTFIX[ postfix]])
    ACJF_CHECK_LIBONLY(
      [boost multithreaded version],
      [#include <boost/thread.hpp>

       void dummy() { return; }],
      [boost::thread th(dummy);
       th.join();],
      [boost_thread]ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX),
      [$BOOST_LIBPATH],
      [acjf_found_pkg="yes";
       BOOST_LIBMTPOSTFIX="ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX)";],
      [false;])
  fi
])
if test x"$acjf_found_pkg" = x""; then
  acjf_found_pkg="no";
  m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost multithreaded version library, bailing out!])], [])
else
  acjf_found_pkg="yes";
fi
CPPFLAGS="$acjf_CPPFLAGS"
unset acjf_CPPFLAGS

AC_SUBST([BOOST_LIBPOSTFIX])
AC_SUBST([BOOST_LIBMTPOSTFIX])
AC_LANG_POP

if test x"$acjf_found_pkg" = x"yes"; then
  m4_if([$1], [], [true;], [$1])
else
  m4_if([$2], [], [true;], [$2])
fi
unset acjf_found_pkg
])
