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
    AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[$2]],
         [[$3]])],
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
    AC_LINK_IFELSE(
      [AC_LANG_PROGRAM([[$2]],
         [[$3]])],
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

dnl OBSOLETE ACJF_CHECK_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
dnl
dnl <srcdir subdirectory name> will be set to <pkgname>
dnl
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_LDFLAGS
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl
dnl NEW ACJF_CHECK_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl   <srcdir subdirectory name>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_LDFLAGS
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
AC_DEFUN([ACJF_CHECK_PKG],
 [AC_REQUIRE([ACJF_INIT])dnl
  m4_if(
    m4_if(m4_eval([$#<=1]), [1],
      [[old]],
      [m4_if(m4_bregexp([$2], [[=;]\|^$]), [-1], [[new]], [[old]])]),
    [old],
    [# OBSOLETE USAGE
     m4_pushdef([ACJF_VAR_PKGNAME], [$1])
     m4_pushdef([ACJF_VAR_SUBDIR], [$1])
     m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [$2])
     m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [$3])],
    [# NEW USAGE
     m4_pushdef([ACJF_VAR_PKGNAME], [$1])
     m4_pushdef([ACJF_VAR_SUBDIR], [$2])
     m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [$3])
     m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [$4])])
  AC_MSG_CHECKING([for ACJF_VAR_PKGNAME package in subdir ACJF_VAR_SUBDIR of source tree])
  if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])" = x""; then
    [acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])="/invalid";
dnl AC_CACHE_VAL([acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1]),
dnl [# Searching $1 subproject
    m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
    ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
     [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
      if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"/invalid" -a \
              -d "$srcdir/_ACJF_VAR_DIR/ACJF_VAR_SUBDIR"; then
        [acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="_ACJF_VAR_DIR/ACJF_VAR_SUBDIR";
      fi
    ])dnl
    m4_popdef([_ACJF_VAR_DIR])dnl
    # Last ditch effort try one uplevel directory
    if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"/invalid" -a \
            -d "$srcdir/../ACJF_VAR_SUBDIR"; then
      [acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="../ACJF_VAR_SUBDIR";
    fi
dnl  ])
  fi
  if test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" != x"/invalid"; then
    AC_MSG_RESULT([[$acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)])
    [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]="$acjf_top_srcdir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)";
    [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]="$acjf_top_builddir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)";
    if test -d "$srcdir/$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)/pkginclude"; then
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/pkginclude -I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]/pkginclude"
    else
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/include -I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]"
    fi
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]="-L$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]"
    m4_if([ACJF_VAR_CODE_IF_TRUE], [], 
     [true;],
     ACJF_VAR_CODE_IF_TRUE)
  else
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir];
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS];
    m4_if([ACJF_VAR_CODE_IF_FALSE], [],
     [AC_MSG_ERROR([cannot find ACJF_VAR_PKGNAME package in subdir ACJF_VAR_SUBDIR of source tree, bailing out])],
     [AC_MSG_RESULT([no])
      ACJF_VAR_CODE_IF_FALSE])
  fi
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
  m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
    ACJF_M4_LIST_PUSH_BACK(ACJF_M4_ARGSTOLIST(
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]),
    ACJF_VAR_SUBSTVARFIXUP)))dnl
  m4_popdef([ACJF_VAR_PKGNAME])
  m4_popdef([ACJF_VAR_SUBDIR])
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])
])

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

dnl ACJF_CHECK_LIB(
dnl   <name of lib check (pkgname)>,
dnl   <possible location in source tree>,
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib name>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl IF lib found defines: PKGNAME_INCLUDE, PKGNAME_LDFLAGS
AC_DEFUN([ACJF_CHECK_LIB],
[dnl
[WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE]=""
[WITH_]ACJF_M4_CANON_DN([$1])[_LIB]=""
[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]=""

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1]),
  [  --with-]ACJF_M4_DOWNCASE([$1])[         Installation directory of $1],
  [WITH_]ACJF_M4_CANON_DN([$1])[_BASE="$withval"])

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-include],
  [  --with-]ACJF_M4_DOWNCASE([$1])[-include Path to $1 include directory],
  [WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE="$withval"])

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-lib],
  [  --with-]ACJF_M4_DOWNCASE([$1])[-lib     Path to $1 lib directory],
  [WITH_]ACJF_M4_CANON_DN([$1])[_LIB="$withval"])

if test x"$[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]" = "x"; then
  if echo "$[WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE]" | grep "[[/\\]]include[[/\\]]*$" 1>/dev/null; then
    [WITH_]ACJF_M4_CANON_DN([$1])[_BASE]=`dirname "$[WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE]"`;
    unset [WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE]
  elif echo "$[WITH_]ACJF_M4_CANON_DN([$1])[_LIB]" | grep "[[/\\]]lib[[/\\]]*$" 1>/dev/null; then
    [WITH_]ACJF_M4_CANON_DN([$1])[_BASE]=`dirname "$[WITH_]ACJF_M4_CANON_DN([$1])[_LIB]"`;
    unset [WITH_]ACJF_M4_CANON_DN([$1])[_LIB]
  fi
fi

m4_if([$2], [], [], [acjf_use_intern=""])
acjf_list_includedir=""
acjf_list_libdir=""
if test x"[$]ACJF_M4_CANON_DN([$1])[_BASE]" != x; then
  m4_if([$2], [], [], [dnl
  if test x"[$]ACJF_M4_CANON_DN([$1])[_BASE]" != x"intern"; then
    acjf_use_intern="no";])
    acjf_list_includedir="[$]ACJF_M4_CANON_DN([$1])[_BASE]/include $acjf_list_includedir";
    acjf_list_libdir="[$]ACJF_M4_CANON_DN([$1])[_BASE]/lib $acjf_list_libdir";
  m4_if([$2], [], [], [dnl
  else
    acjf_use_intern="yes";
  fi])
fi
if test x"$[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]" != x; then
  m4_if([$2], [], [], [dnl
  if test x"$[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]" != x"intern"; then
    acjf_use_intern="no";])
    acjf_list_includedir="$[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]/include $acjf_list_includedir";
    acjf_list_libdir="$[WITH_]ACJF_M4_CANON_DN([$1])[_BASE]/lib $acjf_list_libdir";
  m4_if([$2], [], [], [dnl
  else
    acjf_use_intern="yes";
  fi])
fi
if test x"$[WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE]" != x; then
  m4_if([$2], [], [], [acjf_use_intern="no"])
  acjf_list_includedir="$[WITH_]ACJF_M4_CANON_DN([$1])[_INCLUDE] $acjf_list_includedir";
fi
if test x"$[WITH_]ACJF_M4_CANON_DN([$1])[_LIB]" != x; then
  m4_if([$2], [], [], [acjf_use_intern="no"])
  acjf_list_libdir="$[WITH_]ACJF_M4_CANON_DN([$1])[_LIB] $acjf_list_libdir";
fi

acjf_found_pkg=""
m4_if([$2], [], [], [dnl
if test x"$acjf_use_intern" != x"no"; then
  ACJF_CHECK_PKG([$2],
    [acjf_found_pkg="yes"],
    [acjf_found_pkg=""])
fi
m4_pattern_allow([PKG_]ACJF_M4_CANON_DN([$1])[_USE_SRCDIR_VERSION])
AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN([$1])[_USE_SRCDIR_VERSION],
  test x"$[acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1])" != x"/invalid")
if test x"$acjf_use_intern" != x"yes" -a x"$acjf_found_pkg" != x"yes"; then
])
  ACJF_CHECK_HEADER([$1], [$3], [$4], [$acjf_list_includedir],
    [acjf_found_pkg=""],
    [acjf_found_pkg="no"])
  if test x"$acjf_found_pkg" != x"no"; then
    acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$acjf_CPPFLAGS $COSUPPORT_INCLUDE";
    ACJF_CHECK_LIBONLY([$1], [$3], [$4], [$5], [$acjf_list_libdir],
      [acjf_found_pkg="yes"],
      [acjf_found_pkg="no"])
    CPPFLAGS="$acjf_CPPFLAGS"
  fi
m4_if([$2], [], [], [fi])
if test x"$acjf_found_pkg" = x"yes"; then
  m4_if([$6], [], 
   [true;],
   [$6])
else
  m4_if([$7], [],
   [AC_MSG_ERROR([Cannot find $1 package, bailing out!])],
   [$7])
fi
])
