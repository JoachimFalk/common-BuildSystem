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
dnl   <name of header check>,
dnl   <actual include directives>,
dnl   <code in main routine for compilation check>,
dnl   <header search list>,
dnl   <code if found>,
dnl   <code if not found>)
AC_DEFUN([ACJF_CHECK_HEADER],
[dnl
ACJF_M4_CANON_DN([$1])_INCLUDE=""
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
      [dnl AC_MSG_RESULT([yes])
       acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH="$acjf_include";
       break],
      [dnl AC_MSG_RESULT([no])
       acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH="x"])
  done
  CPPFLAGS="$acjf_CPPFLAGS";
])
if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]" != x"x"; then
  AC_MSG_RESULT([$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH])
  if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]" != x"$acjf_STDINC"; then
    ACJF_M4_CANON_DN([$1])_INCLUDE="[-I$acjf_cv_]ACJF_M4_CANON_DN([$1])[_INCPATH]"
  fi
  m4_if([$5], [],
   [true],
   [$5])
else
  m4_if([$6], [],
   [AC_MSG_ERROR([cannot find $1 headers, bailing out])],
   [AC_MSG_RESULT([no])
    $6])
fi
AC_SUBST(ACJF_M4_CANON_DN([$1])_INCLUDE)
])

dnl ACJF_CHECK_LIBONLY(
dnl   <name of lib check>,
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib name>,
dnl   <lib search list>,
dnl   <code if found>,
dnl   <code if not found>)
AC_DEFUN([ACJF_CHECK_LIBONLY],
[dnl
ACJF_M4_CANON_DN([$1])_LDFLAGS=""
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
      [dnl AC_MSG_RESULT([yes])
       acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH="$acjf_ldflags";
       break],
      [dnl AC_MSG_RESULT([no])
       acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH="x"])
  done
  dnl CPPFLAGS="$acjf_CPPFLAGS"; 
  LDFLAGS="$acjf_LDFLAGS"; LIBS="$acjf_LIBS";
])
if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]" != x"x"; then
  AC_MSG_RESULT([$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH])
  if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]" != x"$acjf_STDLIB"; then
    ACJF_M4_CANON_DN([$1])_LDFLAGS="[-L$acjf_cv_]ACJF_M4_CANON_DN([$4])[_LIBPATH]"
  fi
  m4_if([$6], [],
   [true],
   [$6])
else
  m4_if([$7], [],
   [AC_MSG_ERROR([cannot find $1 library, bailing out])],
   [AC_MSG_RESULT([no])
    $7])
fi
AC_SUBST(ACJF_M4_CANON_DN([$1])[_LDFLAGS])
])

dnl Add packages to the include and lib pathes
dnl ACJF_NEED_PKG(<packet>,
dnl		  [<action if yes>],
dnl		  [<action if no> ])
AC_DEFUN([ACJF_NEED_PKG],
 [m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
  # Searching $1 subproject
  _acjf_found=no
  ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
   [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
    if test x"$_acjf_found" = x"no" -a -d $srcdir/_ACJF_VAR_DIR/$1; then
      acjf_pkgdir="_ACJF_VAR_DIR/$1";
      _acjf_found=yes;
    fi
  ])dnl
  m4_popdef([_ACJF_VAR_DIR])dnl
  # Last ditch effort try one uplevel directory
  if test x"$_acjf_found" = x"no" -a -d $srcdir/../$1; then
    acjf_pkgdir="../$1";
    _acjf_found=yes;
  fi
  if test x"$_acjf_found" = x"yes"; then
    acjf_pkg_srcdir="\$(top_srcdir)/$acjf_pkgdir";
    acjf_pkg_builddir="\$(top_builddir)/$acjf_pkgdir";
    [pkg_]ACJF_M4_CANON_DC([$1])[_srcdir]="$acjf_pkg_srcdir";
    [pkg_]ACJF_M4_CANON_DC([$1])[_builddir]="$acjf_pkg_builddir";
    AC_SUBST([pkg_]ACJF_M4_CANON_DC([$1])[_srcdir])dnl
    AC_SUBST([pkg_]ACJF_M4_CANON_DC([$1])[_builddir])dnl
    m4_if([$2], [], [dnl
      if test -d "$srcdir/$acjf_pkgdir/pkginclude"; then
        AM_CPPFLAGS="$AM_CPPFLAGS -I\$(top_srcdir)/$acjf_pkgdir/pkginclude";
      else
        AM_CPPFLAGS="$AM_CPPFLAGS -I\$(top_srcdir)/$acjf_pkgdir -I\$(top_builddir)/$acjf_pkgdir/include";
      fi
      AM_LDFLAGS="$AM_LDFLAGS -L\$(top_builddir)/$acjf_pkgdir";
      AC_SUBST([AM_CPPFLAGS])dnl
      AC_SUBST([AM_LDFLAGS])], [$2])
  else
    m4_if([$3], [], [false], [$3])
  fi
  unset _acjf_found
])
