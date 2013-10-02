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

dnl ACJF_CHECK_LIB_XERCESTESTMACRO(
dnl  <name of lib check (pkgname)>,
dnl  <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default does nothing>]])
AC_DEFUN([ACJF_CHECK_LIB_XERCESTESTMACRO], [
acjf_var_xerces_old_LIBS="$LIBS"
acjf_var_found_pkg=""

for acjf_var_pthreadaux in "" "-lpthread"; do
  if test x"$acjf_var_found_pkg" = x""; then
    acjf_cv_xerces_auxlibs="${acjf_var_pthreadaux}"
    LIBS="-lxerces-c $acjf_cv_xerces_auxlibs $acjf_var_xerces_old_LIBS"
    if test x"$acjf_cv_xerces_auxlibs" != x""; then
      AC_MSG_CHECKING([for $1 libraray in $$2 with auxiliary library $acjf_cv_xerces_auxlibs])
    else
      AC_MSG_CHECKING([for $1 libraray in $$2])
    fi
    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
#include <xercesc/util/PlatformUtils.hpp>
      ]], [[
xercesc::XMLPlatformUtils::Initialize();
      ]])],
      [AC_MSG_RESULT([yes]); acjf_var_found_pkg="yes"],
      [AC_MSG_RESULT([no])])
  fi
done
LIBS="$acjf_var_xerces_old_LIBS"
unset acjf_var_xerces_old_LIBS
if test x"$acjf_var_found_pkg" = x"yes"; then
  unset acjf_var_found_pkg
  if test x"$acjf_cv_xerces_auxlibs" != x""; then
    $2="$$2 with auxiliary library $acjf_cv_xerces_auxlibs"
  fi
  m4_if([$3], [], [true], [$3])
else
  unset acjf_var_found_pkg
  m4_if([$4], [], [false], [$4])
fi
])

dnl ACJF_CHECK_LIBXERCES(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
AC_DEFUN([ACJF_CHECK_LIB_XERCES], [
  ACJF_ARG_WITHPKG([xerces], [])
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([xerces], [],
    [ACJF_CHECK_LIB_XERCESTESTMACRO],
    [acjf_var_found_pkg=yes],
    [acjf_var_found_pkg=no])
  AC_LANG_POP
  if test x"$acjf_var_found_pkg" = x"yes"; then
    unset acjf_var_found_pkg
    XERCES_AUXLIBS="$acjf_cv_xerces_auxlibs"
    m4_if([$1], [], [true;], [$1])
  else
    unset acjf_var_found_pkg
    m4_if([$1$2], [], [AC_MSG_ERROR([Cannot find xerces library, bailing out!])],
      [m4_if([$2], [], [true;], [$2])])
  fi
  AC_SUBST([XERCES_AUXLIBS])
])
