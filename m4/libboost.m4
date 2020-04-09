dnl vim: set sw=2 ts=8 syn=config:
dnl Copyright (C) 2001 - 2013 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_CHECK_LIB_BOOSTTESTMACRO(
dnl  <name of lib check (pkgname)>,
dnl  <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default does nothing>]])
AC_DEFUN([ACJF_CHECK_LIB_BOOSTTESTMACRO], [
acjf_var_boost_old_LIBS="$LIBS"
acjf_var_found_pkg_st=""
acjf_var_found_pkg_mt=""
for acjf_var_boostversion in "" "-1_67" "-1_66" "-1_65"; do
  for acjf_var_boostpostfix in "" "-gcc" "-gcc84" "-gcc83" "-gcc82" "-gcc75" "-gcc74" "-gcc73"; do
    for acjf_var_boostmtpostfix in "" "-mt"; do
dnl   echo "-lboost${acjf_var_boostpostfix}${acjf_var_boostmtpostfix}${acjf_var_boostversion}: $acjf_var_found_pkg"
      if test x"$acjf_var_found_pkg_st" != x"yes"; then
        acjf_cv_boost_libpostfix="${acjf_var_boostpostfix}${acjf_var_boostmtpostfix}${acjf_var_boostversion}"
        LIBS="-lboost_regex$acjf_cv_boost_libpostfix $acjf_var_boost_old_LIBS"
        if test x"$acjf_cv_boost_libpostfix" != x""; then
          AC_MSG_CHECKING([for $1 (>= 1.48) package in ${$2_desc} with library postfix $acjf_cv_boost_libpostfix])
        else
          AC_MSG_CHECKING([for $1 (>= 1.48) package in ${$2_desc}])
        fi
        AC_LINK_IFELSE([AC_LANG_PROGRAM([[
#include <boost/version.hpp>
#include <boost/regex.hpp>
          ]], [[
#if !defined(BOOST_VERSION) || BOOST_VERSION < 104500
# error "not boost or boost too old!"
#endif
boost::regex_constants::match_flag_type x;
          ]])],
          [AC_MSG_RESULT([yes]); acjf_var_found_pkg_st="yes"],
          [AC_MSG_RESULT([no])])
      fi
      if test x"$acjf_var_found_pkg_st" = x"yes" -a \
              x"$acjf_var_found_pkg_mt" != x"yes"; then
        acjf_cv_boost_libmtpostfix="${acjf_var_boostpostfix}${acjf_var_boostmtpostfix}${acjf_var_boostversion}"
        LIBS="-lboost_thread$acjf_cv_boost_libmtpostfix -lboost_system$acjf_cv_boost_libmtpostfix $acjf_var_boost_old_LIBS"
        CPPFLAGS="${CPPFLAGS} -pthread"
        if test x"$acjf_cv_boost_libmtpostfix" != x""; then
          AC_MSG_CHECKING([for $1 multithreading support in ${$2_desc} with library postfix $acjf_cv_boost_libmtpostfix])
        else
          AC_MSG_CHECKING([for $1 multithreading support in ${$2_desc}])
        fi
        AC_LINK_IFELSE([AC_LANG_PROGRAM([[
#include <boost/version.hpp>
#include <boost/thread.hpp>
void dummy() { return; }
          ]], [[
#if !defined(BOOST_VERSION) || BOOST_VERSION < 104800
# error "not boost or boost too old!"
#endif
boost::thread th(dummy);
th.join();
          ]])],
          [AC_MSG_RESULT([yes]); acjf_var_found_pkg_mt="yes"],
          [AC_MSG_RESULT([no])])
      fi
    done
    if test x"$acjf_var_found_pkg_st" != x"yes" -o \
            x"$acjf_var_found_pkg_mt" != x"yes"; then
      acjf_var_found_pkg_st=""
      acjf_var_found_pkg_mt=""
    fi
  done
done
LIBS="$acjf_var_boost_old_LIBS"
unset acjf_var_boost_old_LIBS
if test x"$acjf_var_found_pkg_st" = x"yes"; then
  unset acjf_var_found_pkg_st
  unset acjf_var_found_pkg_mt
  if test x"$acjf_cv_boost_libpostfix" != x""; then
    [$2_desc="${$2_desc} with $acjf_cv_boost_libpostfix library postfix"]
    if test x"$acjf_cv_boost_libmtpostfix" != x"$acjf_cv_boost_libpostfix"; then
      [$2_desc="${$2_desc} ($acjf_cv_boost_libmtpostfix for multithreading)"]
    fi
  else
    if test x"$acjf_cv_boost_libmtpostfix" != x""; then
      [$2_desc="${$2_desc} with $acjf_cv_boost_libmtpostfix multithreading library postfix"]
    fi
  fi
  m4_if([$3], [], [true], [$3])
else
  unset acjf_var_found_pkg_st
  unset acjf_var_found_pkg_mt
  m4_if([$4], [], [false], [$4])
fi
])

dnl ACJF_CHECK_LIBBOOST(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_BOOST], [
  ACJF_ARG_WITHPKG([boost], [])
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([boost], [],
    [ACJF_CHECK_LIB_BOOSTTESTMACRO],
    [acjf_var_found_pkg=yes],
    [acjf_var_found_pkg=no])
  if test x"$acjf_var_found_pkg" = x"yes"; then
    unset acjf_var_found_pkg
    BOOST_LIBPOSTFIX="$acjf_cv_boost_libpostfix"
    BOOST_LIBMTPOSTFIX="$acjf_cv_boost_libmtpostfix"
dnl acjf_oldCPPFLAGS=$CPPFLAGS
dnl CPPFLAGS="${CPPFLAGS} ${BOOST_INCLUDE}"
dnl AC_PREPROC_IFELSE([AC_LANG_PROGRAM([
dnl #include <boost/filesystem.hpp>
dnl #if BOOST_FILESYSTEM_VERSION < 3
dnl # error "old boost filesystem"
dnl #endif
dnl  ], [
dnl  ])],
dnl  [BOOST_LIBBOOST_FILESYSTEM="-lboost_filesystem$acjf_cv_boost_libpostfix"
dnl   BOOST_LIBMTBOOST_FILESYSTEM="-lboost_filesystem$acjf_cv_boost_libmtpostfix"])
dnl CPPFLAGS=${acjf_oldCPPFLAGS}
    m4_if([$1], [], [true;], [$1])
  else
    unset acjf_var_found_pkg
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find boost, bailing out!])],
      [m4_if([$2], [], [true;], [$2])])
  fi
  AC_LANG_POP
  AC_SUBST([BOOST_LIBPOSTFIX])
  AC_SUBST([BOOST_LIBMTPOSTFIX])
dnl AC_SUBST([BOOST_LIBBOOST_FILESYSTEM])
dnl AC_SUBST([BOOST_LIBMTBOOST_FILESYSTEM])
])
