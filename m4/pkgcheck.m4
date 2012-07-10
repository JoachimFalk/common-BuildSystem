dnl vim: set sw=2 ts=8 syn=config:
dnl Copyright (C) 2001 - 2011 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_PKG_COPY_OPTIONS(
dnl   <src pkgname>, <dst pkgname>)
dnl
dnl Copy search option form <src pkgname>, usually derived by macro
dnl ACJF_ARG_WITHPKG, to <dst pkgname>. This enables the usage of
dnl a simple --with-<src pkgname> option to control the location of
dnl multiple libraries <dst pkgname>s.
AC_DEFUN([ACJF_PKG_COPY_OPTIONS], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$2])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list]"
])

dnl ACJF_PKG_ADDLOC_STD(
dnl   <pkgname>)
dnl
dnl Add standard include/lib to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_STD], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_std";
])

dnl ACJF_PKG_ADDLOC_PREFIX(
dnl   <pkgname>,
dnl   <prefix>)
dnl
dnl Add <prefix> to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_PREFIX], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2/include"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$2/lib"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="from install location $2"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_PKG_ADDLOC_INCLIB(
dnl   <pkgname>,
dnl   <include path>,
dnl   <lib path>)
dnl
dnl Add <include path> and <lib path> to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_INCLIB], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="includes from $2, libs from $3"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_PKG_ADDLOC_CONFIGSCRIPT(
dnl   <pkgname>,
dnl   <script>)
dnl
dnl Derive include, libpath, cppflags, ldflags, and libs by calling script.
dnl The script will be checked with the following options:
dnl   --includes
dnl   --includedir
dnl   --ldflags
dnl   --libs
dnl   --cppflags
dnl   --cflags
dnl   --cxxflags
AC_DEFUN([ACJF_PKG_ADDLOC_CONFIGSCRIPT], [AC_REQUIRE([ACJF_INIT])dnl
dnl m4_pushdef([ACJF_VAR_ANON_SHELLVARPREFIX], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  if test x"${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script]+set}" != x"set"; then
    AC_PATH_PROG([acjf_cv_]ACJF_M4_CANON_DC([$2])[_script], [$2], [not found])
    if test x"$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script]" != x"not found"; then
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_desc]="configuration from $[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script]"
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_configscript]="$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script]"
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]=""
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]=""
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags_other]=""
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_ldflags_other]=""
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_libs]=""
      acjf_var_include=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --include 2>/dev/null`
      acjf_var_cppflags=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --cppflags 2>/dev/null`
      acjf_var_cflags=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --cflags 2>/dev/null`
      acjf_var_cxxflags=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --cxxflags 2>/dev/null`
      set dummy $acjf_var_include $acjf_var_cppflags $acjf_var_cflags $acjf_var_cxxflags
      shift
      while test $[]# != 0
      do
        case $[]1 in
          [-[ID])]
            ac_option=$[]1
            ac_optarg=$[]2
            ac_shift=shift
            ;;
          [-[ID]*)]
            ac_option=`expr "x$[]1" : 'x\(..\)'`
            ac_optarg=`expr "x$[]1" : 'x..\(.*\)'`
            ac_shift=:
            ;;
          [*)]
            # This is not an option, so the user has probably given explicit
            # arguments.
            ac_option=$[]1
            ac_shift=:
        esac
        case $ac_option in
          -I)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]} $ac_optarg"; $ac_shift;
            ;;
          -D)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags]} -D$ac_optarg"; $ac_shift;
            ;;
          *)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags]} $ac_option";
            ;;
        esac
        shift
      done
      acjf_var_includedir=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --includedir 2>/dev/null`
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]} $acjf_var_includedir";

      acjf_var_libs=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --libs 2>/dev/null`
      acjf_var_ldflags=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --ldflags 2>/dev/null`
      set dummy $acjf_var_libs $acjf_var_ldflags
      shift
      while test $[]# != 0
      do
        case $[]1 in
          [-L)]
            ac_option=$[]1
            ac_optarg=$[]2
            ac_shift=shift
            ;;
          [-[Ll]*)]
            ac_option=`expr "x$[]1" : 'x\(..\)'`
            ac_optarg=`expr "x$[]1" : 'x..\(.*\)'`
            ac_shift=:
            ;;
          [*)]
            # This is not an option, so the user has probably given explicit
            # arguments.
            ac_option=$[]1
            ac_shift=:
        esac
        case $ac_option in
          -L)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]} $ac_optarg"; $ac_shift;
            ;;
          -l)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_libs]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libs]} -l$ac_optarg"; $ac_shift;
            ;;
          *)
            [acjf_cv_]ACJF_M4_CANON_DC([$2])[_ldflags_other]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_ldflags_other]} $ac_option";
            ;;
        esac
        shift
      done
      acjf_var_libdir=`$[acjf_cv_]ACJF_M4_CANON_DC([$2])[_script] --libdir 2>/dev/null`
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]="${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]} $acjf_var_libdir";
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_desc]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_desc]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_configscript]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_configscript]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_incpath]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libpath]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags_other]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_cppflags_other]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_ldflags_other]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_ldflags_other]}"
#     echo "[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libs]: ${[acjf_cv_]ACJF_M4_CANON_DC([$2])[_libs]}"
    else
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_desc="configuration from $2"];
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_invalid]="yes";
    fi
  fi
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] [acjf_cv_]ACJF_M4_CANON_DC([$2])";
dnl m4_popdef([[acjf_cv_]ACJF_M4_CANON_DC([$2])])
])

dnl ACJF_ARG_WITHPKG(
dnl   <pkgname>,
dnl   <tags>)
dnl
dnl uses the following env vars as defaults:
dnl   <PKGNAME>_BASE
dnl   <PKGNAME>_INCLUDE
dnl   <PKGNAME>_LIB
dnl
dnl tags (empty defaults to extern):
dnl   intern: provide intern tag to --with-xxx option
dnl   extern: provide extern tag to --with-xxx option
dnl set shell vars
dnl   acjf_<pkgname>_search_list
AC_DEFUN([ACJF_ARG_WITHPKG], [AC_REQUIRE([ACJF_INIT])dnl
m4_divert_push([INIT_PREPARE])
ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_ARG_WITHPKG::$1]), [
m4_pushdef([ACJF_VAR_TAGS], m4_if([$2], [], [[extern]], [[$2]]))
dnl add intern to tags if we find a compile tag
m4_define([ACJF_VAR_TAGS], m4_if(m4_bregexp(ACJF_VAR_TAGS, [compile]), [-1],
 [ACJF_VAR_TAGS],
 [ACJF_VAR_TAGS [intern]]))
[acjf_]ACJF_M4_CANON_DC([$1])[_search_list]=""
m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], [],
 [[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]=""
  [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]=""
  [acjf_with_]ACJF_M4_CANON_DC([$1])=""])

AC_ARG_WITH(ACJF_M4_DOWNCASE([$1]), AS_HELP_STRING(
  [--with-]ACJF_M4_DOWNCASE([$1]), m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], 
    [m4_if(m4_bregexp(ACJF_VAR_TAGS, [intern]), [-1],
      [[WTF?!]], dnl no extern and no intern
      [[use bundled package for $1 or no to disable]])], dnl intern
    [m4_if(m4_bregexp(ACJF_VAR_TAGS, [intern]), [-1],
      [[prefix path for $1 or no to disable]], dnl extern
      [[prefix path for $1, no to disable, extern to force installed library usage, or intern to force bundled package]])])), dnl extern intern
  [acjf_with_]ACJF_M4_CANON_DC([$1])[="$withval"])

m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], [],
 [AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-include], AS_HELP_STRING(
    [--with-]ACJF_M4_DOWNCASE([$1])[-include], [include path for $1]),
    [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath="$withval"])

  AC_ARG_WITH(ACJF_M4_DOWNCASE([$1])[-lib], AS_HELP_STRING(
    [--with-]ACJF_M4_DOWNCASE([$1])[-lib], [library path for $1]),
    [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath="$withval"])

  if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" = x"" -a \
          x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" = x"" -a \
          x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" = x""; then
    # No --with-xxx[-include|-lib] options. Fall back to environment variables!
    AC_ARG_VAR(ACJF_M4_CANON_DN([$1])[_BASE], [List of prefixes; Seach in <prefix>/{lib,include} for $1.])
    AC_ARG_VAR(ACJF_M4_CANON_DN([$1])[_LIB], [Explicit list of lib directories for $1])
    AC_ARG_VAR(ACJF_M4_CANON_DN([$1])[_INCLUDE], [Explicit list of include directories for $1])
    [acjf_with_]ACJF_M4_CANON_DC([$1])="[$]ACJF_M4_CANON_DN([$1])[_BASE]";
    [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]="[$]ACJF_M4_CANON_DN([$1])[_INCLUDE]";
    [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]="[$]ACJF_M4_CANON_DN([$1])[_LIB]";
  fi

  if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" = x"no" -o \
          x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" = x"no" -o \
          x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" = x"no"; then
    [acjf_with_]ACJF_M4_CANON_DC([$1])=no
    unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]
    unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]
  fi])

if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" != x"no"; then
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], [],
   [if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" != x"" -o \
            x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" != x""; then
      if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" = x""; then
        for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]; do
          if echo "$acjf_var_item" | grep "[[/\\]]lib[[/\\]]*$" 1>/dev/null; then
            if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" != x""; then
              [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath] `dirname $acjf_var_item`/include";
            else
              [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]="`dirname $acjf_var_item`/include";
            fi
          fi
        done
        for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
          if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]" != x""; then
            [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath] $acjf_var_item/include";
          else
            [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]="$acjf_var_item/include";
          fi
        done
      fi
      if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" = x""; then
        for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]; do
          if echo "$acjf_var_item" | grep "[[/\\]]include[[/\\]]*$" 1>/dev/null; then
            if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" != x""; then
              [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath] `dirname $acjf_var_item`/lib";
            else
              [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]="`dirname $acjf_var_item`/lib";
            fi
          fi
        done
        for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
          if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]" != x""; then
            [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]="$[acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath] $acjf_var_item/lib";
          else
            [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]="$acjf_var_item/lib";
          fi
        done
      fi
      [acjf_with_]ACJF_M4_CANON_DC([$1])=yes
      ACJF_PKG_ADDLOC_INCLIB([$1], [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath], [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath])
    else
  ])
    if test x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" != x"yes" -a \
            x"$[acjf_with_]ACJF_M4_CANON_DC([$1])" != x""; then
      acjf_var_item2=0
      for acjf_var_item in $[acjf_with_]ACJF_M4_CANON_DC([$1]); do
        if test x"$acjf_var_item" = x"intern"; then
          m4_if(m4_bregexp(ACJF_VAR_TAGS, [intern]), [-1], [
            AC_MSG_ERROR([internal location for $1 is not supported!])
          ], [
            dnl Register internal location on search list!
            [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_bundled";
          ])
        elif test x"$acjf_var_item" = x"extern"; then
          dnl Register standard include/lib path on search list!
          ACJF_PKG_ADDLOC_STD([$1])
        else
          ACJF_PKG_ADDLOC_PREFIX([$1], [$acjf_var_item])
        fi
      done
      [acjf_with_]ACJF_M4_CANON_DC([$1])=yes
    else
      m4_if(m4_bregexp(ACJF_VAR_TAGS, [intern]), [-1], [], [
        dnl Register internal location on search list!
        [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_bundled";
      ])
      dnl Register standard include/lib path on search list!
      ACJF_PKG_ADDLOC_STD([$1])
    fi
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], [],
   [fi])
fi

dnl Do not unset as [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath/_libpath] could be
dnl registered on the [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]!
dnl
dnl m4_if(m4_bregexp(ACJF_VAR_TAGS, [extern]), [-1], [],
dnl  [unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_incpath]
dnl   unset [acjf_with_]ACJF_M4_CANON_DC([$1])[_libpath]])
dnl unset [acjf_with_]ACJF_M4_CANON_DC([$1])

m4_popdef([ACJF_VAR_TAGS])
])
m4_divert_pop([INIT_PREPARE])
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
dnl     <name of lib check (pkgname)>,
dnl     <description shell variable>,
dnl     <code if found, default does nothing>,
dnl     <code if not found, default does nothing>)
AC_DEFUN([ACJF_CHECK_LIB_TESTMACROGEN], [AC_REQUIRE([ACJF_INIT])dnl
m4_pushdef([ACJF_VAR_ANONYMOUS_M4_MACRO], ACJF_GEN_ANONYMOUS_M4_MACRO)dnl
ACJF_VAR_ANONYMOUS_M4_MACRO[]dnl
m4_define(ACJF_VAR_ANONYMOUS_M4_MACRO, ACJF_M4_QUOTEDARGS([
  AC_MSG_CHECKING([for §1 package in $§2])
  m4_if([$3], [], [
    AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[$1]], [[$2]])],
      [AC_MSG_RESULT([yes]); §3],
      [AC_MSG_RESULT([no]); §4])
  ], [
    if test x"$§2" = x"$acjf_bundled_desc"; then
      AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([[$1]], [[$2]])],
        [AC_MSG_RESULT([yes]); §3],
        [AC_MSG_RESULT([no]); §4])
    else
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
        [AC_MSG_RESULT([yes]); §3],
        [AC_MSG_RESULT([no]); §4])
    fi
  ])
]))dnl
m4_popdef([ACJF_VAR_ANONYMOUS_M4_MACRO])dnl
])

dnl _ACJF_SOURCE_TREE_LOCATION_SEARCHER helper macro
m4_define([_ACJF_SOURCE_TREE_LOCATION_SEARCHER], [
  $1="/invalid";
  m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
  ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
   [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
    for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
      if test x"$$1" = x"/invalid" -a \
              -d "$srcdir/_ACJF_VAR_DIR/$acjf_var_subdir"; then
        $1="_ACJF_VAR_DIR/$acjf_var_subdir";
      fi
    done
  ])dnl
  m4_popdef([_ACJF_VAR_DIR])dnl
  # Last ditch effort try one uplevel directory
  for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../$acjf_var_subdir"; then
      $1="../$acjf_var_subdir";
    fi
  done
  # Last ditch effort try two uplevel directories
  for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../../$acjf_var_subdir"; then
      $1="../../$acjf_var_subdir";
    fi
  done
  # cleanup
  unset acjf_var_subdir
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
dnl   PKGNAME_INCLUDE        only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS       PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LFLAGS         only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER  odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS        PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS           -l options (whitespace seperated)
dnl   PKGNAME_FOUND          yes or no
dnl IF pkg is from srcdir:
dnl   PKGNAME_INCPATH include directory
dnl   PKGNAME_LIBPATH library directory
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true
dnl IF pkg is from extern:
dnl   PKGNAME_INCPATH if possible whitespace seperated list of include directories
dnl   PKGNAME_LIBPATH if possible whitespace seperated list of library directories
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := false
AC_DEFUN([ACJF_CHECK_LIB_TESTER], [AC_REQUIRE([ACJF_INIT])dnl
m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])dnl
m4_pushdef([ACJF_VAR_SUBDIR_LIST], [[$2]])dnl
m4_pushdef([ACJF_VAR_TEST_MACRO], [[$3]])dnl
m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$4]])dnl
m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[$5]])dnl
m4_pushdef([ACJF_VAR_ANON_SHELLVARPREFIX], ACJF_GEN_ANONYMOUS_SHELL_VAR)

ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::A::$1::subdir::$2]), [
dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::A::$1::subdir::$2]) [[BEGIN]]"

  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
  m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS])

  dnl dnl For debug
  dnl echo "CODE IF TRUE: _[]ACJF_M4_CANON_DC(ACJF_VAR_CODE_IF_TRUE)[]_"
  dnl echo "CODE IF FALSE: _[]ACJF_M4_CANON_DC(ACJF_VAR_CODE_IF_FALSE)[]_"

  unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]
  unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]
  unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]
  unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]
  m4_if(ACJF_VAR_SUBDIR_LIST, [], [],
   [unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]])

  ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS]="$CPPFLAGS";
  ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]="$LDFLAGS";
  ACJF_VAR_ANON_SHELLVARPREFIX[LIBS]="$LIBS";
  ACJF_VAR_ANON_SHELLVARPREFIX[concat]=""
  for ACJF_VAR_ANON_SHELLVARPREFIX[item] in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
    eval ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_desc;
    ACJF_VAR_ANON_SHELLVARPREFIX[concat]="$ACJF_VAR_ANON_SHELLVARPREFIX[concat], $ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]"
  done
  dnl Invalidate cache if search list does not match up to search list which was used to generate the cached entry.
  if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_concat]" != x"$ACJF_VAR_ANON_SHELLVARPREFIX[concat]"; then
    dnl Cache is obsolete => invalidate it
    unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]
  fi
  if test x"${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]+set}" != x"set"; then
    [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_concat]="$ACJF_VAR_ANON_SHELLVARPREFIX[concat]"
    ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]="disabled"
    for ACJF_VAR_ANON_SHELLVARPREFIX[item] in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
      eval ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_desc;
      if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[item]" = x"acjf_bundled"; then
        m4_if(ACJF_VAR_SUBDIR_LIST, [], [false], [
          _ACJF_SOURCE_TREE_LOCATION_SEARCHER(ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir])
          if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]" != x"/invalid"; then
            if test -d "$srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"; then
              CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS] -I$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude -I$srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"
            else
              CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS] -I$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir] -I$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/include -I$srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
            fi
            LDFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]"
            LIBS="$ACJF_VAR_ANON_SHELLVARPREFIX[LIBS]"
            ACJF_M4_UNQUOTE(ACJF_VAR_TEST_MACRO[(
             ACJF_VAR_PKGNAME,
             ACJF_VAR_ANON_SHELLVARPREFIX[search_desc],
             [break],
             [false])])
          else
            AC_MSG_CHECKING([for ACJF_VAR_PKGNAME package in $]ACJF_VAR_ANON_SHELLVARPREFIX[search_desc])
            AC_MSG_RESULT([no])
          fi])
      else
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_invalid]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_invalid;
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_incpath]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_incpath;
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_libpath]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_libpath;
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_cppflags_other]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_cppflags_other;
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_ldflags_other]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_ldflags_other;
        eval ACJF_VAR_ANON_SHELLVARPREFIX[search_libs]=\$${ACJF_VAR_ANON_SHELLVARPREFIX[item]}_libs;
        if test x"ACJF_VAR_ANON_SHELLVARPREFIX[search_invalid]" != x"yes"; then
          CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS]"
          if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[search_incpath]" != x"$acjf_std_incpath"; then
            for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in $ACJF_VAR_ANON_SHELLVARPREFIX[search_incpath]; do
              CPPFLAGS="$CPPFLAGS -I$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
            done
          fi
          CPPFLAGS="$CPPFLAGS $ACJF_VAR_ANON_SHELLVARPREFIX[search_cppflags_other]";
          LDFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]"
          if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[search_libpath]" != x"$acjf_std_libpath"; then
            for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in $ACJF_VAR_ANON_SHELLVARPREFIX[search_libpath]; do
              LDFLAGS="$LDFLAGS -L$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
            done
          fi
          LDFLAGS="$LDFLAGS $ACJF_VAR_ANON_SHELLVARPREFIX[search_ldflags_other]";
          LIBS="$ACJF_VAR_ANON_SHELLVARPREFIX[LIBS] $ACJF_VAR_ANON_SHELLVARPREFIX[search_libs]";
          ACJF_M4_UNQUOTE(ACJF_VAR_TEST_MACRO[(
           ACJF_VAR_PKGNAME,
           ACJF_VAR_ANON_SHELLVARPREFIX[search_desc],
           [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_incpath";
            acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_libpath";
            acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_cppflags_other";
            acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_ldflags_other";
            acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_libs"; break],
           [false])])
        else
          AC_MSG_CHECKING([for ACJF_VAR_PKGNAME package in $]ACJF_VAR_ANON_SHELLVARPREFIX[search_desc])
          AC_MSG_RESULT([no])
        fi
      fi
      ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]="not found"
    done
  fi

  CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS]";
  LDFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]";
  LIBS="$ACJF_VAR_ANON_SHELLVARPREFIX[LIBS]";
  unset ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS];
  unset ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS];
  unset ACJF_VAR_ANON_SHELLVARPREFIX[LIBS];
dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::A::$1::subdir::$2]) [[END]]"
])dnl end of once code

AC_CACHE_CHECK(
  [for ACJF_VAR_PKGNAME package],
  [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc],
  [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]="$ACJF_VAR_ANON_SHELLVARPREFIX[search_desc]")

if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" = x"$acjf_bundled_desc"; then
  m4_if(ACJF_VAR_SUBDIR_LIST, [], [
    AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location not given in configure.in!])
  ], [
    _ACJF_SOURCE_TREE_LOCATION_SEARCHER(ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir])
    if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]" != x"/invalid"; then
      dnl we need abs pathes ($acjf_top_srcdir) here to enable a correct fixup also for relative configure calls.
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]="$acjf_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]" 
      dnl we need abs pathes ($acjf_top_builddir) here to enable a correct fixup also for relative configure calls.
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]="$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
      if test -d "$srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"; then
        dnl we need abs pathes ($acjf_top_srcdir/$acjf_top_builddir) here to enable a correct fixup also for relative configure calls.
        [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude $acjf_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"
      else
        dnl we need abs pathes ($acjf_top_srcdir/$acjf_top_builddir) here to enable a correct fixup also for relative configure calls.
        [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir] $acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/include $acjf_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
      fi
      dnl we need abs pathes ($acjf_top_builddir) here to enable a correct fixup also for relative configure calls.
      [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]="$acjf_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
    else
      AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location given in configure.in is nonexistent!])
    fi
  ])
fi

dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]"

if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" != x"not found" -a \
        x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" != x"disabled"; then
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]="yes"
  # compile flags stuff
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]"
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]=""
  for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]; do
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]="$ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE] -I$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
  done
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]"
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS]="$ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE] $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER]"
  # link flags stuff
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]"
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS]=""
  for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]; do
    ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS]="$ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS] -L$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
  done
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]"
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]"
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]="$ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS] $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]"
else
  ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]="no"
fi

ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::B::$1::subdir::$2]), [
  dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::B::$1::subdir::$2]) [[BEGIN]]"

  m4_if(ACJF_VAR_SUBDIR_LIST, [], [],
   [m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION])
    m4_divert_push([INIT_PREPARE])
    ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION]),
      [AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION], [false])])
    m4_divert_pop([INIT_PREPARE])
    AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION],
      test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" = x"$[acjf_bundled_desc]")
    if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" = x"$[acjf_bundled_desc]"; then
      dnl no caching of incpath and libpath for source tree location
      unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]
      unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]
    fi])

  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
  AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS])dnl

  m4_define([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_QUOTE(
    ACJF_M4_LIST_PUSH_BACK(ACJF_M4_ARGSTOLIST(
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir],
      [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]),
    ACJF_VAR_SUBSTVARFIXUP)))dnl

  dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::B::$1::subdir::$2]) [[END]]"
])dnl end of once code

dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]:   $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]"
dnl echo "ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]: $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]"

if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" != x"not found" -a \
        x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]" != x"disabled"; then
  m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
    [true;],
dnl echo "ACJF_VAR_CODE_IF_TRUE";
    ACJF_VAR_CODE_IF_TRUE)
else
  m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
    [AC_MSG_ERROR([Cannot find ACJF_VAR_PKGNAME package, bailing out!])],
    [m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
      [true;],
dnl   echo "ACJF_VAR_CODE_IF_FALSE";
      ACJF_VAR_CODE_IF_FALSE)])
fi

m4_popdef([ACJF_VAR_ANON_SHELLVARPREFIX])dnl
m4_popdef([ACJF_VAR_PKGNAME])dnl
m4_popdef([ACJF_VAR_SUBDIR_LIST])dnl
m4_popdef([ACJF_VAR_TEST_MACRO])dnl
m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
])dnl

dnl ACJF_CHECK_PKG_TESTMACRO(
dnl   <name of lib check (pkgname)>,
dnl   <description shell variable>,
dnl   <code if found, default does nothing>,
dnl   <code if not found, default does nothing>)
dnl
dnl If not source tree location => execute code if not found
dnl If source tree location => execute code if found
AC_DEFUN([ACJF_CHECK_PKG_TESTMACRO], [
  AC_MSG_CHECKING([for $1 package in $$2])
  if test x"$$2" = x"$acjf_bundled_desc"; then
    AC_MSG_RESULT([yes]);
    m4_if([$3], [], [true], [$3])
  else
    AC_MSG_RESULT([no]);
    m4_if([$4], [], [false], [$4])
  fi
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
dnl NEW ACJF_CHECK_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl   <possible location in source tree>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
dnl
dnl After execution of the macro
dnl
dnl IF pkg found define:
dnl   PKGNAME_INCLUDE        only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS       PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LFLAGS         only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER  odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS        PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS           -l options (whitespace seperated)
dnl   PKGNAME_FOUND          yes or no
dnl   PKGNAME_INCPATH        include directory
dnl   PKGNAME_LIBPATH        library directory
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
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, [intern])dnl
  ACJF_CHECK_LIB_TESTER(ACJF_VAR_PKGNAME, ACJF_VAR_SUBDIR_LIST,
    [ACJF_CHECK_PKG_TESTMACRO],
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)
  m4_popdef([ACJF_VAR_PKGNAME])
  m4_popdef([ACJF_VAR_SUBDIR_LIST])
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])
])

dnl ACJF_NEED_PKG(
dnl   <pkgname>,
dnl   <possible location in source tree>)
dnl
dnl Take the same actions as ACJF_CHECK_PKG but also adds
dnl PKGNAME_CPPFLAGS to AM_CPPFLAGS and
dnl PGKNAME_LDFLAGS  to AM_LDFLAGS
AC_DEFUN([ACJF_NEED_PKG],
 [m4_if([$2$3], [], [], [m4_errprint(
[Action if yes and action if no arguments for ACJF_NEED_PKG are obsolete,
please use ACJF_CHECK_PKG!
])m4_exit([-1])])dnl
  ACJF_CHECK_PKG([$1],
  [AM_CPPFLAGS="$AM_CPPFLAGS $[]ACJF_M4_CANON_DN([$1])[_CPPFLAGS]"
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
dnl   PKGNAME_INCLUDE        only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS       PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LFLAGS         only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER  odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS        PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS           -l options (whitespace seperated)
dnl   PKGNAME_FOUND          yes or no
dnl IF pkg is from srcdir:
dnl   PKGNAME_INCPATH include directory
dnl   PKGNAME_LIBPATH library directory
dnl   pkg_pkgname_srcdir
dnl   pkg_pkgname_builddir
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true
dnl IF pkg is from extern:
dnl   PKGNAME_INCPATH if possible whitespace seperated list of include directories
dnl   PKGNAME_LIBPATH if possible whitespace seperated list of library directories
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := false
AC_DEFUN([ACJF_CHECK_LIB], [dnl
ACJF_ARG_WITHPKG([$1], m4_if([$2], [], [], [[intern]])[ extern])dnl
ACJF_CHECK_LIB_TESTER([$1], [$2], ACJF_CHECK_LIB_TESTMACROGEN([$3], [$4], [$5]), [$6], [$7])dnl
])

dnl ACJF_CONFIG_PKG(
dnl   <pkgname>,
dnl   <srcdir subdirectory name>)
dnl
dnl create --with-pkgname option to selectively activate and deactivate
dnl compilation of the package.
AC_DEFUN([ACJF_CONFIG_PKG], [dnl
  m4_if(m4_eval([$#<=1]), [1],
   [m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])
    m4_pushdef([ACJF_VAR_SUBDIR], [[$1]])],
   [m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])
    m4_pushdef([ACJF_VAR_SUBDIR], [[$2]])])
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, [compile])
  if echo ["$acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list " | grep "^[ 	]*acjf_bundled[ 	]"] >/dev/null; then
    if test -d "$srcdir/ACJF_VAR_SUBDIR"; then
      AC_CONFIG_SUBDIRS(ACJF_VAR_SUBDIR)
    elif test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"yes"; then
      AC_MSG_ERROR([source tree version for ]ACJF_VAR_PKGNAME[ is missing!])
    fi
  fi
  m4_popdef([ACJF_VAR_PKGNAME])
  m4_popdef([ACJF_VAR_SUBDIR])
])
