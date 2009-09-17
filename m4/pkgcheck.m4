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

dnl ACJF_ARG_WITHPKG(
dnl   <pkgname>,
dnl   <possible location in source tree>)
dnl set shell vars
dnl   acjf_<pkgname>_search_list
dnl   acjf_<pkgname>_use_srcdir_version
AC_DEFUN([ACJF_ARG_WITHPKG], [AC_REQUIRE([ACJF_INIT])dnl
[acjf_]ACJF_M4_CANON_DC([$1])[_search_list]=""
m4_if([$2], [], [], [[acjf_]ACJF_M4_CANON_DC([$1])[_use_srcdir_version]=""])

[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]=""
[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]=""
[acjf_with_]ACJF_M4_CANON_DC([$1])=""

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1]), AS_HELP_STRING(
  [--with-]ACJF_M4_DOWNCASE([$1]), m4_if([$2], [], 
    [[prefix path for $1 or no to disable]],
    [[prefix path for $1, no to disable, extern to force installed library usage, or intern to force bundled package]])),
  [acjf_with_]ACJF_M4_CANON_DC([$1])[="$withval"])

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-include], AS_HELP_STRING(
  [--with-]ACJF_M4_DOWNCASE([$1])[-include], [include path for $1]),
  [acjf_with_]ACJF_M4_CANON_DC([$1])[_include="$withval"])

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-lib], AS_HELP_STRING(
  [--with-]ACJF_M4_DOWNCASE([$1])[-lib], [library path for $1]),
  [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib="$withval"])

if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" = x"" -a \
        x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]" = x"" -a \
        x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]" = x""; then
  # No --with-xxx[-include|-lib] options. Fall back to environment variables!
  [acjf_with_]ACJF_M4_CANON_DC([$1])="[$]ACJF_M4_CANON_DN([$1])[_BASE]";
  [acjf_with_]ACJF_M4_CANON_DC([$1])[_include]="[$]ACJF_M4_CANON_DN([$1])[_INCLUDE]";
  [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]="[$]ACJF_M4_CANON_DN([$1])[_LIB]";
fi

if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" = x"no" -o \
        x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]" = x"no" -o \
        x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]" = x"no"; then
  [acjf_with_]ACJF_M4_CANON_DC([$1])=no
  unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_include]
  unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]
fi

if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" != x"no"; then
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]" != x"" -o \
          x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]" != x""; then
    if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]" = x""; then
      for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]; do
        if echo "$acjf_var_item" | grep "[[/\\]]lib[[/\\]]*$" 1>/dev/null; then
          [acjf_with_]ACJF_M4_CANON_DC([$1])[_include]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include] `dirname $acjf_var_item`/include";
        fi
      done
      for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
        [acjf_with_]ACJF_M4_CANON_DC([$1])[_include]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_include] $acjf_var_item/include";
      done
    fi
    if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]" = x""; then
      for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1])[_include]; do
        if echo "$acjf_var_item" | grep "[[/\\]]include[[/\\]]*$" 1>/dev/null; then
          [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib] `dirname $acjf_var_item`/lib";
        fi
      done
      for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
        [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_lib] $acjf_var_item/lib";
      done
    fi
    dnl Register vars acjf_with_xxx_include and acjf_with_xxx_lib on search list!
    [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] [acjf_with_]ACJF_M4_CANON_DC([$1])";
  else
    acjf_var_item2=0
    for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
      if test x"$acjf_var_item" = x"intern"; then
        m4_if([$2], [], [
          AC_MSG_ERROR([internal location for $1 is not supported!])
        ], [
          dnl Register internal location on search list!
          [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] intern";
        ])
      elif test x"$acjf_var_item" = x"extern"; then
        dnl Register acjf_std (standard include/lib path) on search list!
        [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_std";
      else
        eval ACJF_VAR_ANONYMOUS_SHELL_VAR[_${acjf_var_item2}_include]="$acjf_var_item/include";
        eval ACJF_VAR_ANONYMOUS_SHELL_VAR[_${acjf_var_item2}_lib]="$acjf_var_item/lib";
        dnl Register vars ACJF_VAR_ANONYMOUS_SHELL_VAR[_${acjf_var_item2}_include] and ACJF_VAR_ANONYMOUS_SHELL_VAR[_${acjf_var_item2}_lib] on search list!
        [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR[_${acjf_var_item2}]";
        let acjf_var_item2=acjf_var_item2+1
      fi
    done
    if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" = x""; then
      m4_if([$2], [], [], [
        dnl Register internal location on search list!
        [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] intern";
      ])
      dnl Register acjf_std (standard include/lib path) on search list!
      [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_std";
    fi
  fi
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
fi

unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_include]
unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_lib]
dnl unset [acjf_with_]ACJF_M4_CANON_DC([$1])
])

dnl ACJF_CHECK_LIB_TESTMACROGEN(
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib list,.e.g., xerces-c systemc>)
dnl
dnl This macro generates a macro ACJF_M4_ANONYMOUS_XXX testing for presence
dnl of the given library. The generated macro takes two arguments, i.e.,
dnl
dnl   ACJF_M4_ANONYMOUS_XXX(
dnl     <code if found, default does nothing>,
dnl     <code if not found, default is bailout>)
AC_DEFUN([ACJF_CHECK_LIB_TESTMACROGEN], [AC_REQUIRE([ACJF_INIT])dnl
m4_pushdef([ACJF_VAR_ANONYMOUS_M4_MACRO], ACJF_GEN_ANONYMOUS_M4_MACRO)dnl
ACJF_VAR_ANONYMOUS_M4_MACRO[]dnl
m4_define(ACJF_VAR_ANONYMOUS_M4_MACRO, ACJF_M4_QUOTEDARGS([
  m4_if([$3], [], [
    AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[$1]], [[$2]])],
      [§1],
      [§2])
  ], [
    acjf_old_LIBS="$LIBS"
    LIBS=""
    for acjf_var_item2 in $3; do
      if echo "$acjf_var_item2" | grep "^-l" 1>/dev/null; then
        LIBS="$LIBS $acjf_var_item2";
      else
        LIBS="$LIBS -l$acjf_var_item2";
      fi
    done
    LIBS="$LIBS $acjf_old_LIBS";
    AC_LINK_IFELSE(
      [AC_LANG_PROGRAM([[$1]], [[$2]])],
      [§1],
      [§2])
  ])
]))dnl
m4_popdef([ACJF_VAR_ANONYMOUS_M4_MACRO])dnl
])

dnl ACJF_CHECK_LIB_TESTER(
dnl   <name of lib check (pkgname)>,
dnl   <possible location in source tree>,
dnl   <test macro>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl This macro only performs the search for the headers and the library.  Some
dnl other macro must have set the acjf_pkgname_search_list variable.  It is
dnl preferable to set these variable by usage of the ACJF_ARG_WITHPKG macro. Or use
dnl the ACJF_CHECK_LIB macro which calls ACJF_ARG_WITHPKG and
dnl ACJF_CHECK_LIB_TESTER in sequence.  Usage of ACJF_CHECK_LIB_TESTER is
dnl only required for certain packages which require custom code to find header and
dnl library paths.
dnl
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_LDFLAGS
dnl IF pkg is from srcdir:
dnl   PKGNAME_INCPATH
dnl   PKGNAME_LIBPATH
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true
dnl IF pkg is from extern:
dnl   PKGNAME_INCPATH if possible
dnl   PKGNAME_LIBPATH if possible
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := false
AC_DEFUN([ACJF_CHECK_LIB_TESTER], [AC_REQUIRE([ACJF_INIT])dnl
m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])dnl
m4_pushdef([ACJF_VAR_SUBDIR_LIST], [[$2]])dnl
m4_pushdef([ACJF_VAR_TEST_MACRO], [[$3]])dnl
m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$4]])dnl
m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[$5]])dnl

unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]
unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]
unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]
unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]
unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]
unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]
unset [acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)
m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION])
AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION], false)

acjf_CPPFLAGS="$CPPFLAGS";  acjf_LDFLAGS="$LDFLAGS"; acjf_LIBS="$LIBS";

AC_MSG_CHECKING([for ACJF_VAR_PKGNAME package])
AC_CACHE_VAL([acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath],
 [for acjf_var_item in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
    if test x"$acjf_var_item" = x"intern"; then
      acjf_search_include="bundled version"
      acjf_search_lib="bundled version"
      m4_if(ACJF_VAR_SUBDIR_LIST, [], [
            [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="/invalid"; acjf_search_lib="/invalid";]
        ], [
          ACJF_CHECK_PKG(ACJF_VAR_PKGNAME, ACJF_VAR_SUBDIR_LIST,
            [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="$acjf_search_include"; break],
            [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="/invalid"; acjf_search_lib="/invalid";])
        ])
    else
      eval acjf_search_include=\$${acjf_var_item}_include;
      eval acjf_search_lib=\$${acjf_var_item}_lib;
      CPPFLAGS="$acjf_CPPFLAGS"
      if test x"$acjf_search_include" != x"$acjf_std_include"; then
        for acjf_var_item2 in $acjf_search_include; do
          CPPFLAGS="$CPPFLAGS -I$acjf_var_item2";
        done
      fi
      LDFLAGS="$acjf_LDFLAGS"
      if test x"$acjf_search_lib" != x"$acjf_std_lib"; then
        for acjf_var_item2 in $acjf_search_lib; do
          LDFLAGS="$LDFLAGS -L$acjf_var_item2";
        done
      fi
      LIBS="$acjf_LIBS"
      ACJF_M4_UNQUOTE(ACJF_VAR_TEST_MACRO[(
       [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="$acjf_search_include";
        acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath="$acjf_search_lib"; break],
       [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="/invalid";
        acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath="$acjf_search_lib";])])
    fi
  done])

CPPFLAGS="$acjf_CPPFLAGS"; LDFLAGS="$acjf_LDFLAGS"; LIBS="$acjf_LIBS";
unset acjf_CPPFLAGS; unset acjf_LDFLAGS; unset acjf_LIBS;

if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"/invalid"; then
  AC_MSG_RESULT([-I$acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath, -L$acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath])
  [acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="yes"
  if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"bundled version"; then
    [acjf_]ACJF_M4_CANON_DC([$1])[_use_srcdir_version]="no";
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]=""
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]=""
    if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"$acjf_std_include"; then
      for acjf_var_item2 in $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]; do
        ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE="$]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE -I$acjf_var_item2"];
      done
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]"
    fi
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]=""
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]=""
    if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" != x"$acjf_std_lib"; then
      for acjf_var_item2 in $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]; do
        ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS="$]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS -I$acjf_var_item2"];
      done
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]"
    fi
  else
    [acjf_]ACJF_M4_CANON_DC([$1])[_use_srcdir_version]="yes";
  fi
else
  AC_MSG_RESULT([no])
  [acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="no"
fi

if test x"$[acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"yes"; then
  unset [acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)
  m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
   [true;],
   ACJF_VAR_CODE_IF_TRUE)
else
  unset [acjf_found_pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)
  m4_if(ACJF_VAR_CODE_IF_FALSE, [],
   [AC_MSG_ERROR([Cannot find ACJF_VAR_PKGNAME package, bailing out!])],
   ACJF_VAR_CODE_IF_FALSE)
fi

m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl
AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl

m4_popdef([ACJF_VAR_PKGNAME])dnl
m4_popdef([ACJF_VAR_SUBDIR_LIST])dnl
m4_popdef([ACJF_VAR_TEST_MACRO])dnl
m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
])dnl

dnl OBSOLETE ACJF_CHECK_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
dnl
dnl <srcdir subdirectory name> will be set to <pkgname>
dnl
dnl NEW ACJF_CHECK_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl   <srcdir subdirectory name>
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
dnl
dnl After execution of the macro
dnl
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_INCPATH
dnl   PKGNAME_LDFLAGS
dnl   PKGNAME_LIBPATH
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true
AC_DEFUN([ACJF_CHECK_PKG], [AC_REQUIRE([ACJF_INIT])dnl
  m4_if(
    m4_if(m4_eval([$#<=1]), [1],
      [[old]],
      [m4_if(m4_bregexp([$2], [[=;]\|^$]), [-1], [[new]], [[old]])]),
    [old],
    [# OBSOLETE USAGE
     m4_pushdef([ACJF_VAR_PKGNAME], [$1])
     m4_pushdef([ACJF_VAR_SUBDIR_LIST], [$1])
     m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [$2])
     m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [$3])],
    [# NEW USAGE
     m4_pushdef([ACJF_VAR_PKGNAME], [$1])
     m4_pushdef([ACJF_VAR_SUBDIR_LIST], [$2])
     m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [$3])
     m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [$4])])
  AC_MSG_CHECKING([for ACJF_VAR_PKGNAME package in source tree])
  if test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC([$1])" = x""; then
    [acjf_pkgdir_]ACJF_M4_CANON_DC([$1])="/invalid";
dnl Do !NOT! cache this value as relative ../configure pathes generate relative
dnl pkgdir pathes which must differ between configures in different directory
dnl hierarchy levels.
dnl
dnl AC_CACHE_VAL([acjf_cv_pkgdir_]ACJF_M4_CANON_DC([$1]),
dnl [# Searching $1 subproject
    m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
    ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
     [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
      for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
        if test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"/invalid" -a \
                -d "$srcdir/_ACJF_VAR_DIR/$acjf_var_subdir"; then
          [acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="_ACJF_VAR_DIR/$acjf_var_subdir";
        fi
      done
    ])dnl
    m4_popdef([_ACJF_VAR_DIR])dnl
    # Last ditch effort try one uplevel directory
    for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
      if test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"/invalid" -a \
              -d "$srcdir/../$acjf_var_subdir"; then
        [acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="../$acjf_var_subdir";
      fi
    done
    # Last ditch effort try two uplevel directory
    for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
      if test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"/invalid" -a \
              -d "$srcdir/../../$acjf_var_subdir"; then
        [acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="../../$acjf_var_subdir";
      fi
    done
    # cleanup
    unset acjf_var_subdir
dnl  ])
  fi
  m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION])
  AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION],
    test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" != x"/invalid")
  if test x"$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" != x"/invalid"; then
    AC_MSG_RESULT([[$acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)])
    [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]="$acjf_top_srcdir/$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)";
    [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]="$acjf_top_builddir/$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)";
    if test -d "$srcdir/$[acjf_pkgdir_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)/pkginclude"; then
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/pkginclude -I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]/pkginclude"
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]="$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/pkginclude $[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]/pkginclude"
    else
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]="-I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/include -I$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]"
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]="$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]/include $[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]"
    fi
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]="-L$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]"
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]="$[pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]"
    m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
     [true;],
     ACJF_VAR_CODE_IF_TRUE)
  else
    AC_MSG_RESULT([no])
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir];
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS];
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH];
    m4_if(ACJF_VAR_CODE_IF_FALSE, [],
     [AC_MSG_ERROR([Cannot find ACJF_VAR_PKGNAME package in subdir(s) ACJF_VAR_SUBDIR_LIST of source tree, bailing out])],
     [ACJF_VAR_CODE_IF_FALSE])
  fi
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
  m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
    ACJF_M4_LIST_PUSH_BACK(ACJF_M4_ARGSTOLIST(
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]),
    ACJF_VAR_SUBSTVARFIXUP)))dnl
  m4_popdef([ACJF_VAR_PKGNAME])
  m4_popdef([ACJF_VAR_SUBDIR_LIST])
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
dnl
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE
dnl   PKGNAME_LDFLAGS
dnl IF pkg is from srcdir:
dnl   PKGNAME_INCPATH
dnl   PKGNAME_LIBPATH
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true
dnl IF pkg is from extern:
dnl   PKGNAME_INCPATH if possible
dnl   PKGNAME_LIBPATH if possible
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := false
AC_DEFUN([ACJF_CHECK_LIB], [dnl
ACJF_ARG_WITHPKG([$1], [$2])dnl
ACJF_CHECK_LIB_TESTER([$1], [$2], ACJF_CHECK_LIB_TESTMACROGEN([$3], [$4], [$5]), [$6], [$7])dnl
])
