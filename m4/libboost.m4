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
[ACJF_ARG_WITHPKG([boost], [])
AC_LANG_PUSH([C++])
acjf_var_found_pkg=""
ACJF_M4_FOREACH([ACJF_VAR_BOOSTMTPOSTFIX], [[],[-mt]], [dnl
  ACJF_M4_FOREACH([ACJF_VAR_BOOSTPOSTFIX], [[],[-gcc],[-gcc44],[-gcc43],[-gcc42],[-gcc41],[-gcc40],[-gcc34],[-gcc33],[-xlc]], [dnl
dnl echo "[-lboost]ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX)ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX): $acjf_var_found_pkg"
    if test x"$acjf_var_found_pkg" = x""; then
      ACJF_CHECK_HEADER_AND_LIB(
        [boost],
        [], [
#include <boost/config.hpp>
#include <boost/regex.hpp>
        ], [
#ifndef BOOST_CONFIG_HPP
# error "not boost"
#endif
boost::regex_constants::match_flag_type x;
        ],
        [boost_regex]ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX)ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX),
        [acjf_var_found_pkg="yes";
         BOOST_LIBPOSTFIX="ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTPOSTFIX)ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX)";],
        [false;])
    fi
  ])
])
if test x"$acjf_var_found_pkg" = x"yes"; then
  unset acjf_var_found_pkg
fi
ACJF_M4_FOREACH([ACJF_VAR_BOOSTMTPOSTFIX], [[$BOOST_LIBPOSTFIX],[$BOOST_LIBPOSTFIX-mt]], [dnl
  if test x"$acjf_var_found_pkg" = x""; then
    acjf_CPPFLAGS="$CPPFLAGS"
    CPPFLAGS="$BOOST_INCLUDE $CPPFLAGS"
    ACJF_CHECK_LIBONLY(
      [boost multithreaded version],
      [#include <boost/thread.hpp>

       void dummy() { return; }],
      [boost::thread th(dummy);
       th.join();],
      [boost_thread]ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX),
      [$BOOST_LIBPATH],
      [acjf_var_found_pkg="yes";
       BOOST_LIBMTPOSTFIX="ACJF_M4_UNQUOTE(ACJF_VAR_BOOSTMTPOSTFIX)";],
      [false;])
    CPPFLAGS="$acjf_CPPFLAGS"
    unset acjf_CPPFLAGS
  fi
])
AC_LANG_POP

if test x"$acjf_var_found_pkg" = x"yes"; then
  unset acjf_var_found_pkg
  m4_if([$1], [], [true;], [$1])
else
  unset acjf_var_found_pkg
  m4_if([$2], [], [AC_MSG_ERROR([Cannot find boost, bailing out!])], [$2])
fi

AC_SUBST([BOOST_LIBPOSTFIX])
AC_SUBST([BOOST_LIBMTPOSTFIX])
])
