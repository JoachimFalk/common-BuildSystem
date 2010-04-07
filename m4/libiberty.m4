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

AC_DEFUN([ACJF_INVESTIGATE_CCBASE],
[AC_CACHE_CHECK([for the $CC compiler base],
  [acjf_cv_path_ccbase],
  [acjf_cv_path_ccbase=`which $CC`;
   acjf_cv_path_ccbase="`dirname $acjf_cv_path_ccbase`/..";
   if test "x$host_alias" != "x"; then
     acjf_cv_path_ccbase="$acjf_cv_path_ccbase/$host_alias";
   fi])
])

dnl
dnl Add packages to the include and lib pathes
dnl
AC_DEFUN([ACJF_NEED_LIBIBERTY],
[AC_CHECK_LIB(iberty, libiberty_concat_ptr,
  [],
  [AC_MSG_ERROR([cannot find -liberty, bailing out])])
ACJF_INVESTIGATE_CCBASE
AC_CACHE_CHECK([for libiberty headers],
  [acjf_cv_includepath_libiberty],
  [if test -d "$includedir/libiberty"; then
    acjf_cv_includepath_libiberty="$(includedir)/libiberty";
  elif test -d "$acjf_cv_path_ccbase/include/libiberty"; then
    acjf_cv_includepath_libiberty="$acjf_cv_path_ccbase/include/libiberty";
  fi])
  if test x"$acjf_cv_includepath_libiberty" != x; then
    AM_CPPFLAGS="$AM_CPPFLAGS -I $acjf_cv_includepath_libiberty";
    AC_SUBST([AM_CPPFLAGS])dnl
  else
    AC_MSG_ERROR([cannot find libiberty headers, bailing out])
  fi
])
