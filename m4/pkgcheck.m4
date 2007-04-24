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

dnl ACJF_CHECK_HEADER(
dnl   <name of header check (pkgname)>,
dnl   <actual include directives>,
dnl   <code in main routine for compilation check>,
dnl   <header search list>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl IF header found defines: PKGNAME_INCLUDE
AC_DEFUN([ACJF_CHECK_HEADER],
[dnl
ACJF_M4_CANON_DN([$1])[_INCLUDE]=""
acjf_STDINC="standard include search path"
AC_MSG_CHECKING([for $1 headers])
AC_CACHE_VAL([acjf_cv_]ACJF_M4_CANON_DN([$1])_INCPATH,
 [acjf_CPPFLAGS="$CPPFLAGS";
  for acjf_include in $4 "$acjf_STDINC"; do
    if test x"$acjf_include" != x"$acjf_STDINC"; then
      CPPFLAGS="-I$acjf_include $acjf_CPPFLAGS"
    else
      CPPFLAGS="$acjf_CPPFLAGS"
    fi
    dnl AC_MSG_CHECKING([for $1 headers in $acjf_include])
    AC_TRY_COMPILE(
      [$2],
      [$3],
      [acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH="$acjf_include"; break],
      [acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH="x"])
  done
  CPPFLAGS="$acjf_CPPFLAGS";
  unset acjf_CPPFLAGS
])
if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]" != x"x"; then
  AC_MSG_RESULT([$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH])
  if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]" != x"$acjf_STDINC"; then
    ACJF_M4_CANON_DN([$1])[_INCLUDE]="[-I$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]"
  fi
  unset acjf_STDINC
  m4_if([$5], [],
   [true],
   [$5])
else
  unset acjf_STDINC
  m4_if([$6], [],
   [AC_MSG_ERROR([cannot find $1 headers, bailing out])],
   [AC_MSG_RESULT([no])
    $6])
fi
m4_pattern_allow(ACJF_M4_CANON_DN([$1])[_INCLUDE])dnl
AC_SUBST(ACJF_M4_CANON_DN([$1])[_INCLUDE])dnl
])

dnl ACJF_CHECK_LIBONLY(
dnl   <name of lib check (pkgname)>,
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib name>,
dnl   <lib search list>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl IF lib found defines: PKGNAME_LDFLAGS
AC_DEFUN([ACJF_CHECK_LIBONLY],
[dnl
ACJF_M4_CANON_DN([$1])[_LDFLAGS]=""
dnl acjf_CPPFLAGS="$CPPFLAGS";
acjf_STDLIB="standard library search path"
AC_MSG_CHECKING([for $1 library])
AC_CACHE_VAL([acjf_cv_]ACJF_M4_CANON_DN([$4])_LIBPATH, 
 [acjf_LDFLAGS="$LDFLAGS"; acjf_LIBS="$LIBS";
  for acjf_ldflags in $5 "$acjf_STDLIB"; do
    dnl CPPFLAGS="$SYSTEMC_INCLUDE $acjf_CPPFLAGS"
    if test x"$acjf_ldflags" != x"$acjf_STDLIB"; then
      LDFLAGS="-L$acjf_ldflags $acjf_LDFLAGS";
    else
      LDFLAGS="$acjf_LDFLAGS";
    fi
    LIBS="-l$4 $acjf_LIBS";
    dnl AC_MSG_CHECKING([for $1 library in $acjf_ldflags])
    AC_TRY_LINK(
      [$2],
      [$3],
      [acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH="$acjf_ldflags"; break],
      [acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH="x"])
  done
  dnl CPPFLAGS="$acjf_CPPFLAGS"; 
  LDFLAGS="$acjf_LDFLAGS"; LIBS="$acjf_LIBS";
  unset acjf_LDFLAGS
  unset acjf_LIBS
])
if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]" != x"x"; then
  AC_MSG_RESULT([$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH])
  if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]" != x"$acjf_STDLIB"; then
    ACJF_M4_CANON_DN([$1])[_LDFLAGS]="[-L$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]"
  fi
  unset acjf_STDLIB
  m4_if([$6], [],
   [true],
   [$6])
else
  unset acjf_STDLIB
  m4_if([$7], [],
   [AC_MSG_ERROR([cannot find $1 library, bailing out])],
   [AC_MSG_RESULT([no])
    $7])
fi
m4_pattern_allow(ACJF_M4_CANON_DN([$1])[_LDFLAGS])dnl
AC_SUBST(ACJF_M4_CANON_DN([$1])[_LDFLAGS])dnl
])

dnl Add packages to the include and lib pathes
dnl ACJF_CHECK_PKG(
dnl   <packet>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_LDFLAGS
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
AC_DEFUN([ACJF_CHECK_PKG],
 [AC_REQUIRE([ACJF_INIT])dnl
  AC_MSG_CHECKING([for $1 package in source tree])
  [acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])="";
dnl AC_CACHE_VAL([acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1]),
dnl [# Searching $1 subproject
    m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
    ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
     [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
      if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])" = x"" -a -d $srcdir/_ACJF_VAR_DIR/$1; then
        [acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])="_ACJF_VAR_DIR/$1";
      fi
    ])dnl
    m4_popdef([_ACJF_VAR_DIR])dnl
    # Last ditch effort try one uplevel directory
    if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])" = x"" -a -d $srcdir/../$1; then
      [acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])="../$1";
    fi
dnl  ])
  if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])" != x""; then
    AC_MSG_RESULT([[$acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])])
    [pkg_]ACJF_M4_CANON_DC([$1])[_srcdir]="$acjf_top_srcdir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])";
    [pkg_]ACJF_M4_CANON_DC([$1])[_builddir]="$acjf_top_builddir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])";
    if test -d "$srcdir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])/pkginclude"; then
      ACJF_M4_CANON_DN([$1])[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC([$1])[_builddir]/pkginclude -I$[pkg_]ACJF_M4_CANON_DC([$1])[_srcdir]/pkginclude"
    else
      ACJF_M4_CANON_DN([$1])[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC([$1])[_builddir]/include -I$[pkg_]ACJF_M4_CANON_DC([$1])[_srcdir]"
    fi
    ACJF_M4_CANON_DN([$1])[_LDFLAGS]="-L$[pkg_]ACJF_M4_CANON_DC([$1])[_builddir]"
    m4_if([$2], [], 
     [true;],
     [$2])
  else
    unset [pkg_]ACJF_M4_CANON_DC([$1])[_srcdir];
    unset [pkg_]ACJF_M4_CANON_DC([$1])[_builddir];
    unset ACJF_M4_CANON_DN([$1])[_INCLUDE];
    unset ACJF_M4_CANON_DN([$1])[_LDFLAGS];
    m4_if([$3], [],
     [AC_MSG_ERROR([cannot find $1 package in source tree, bailing out])],
     [AC_MSG_RESULT([no])
      $3])
  fi
  m4_pattern_allow(ACJF_M4_CANON_DN([$1])[_INCLUDE])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN([$1])[_LDFLAGS])dnl
  m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
    ACJF_M4_LIST_PUSH_BACK(ACJF_M4_ARGSTOLIST(
      ACJF_M4_CANON_DN([$1])[_INCLUDE],
      ACJF_M4_CANON_DN([$1])[_LDFLAGS],
      [pkg_]ACJF_M4_CANON_DC([$1])[_srcdir],
      [pkg_]ACJF_M4_CANON_DC([$1])[_builddir]),
    ACJF_VAR_SUBSTVARFIXUP)))dnl
])

dnl Add packages to the include and lib pathes
dnl ACJF_NEED_PKG(<packet>)
dnl Take the same actions as ACJF_CHECK_PKG but also adds
dnl PKGNAME_INCLUDE to AM_CPPFLAGS and
dnl PGKNAME_LDFLAGS to AM_LDFLAGS
AC_DEFUN([ACJF_NEED_PKG],
 [m4_if([$2$3], [], [], [m4_errprint(
[Action if yes and action if no arguments for ACJF_NEED_PKG are obsolete,
please use ACJF_CHECK_PKG!
])m4_exit([-1])])dnl
  ACJF_CHECK_PKG([$1],
  [AM_CPPFLAGS="$AM_CPPFLAGS $[]ACJF_M4_CANON_DN([$1])[_INCLUDE]"
   AM_LDFLAGS="$AM_LDFLAGS $[]ACJF_M4_CANON_DN([$1])[_LDFLAGS]"
   AC_SUBST([AM_CPPFLAGS])
   AC_SUBST([AM_LDFLAGS])])dnl
])
