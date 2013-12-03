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

dnl ACJF_PKG_CLEARLOC
dnl   <pkgname>)
dnl
dnl Clear search list for <pkgname>.
AC_DEFUN([ACJF_PKG_CLEARLOC], [AC_REQUIRE([ACJF_INIT])dnl
  unset [acjf_]ACJF_M4_CANON_DC([$1])[_search_list];
])

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

dnl ACJF_PKG_ADDLOC_INTERN(
dnl   <pkgname>)
dnl
dnl Add source tree version to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_INTERN], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_bundled";
])

dnl ACJF_PKG_ADDLOC_STD(
dnl   <pkgname>)
dnl
dnl Add standard include/lib to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_STD], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_std";
])

dnl ACJF_PKG_ADDLOC_DISABLED(
dnl   <pkgname>)
dnl
dnl Add disabled as a valid state for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_DISABLED], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_disabled";
])

dnl ACJF_PKG_ADDLOC_PREFIX(
dnl   <pkgname>,
dnl   <prefix>)
dnl
dnl Add <prefix> to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_PREFIX], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="from install location $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="inclib"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2/include"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$2/lib"];
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
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="includes from $2, libs from $3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="inclib"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$3"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_PKG_ADDLOC_PKGCONFIG_INTERN(
dnl   <pkgname>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> from source tree
AC_DEFUN([ACJF_PKG_ADDLOC_PKGCONFIG_INTERN], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="source tree via pkg-config for $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config-bundled"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_pkg_config_dir=""];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_PKG_ADDLOC_PKGCONFIG_STD(
dnl   <pkgname>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> from standard pkg-config search path
AC_DEFUN([ACJF_PKG_ADDLOC_PKGCONFIG_STD], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="standard search paths via pkg-config for $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_pkg_config_dir=""];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_PKG_ADDLOC_PKGCONFIG_PREFIX(
dnl   <pkgname>,
dnl   <prefix>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> under <prefix>/lib/pkgconfig to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_PKG_ADDLOC_PKGCONFIG_PREFIX], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="$2 via pkg-config for $3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_pkg_config_dir="$2/lib/pkgconfig"];
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
      [acjf_cv_]ACJF_M4_CANON_DC([$2])[_type]="configscript"
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

dnl ACJF_PKG_EVALLOC(
dnl   <varprefix>,
dnl   <searchentry>)
dnl 
dnl Requires:
dnl   ACJF_VAR_SUBDIR_LIST must be defined
dnl   ACJF_VAR_PKGNAME     must be defined
dnl
dnl evaluate the given <searchentry> and set the shell variables
dnl   <varprefix>_invalid
dnl   <varprefix>_incpath
dnl   <varprefix>_libpath
dnl   <varprefix>_cppflags_other
dnl   <varprefix>_ldflags_other
dnl   <varprefix>_libs
dnl
AC_DEFUN([ACJF_PKG_EVALLOC], [AC_REQUIRE([ACJF_INIT])AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
  m4_ifdef([ACJF_VAR_SUBDIR_LIST], [], [m4_fatal([Missing definition of ACJF_VAR_SUBDIR_LIST macro!])])dnl
  m4_ifdef([ACJF_VAR_PKGNAME],     [], [m4_fatal([Missing definition of ACJF_VAR_PKGNAME macro!])])dnl
  eval [$1_desc=\$${$2}_desc;]
  eval [$1_type=\$${$2}_type;]
  if test [x"$$1_type" = x"bundled";] then
    m4_if(ACJF_VAR_SUBDIR_LIST, [], 
     [AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location not given in configure.in!])],
     [_ACJF_SOURCE_TREE_LOCATION_SEARCHER(acjf_var_pkgname_srcdir)
      if test x"$acjf_var_pkgname_srcdir" != x"/invalid" -a -f "$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir/Makefile"; then
        $1_invalid="no";
        if test -d "$srcdir/$acjf_var_pkgname_srcdir/pkginclude"; then
          $1_incpath="$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir/pkginclude $srcdir/$acjf_var_pkgname_srcdir/pkginclude"
        else
          $1_incpath="$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir $srcdir/$acjf_var_pkgname_srcdir/include $srcdir/$acjf_var_pkgname_srcdir"
        fi
        $1_libpath="$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir"
        $1_cppflags_other=""
        $1_ldflags_other=""
        $1_libs=""
      else
        $1_invalid="yes";
      fi
      unset acjf_var_pkgname_srcdir
     ])
  elif test [x"$$1_type" = x"pkg-config";] then
    eval [$1_modules=\$${$2}_modules;]
    eval [$1_pkg_config_dir=\$${$2}_pkg_config_dir;]
    acjf_var_old_PKG_CONFIG_PATH=${PKG_CONFIG_PATH}

    PKG_CHECK_MODULES(
      [acjf_var_pkg_],
      [$$1_modules],
      [$1_invalid="no";],
      [$1_invalid="yes";])


    PKG_CONFIG_PATH=${acjf_var_old_PKG_CONFIG_PATH}
  elif test [x"$$1_type" = x"pkg-config-bundled";] then
    m4_if(ACJF_VAR_SUBDIR_LIST, [], 
     [AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location not given in configure.in!])],
     [_ACJF_SOURCE_TREE_LOCATION_SEARCHER(acjf_var_pkgname_srcdir)
      if test x"$acjf_var_pkgname_srcdir" != x"/invalid" -a -f "$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir/Makefile"; then
        eval [$1_modules=\$${$2}_modules;]
        eval [$1_pkg_config_dir=\$${$2}_pkg_config_dir;]
        acjf_var_old_PKG_CONFIG_PATH=${PKG_CONFIG_PATH}
        PKG_CONFIG_PATH="$acjf_abs_top_builddir/$acjf_var_pkgname_srcdir/pkgconfig"
        export PKG_CONFIG_PATH
dnl     echo "PKG_CONFIG_PATH: $PKG_CONFIG_PATH"
        if test -n "$PKG_CONFIG" && AC_RUN_LOG([$PKG_CONFIG --exists --print-errors "${$1_modules}"]); then
dnl       echo "yep"
          [$1_invalid="no";]
          [$1_incpath=`$PKG_CONFIG --cflags-only-I "${$1_modules}" 2>/dev/null | sed -e 's/^-I[ 	]*//;s/[ 	][ 	]*-I[ 	]*/ /g'`;]
          [$1_libpath=`$PKG_CONFIG --libs-only-L   "${$1_modules}" 2>/dev/null | sed -e 's/^-L[ 	]*//;s/[ 	][ 	]*-L[ 	]*/ /g'`;]
          [$1_cppflags_other=`$PKG_CONFIG --cflags-only-other "${$1_modules}" 2>/dev/null`;]
          [$1_ldflags_other=`$PKG_CONFIG --libs-only-other "${$1_modules}" 2>/dev/null`;]
          [$1_libs=`$PKG_CONFIG --libs-only-l "${$1_modules}" 2>/dev/null`;]
        else
dnl       echo "nope"
          [$1_invalid="yes";]
          _PKG_SHORT_ERRORS_SUPPORTED
          if test $_pkg_short_errors_supported = yes; then
            acjf_var_PKG_ERRORS=`$PKG_CONFIG --short-errors --errors-to-stdout --print-errors "$2"`
          else 
            acjf_var_PKG_ERRORS=`$PKG_CONFIG --errors-to-stdout --print-errors "$2"`
          fi
          # Put the nasty error message in config.log where it belongs
          echo "$acjf_var_PKG_ERRORS" >&AS_MESSAGE_LOG_FD
        fi
        PKG_CONFIG_PATH=${acjf_var_old_PKG_CONFIG_PATH}
      else
        $1_invalid="yes";
      fi
      unset acjf_var_pkgname_srcdir
     ])
  else
    eval [$1_invalid=\$${$2}_invalid;]
    eval [$1_incpath=\$${$2}_incpath;]
    eval [$1_libpath=\$${$2}_libpath;]
    eval [$1_cppflags_other=\$${$2}_cppflags_other;]
    eval [$1_ldflags_other=\$${$2}_ldflags_other;]
    eval [$1_libs=\$${$2}_libs;]
  fi
dnl echo ["$1_desc=$$1_desc";]
dnl echo ["$1_type=$$1_type";]
dnl echo ["$1_invalid=$$1_invalid";]
dnl echo ["$1_incpath=$$1_incpath";]
dnl echo ["$1_libpath=$$1_libpath";]
dnl echo ["$1_cppflags_other=$$1_cppflags_other";]
dnl echo ["$1_ldflags_other=$$1_ldflags_other";]
dnl echo ["$1_libs=$$1_libs";]
])

dnl ACJF_ARG_WITHPKG(
dnl   <pkgname>,
dnl   <tags>)
dnl
dnl uses the following env vars as defaults:
dnl   <PKGNAME>_PREFIX          if <tags> contains extern
dnl   <PKGNAME>_INCLUDE         if <tags> contains extern and does not contain pkgconfig:xxx or configscript:xxx
dnl   <PKGNAME>_LIB             if <tags> contains extern and does not contain pkgconfig:xxx or configscript:xxx
dnl
dnl generates the following configure options
dnl   --with-<pkgname>
dnl   --with-<pkgname>-include  if <tags> contains extern and does not contain pkgconfig:xxx or configscript:xxx
dnl   --with-<pkgname>-lib      if <tags> contains extern and does not contain pkgconfig:xxx or configscript:xxx
dnl
dnl tags (empty defaults to extern, precedence is in order of sequence):
dnl   disabled         if no --with-<pkgname> option is specified disable the package
dnl   pkgconfig:xxx    use pkgconfig module xxx to find the package
dnl   configscript:xxx use config script xxx to find the package
dnl   intern           provide intern tag to --with-<pkgname> option
dnl   extern           provide extern tag to --with-<pkgname> option
dnl
dnl Examples:
dnl   [[extern],[inter]]              => Try external location first, if not found use internal version
dnl   [[intern]]                      => Use internal version if not disabled
dnl   [[disabled],[intern],[extern]]  => If no --with-<pkgname> option is given the package is disabled,
dnl                                      otherwise try the internal version first, after that fall back
dnl                                      to external version
dnl set shell vars
dnl   acjf_<pkgname>_search_list
AC_DEFUN([ACJF_ARG_WITHPKG], [AC_REQUIRE([ACJF_INIT])dnl
m4_divert_push([INIT_PREPARE])
ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_ARG_WITHPKG::$1]), [
  dnl Setup ACJF_VAR_PKGNAME and ACJF_VAR_TAGS macros
  m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])dnl
  dnl if no tags are specified add extern tag
  m4_if([$2], [],
   [m4_pushdef([ACJF_VAR_TAGS], [[[extern]]])],
   [m4_pushdef([ACJF_VAR_TAGS], [[$2]])])dnl
  dnl append disabled tag to tags if not found
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<disabled\>]), [-1],
   [ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_TAGS], [[disabled]])])dnl
  m4_pushdef([ACJF_VAR_CONFIGSCRIPT], [])dnl
  m4_pushdef([ACJF_VAR_PKGCONFIGMOD], [])dnl
  m4_pushdef([ACJF_VAR_WITHOPT], ACJF_M4_DOWNCASE(m4_bpatsubst(ACJF_M4_QUOTE(ACJF_VAR_PKGNAME), [\([^][a-zA-Z0-9]\|[ 	]+\)],[-])))dnl
  m4_pushdef([ACJF_VAR_WITHLIST], [])dnl
  m4_pushdef([ACJF_VAR_DEFAULTMSG], [[ (default)]])dnl
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS, [
    m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [intern], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], [intern to use the source tree version]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [compile], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], [intern to compile the source tree version]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [extern], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], [prefix or extern to use an installed library]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [disabled], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], [no to disable]ACJF_VAR_DEFAULTMSG)dnl
    ])])])])dnl
    dnl only first is marked as default
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [intern\|compile\|extern\|disabled]), [0],
     [m4_define([ACJF_VAR_DEFAULTMSG], [[]])])
    dnl set ACJF_VAR_CONFIGSCRIPT from configscript:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [configscript:]), [0],
     [m4_define([ACJF_VAR_CONFIGSCRIPT], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<configscript:\(.*\)], [[\1]]))])dnl
    dnl set ACJF_VAR_PKGCONFIGMOD from pkgconfig:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [pkgconfig:]), [0],
     [m4_define([ACJF_VAR_PKGCONFIGMOD], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<pkgconfig:\(.*\)], [[\1]]))])dnl
  ])dnl
  m4_popdef([ACJF_VAR_DEFAULTMSG])dnl
  [unset acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)
  AC_ARG_WITH(ACJF_VAR_WITHOPT,
    AS_HELP_STRING([[--with-]ACJF_VAR_WITHOPT], ACJF_M4_JOIN(ACJF_VAR_WITHLIST, [[§1]], [, ])),
    [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[="$withval"])dnl
  m4_popdef([ACJF_VAR_WITHLIST])dnl
  m4_popdef([ACJF_VAR_WITHOPT])dnl
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<extern\>]), [-1], [],
   [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<pkgconfig:]), [-1],
     [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<configscript:]), [-1], 
       [dnl extern but no pkgconfig:xxx and no configscript:xxx in tags
        unset [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]
        AC_ARG_WITH(ACJF_M4_DOWNCASE(ACJF_VAR_PKGNAME)[-include],
          AS_HELP_STRING([--with-]ACJF_M4_DOWNCASE(ACJF_VAR_PKGNAME)[-include], [include path for $1]),
          [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath="$withval"])dnl
        unset [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]
        AC_ARG_WITH(ACJF_M4_DOWNCASE(ACJF_VAR_PKGNAME)[-lib],
          AS_HELP_STRING([--with-]ACJF_M4_DOWNCASE(ACJF_VAR_PKGNAME)[-lib], [library path for $1]),
          [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath="$withval"])dnl
        if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" = x"" -a \
                x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" = x"" -a \
                x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" = x""; then
          # No --with-<pkgname>[-include|-lib] options. Fall back to environment variables!
          AC_ARG_VAR(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PREFIX], [Install prefix for ]ACJF_VAR_PKGNAME[; Search in <prefix>/{lib,include} for ]ACJF_VAR_PKGNAME[.])dnl
          AC_ARG_VAR(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIB], [Explicit list of lib directories for ]ACJF_VAR_PKGNAME)dnl
          AC_ARG_VAR(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE], [Explicit list of include directories for ]ACJF_VAR_PKGNAME)dnl
          [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="[$]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_BASE]";
          [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="[$]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]";
          [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]="[$]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIB]";
        fi
        if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"" -o \
                x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" != x""; then
          if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" = x""; then
            case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
              "/"*)
                [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)/include"
                ;;
              *)
                $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]=`echo $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath] | sed -e 's@/lib\(/[^ 	]*\|\)\([ 	]\|$\)@/include @g'`;
                ;;
            esac
          fi
          if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" = x""; then
            case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
              "/"*)
                [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]="$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)/lib"
                ;;
              *)
                $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]=`echo $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath] | sed -e 's@/include\(/[^ 	]*\|\)\([ 	]\|$\)@/lib@g'`;
                ;;
            esac
          fi
          case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
            ""|"/"*|yes|extern)
              [acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)="extern"
              ;;
            *)
              AC_MSG_ERROR([Options --with-]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)=$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[ and --with-]ACJF_M4_DOWNCASE(ACJF_VAR_PKGNAME)[[-include|-lib] clash!])
              ;;
          esac
        fi
       ],
       [])dnl not m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<configscript:]), ...)
     ],
     [])dnl not m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<pkgconfig:]), ...)
   ])dnl m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<extern\>]), ...)
  
  dnl Clear search list for <pkgname>. The search list will later be populated
  dnl via ACJF_PKG_ADDLOC_XXX macros.
  ACJF_PKG_CLEARLOC(ACJF_VAR_PKGNAME)dnl
  acjf_var_matchtag=no
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS, [
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [intern\|compile]), [0],
     [case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
        ""|yes|intern)
          m4_if(ACJF_VAR_PKGCONFIGMOD, [],
           [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
             [dnl neither configscript nor pkgconfig mode
              ACJF_PKG_ADDLOC_INTERN(ACJF_VAR_PKGNAME)
             ],
             [dnl configscript mode


             ])
           ],
           [dnl pkgconfig mode
            ACJF_PKG_ADDLOC_PKGCONFIG_INTERN(ACJF_VAR_PKGNAME, ACJF_VAR_PKGCONFIGMOD)dnl
           ])dnl
          acjf_var_matchtag=yes
          ;;
      esac
     ])dnl
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [extern\|compile]), [0],
     [case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
        ""|yes|extern)
          m4_if(ACJF_VAR_PKGCONFIGMOD, [],
           [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
             [dnl neither configscript nor pkgconfig mode
              if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"" -o \
                      x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" != x""; then
                ACJF_PKG_ADDLOC_INCLIB(ACJF_VAR_PKGNAME,
                  [$acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath],
                  [$acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath])
              else
                ACJF_PKG_ADDLOC_STD(ACJF_VAR_PKGNAME)
              fi
             ],
             [dnl configscript mode

             ])
           ],
           [dnl pkgconfig mode
            ACJF_PKG_ADDLOC_PKGCONFIG_STD(ACJF_VAR_PKGNAME, ACJF_VAR_PKGCONFIGMOD)dnl
           ])dnl
          acjf_var_matchtag=yes
          ;;
        "/"*)
          m4_if(ACJF_VAR_PKGCONFIGMOD, [],
           [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
             [dnl neither configscript nor pkgconfig mode
              ACJF_PKG_ADDLOC_PREFIX(ACJF_VAR_PKGNAME, $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME))
             ],
             [dnl configscript mode

             ])
           ],
           [dnl pkgconfig mode
            ACJF_PKG_ADDLOC_PKGCONFIG_PREFIX(ACJF_VAR_PKGNAME, $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME), ACJF_VAR_PKGCONFIGMOD)dnl
           ])dnl
          acjf_var_matchtag=yes
          ;;
      esac
     ])dnl
    m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [disabled],
     [case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
        ""|no)
          ACJF_PKG_ADDLOC_DISABLED(ACJF_VAR_PKGNAME)
          acjf_var_matchtag=yes
          ;;
      esac
     ])dnl
  ])dnl
  if test x"$acjf_var_matchtag" = x"no"; then
    AC_MSG_ERROR([Option --with-]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)=$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[ is not supported!])
  fi
  unset acjf_var_tag
  unset acjf_var_matchtag
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
  m4_popdef([ACJF_VAR_CONFIGSCRIPT])dnl
  m4_popdef([ACJF_VAR_PKGCONFIGMOD])dnl
])dnl ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_ARG_WITHPKG::$1]), ...)
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
  # Last ditch effort try three uplevel directories
  for acjf_var_subdir in ACJF_VAR_SUBDIR_LIST; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../../../$acjf_var_subdir"; then
      $1="../../../$acjf_var_subdir";
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
      for ACJF_VAR_ANON_SHELLVARPREFIX[item] in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
        ACJF_PKG_EVALLOC([acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME), ACJF_VAR_ANON_SHELLVARPREFIX[item])
        if test x"${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]}" = x"disabled"; then
          break
        elif test x"${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_invalid]}" = x"yes"; then
          AC_MSG_CHECKING([for ]ACJF_VAR_PKGNAME[ package in ${acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc}])
          AC_MSG_RESULT([no])
        else
          CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS]"
          if test x"${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]}" != x"$acjf_std_incpath"; then
            for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in ${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]}; do
              CPPFLAGS="$CPPFLAGS -I$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
            done
          fi
          CPPFLAGS="$CPPFLAGS ${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]}";
          LDFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]"
          if test x"${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]}" != x"$acjf_std_libpath"; then
            for ACJF_VAR_ANON_SHELLVARPREFIX[item2] in ${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]}; do
              LDFLAGS="$LDFLAGS -L$ACJF_VAR_ANON_SHELLVARPREFIX[item2]";
            done
          fi
          LDFLAGS="$LDFLAGS ${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]}";
          LIBS="$ACJF_VAR_ANON_SHELLVARPREFIX[LIBS] ${[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]}";
dnl       echo "CPPFLAGS: $CPPFLAGS"
dnl       echo "LDFLAGS: $LDFLAGS"
dnl       echo "LIBS: $LIBS"
          ACJF_M4_UNQUOTE(ACJF_VAR_TEST_MACRO[(
           ACJF_VAR_PKGNAME,
           [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc],
           [break],
           [false])])
        fi
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]
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
    [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]="missing"
    [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]="missing")
  if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"missing"dnl
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
     [ -o x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"$acjf_disabled_type"]); then
    AC_MSG_ERROR([Cannot find ACJF_VAR_PKGNAME package, bailing out!])
  fi

  ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::B::$1::subdir::$2]), [
    dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::B::$1::subdir::$2]) [[BEGIN]]"

    if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"$acjf_bundled_type"; then
      _ACJF_SOURCE_TREE_LOCATION_SEARCHER(ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir])
      if test x"$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]" != x"/invalid"; then
        dnl we need abs pathes ($acjf_abs_top_srcdir) here to enable a correct fixup also for relative configure calls.
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]="$acjf_abs_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]" 
        dnl we need abs pathes ($acjf_abs_top_builddir) here to enable a correct fixup also for relative configure calls.
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]="$acjf_abs_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
        if test -d "$srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"; then
          dnl we need abs pathes ($acjf_abs_top_srcdir/$acjf_abs_top_builddir) here to enable a correct fixup also for relative configure calls.
          [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$acjf_abs_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude $acjf_abs_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/pkginclude"
        else
          dnl we need abs pathes ($acjf_abs_top_srcdir/$acjf_abs_top_builddir) here to enable a correct fixup also for relative configure calls.
          [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]="$acjf_abs_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir] $acjf_abs_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]/include $acjf_abs_top_srcdir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
        fi
        dnl we need abs pathes ($acjf_abs_top_builddir) here to enable a correct fixup also for relative configure calls.
        [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]="$acjf_abs_top_builddir/$ACJF_VAR_ANON_SHELLVARPREFIX[pkgname_srcdir]"
      else
        AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location given in configure.in is nonexistent!])
      fi
    fi

    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]"
    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]"
    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]"
    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]"
    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]"
    dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]"

    if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" != x"$acjf_disabled_type"; then
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

    m4_if(ACJF_VAR_SUBDIR_LIST, [], [],
     [m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION])
      m4_divert_push([INIT_PREPARE])
      ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION]),
        [AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION], [false])])
      m4_divert_pop([INIT_PREPARE])
      AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION],
        test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"$[acjf_bundled_type]")
      if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"$[acjf_bundled_type]"; then
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

  if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" != x"$acjf_disabled_type"; then
    m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_TRUE";
      ACJF_VAR_CODE_IF_TRUE])
  else
    m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_FALSE";
      ACJF_VAR_CODE_IF_FALSE])
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
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl If not source tree location => execute code if not found
dnl If source tree location => execute code if found
AC_DEFUN([ACJF_CHECK_PKG_TESTMACRO], [
  AC_MSG_CHECKING([for $1 package in $$2])
  if test x"$[acjf_cv_]ACJF_M4_CANON_DC([$1])[_type]" = x"bundled" -o \
          x"$[acjf_cv_]ACJF_M4_CANON_DC([$1])[_type]" = x"pkg-config-bundled" -o \
          x"$[acjf_cv_]ACJF_M4_CANON_DC([$1])[_type]" = x"pkg-config"; then
    AC_MSG_RESULT([yes]);
    m4_if([$3], [], [true], [$3])
  else
    AC_MSG_RESULT([no]);
    m4_if([$4], [], [false], [$4])
  fi
])

dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl  [<tags>,]
dnl  [<possible location in source tree>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl tags (empty defaults to intern, precedence is in order of sequence):
dnl   disabled         if no --with-<pkgname> option is specified disable the package
dnl   pkgconfig:xxx    use pkgconfig module xxx to find the package
dnl   intern           provide intern tag to --with-<pkgname> option
dnl
dnl Examples:
dnl   [[intern]]             => Use internal version if not disabled
dnl   [[disabled],[intern]]  => If no --with-<pkgname> option is given the package is disabled
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
  m4_pushdef([ACJF_VAR_ARGSLIST], [[$@]])dnl
  dnl echo "ACJF_VAR_ARGSLIST"
  dnl m4_pattern_allow([ACJF_VAR_PKGNAME])dnl
  m4_pushdef([ACJF_VAR_PKGNAME], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))dnl
  dnl echo "[ACJF_VAR_PKGNAME]: ACJF_VAR_PKGNAME"
  dnl echo "ACJF_VAR_ARGSLIST"
  dnl m4_pattern_allow([ACJF_VAR_TAGS])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [\<disabled\>\|\<intern\>\|\<extern\>\|\<pkgconfig:\|\<configscript:]), [-1],
   [m4_pushdef([ACJF_VAR_TAGS], [[]])],
   [m4_pushdef([ACJF_VAR_TAGS], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])])dnl
  dnl echo "[ACJF_VAR_TAGS]: ACJF_VAR_TAGS"
  dnl echo "ACJF_VAR_ARGSLIST"
  dnl check that no extern tag is given
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<extern\>]), [-1], [],
   [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<pkgconfig:]), [-1],
     [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<configscript:]), [-1],
       [m4_fatal([No extern tag supported in ACJF_CHECK_PKG(]ACJF_M4_QUOTE(ACJF_VAR_PKGNAME)[,]ACJF_M4_QUOTE(ACJF_VAR_TAGS)[,...) without pkgconfig:xxx or configscript:xxx tags!])])])])dnl
  dnl append intern tag to tags if not found
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<intern\>]), [-1],
   [ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_TAGS], [[intern]])])
  dnl echo "[ACJF_VAR_TAGS]: ACJF_VAR_TAGS"
  dnl m4_pattern_allow([ACJF_VAR_SUBDIR_LIST])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [[=;]\|^$]), [-1],
   [m4_pushdef([ACJF_VAR_SUBDIR_LIST], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))],
   [m4_pushdef([ACJF_VAR_SUBDIR_LIST], ACJF_M4_QUOTE(ACJF_VAR_PKGNAME))])dnl
  dnl echo "[ACJF_VAR_SUBDIR_LIST]: ACJF_VAR_SUBDIR_LIST"
  dnl echo "ACJF_VAR_ARGSLIST"
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl echo "[ACJF_VAR_CODE_IF_TRUE]: ACJF_VAR_CODE_IF_TRUE"
  dnl echo "ACJF_VAR_ARGSLIST"
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl echo "[ACJF_VAR_CODE_IF_FALSE]: ACJF_VAR_CODE_IF_FALSE"
  dnl echo "ACJF_VAR_ARGSLIST"
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS)dnl
  ACJF_CHECK_LIB_TESTER(ACJF_VAR_PKGNAME, ACJF_VAR_SUBDIR_LIST,
    [ACJF_CHECK_PKG_TESTMACRO],
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_SUBDIR_LIST])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
  m4_popdef([ACJF_VAR_ARGSLIST])dnl
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
ACJF_ARG_WITHPKG([$1], m4_if([$2], [], [[[extern]]], [[[intern],[extern]]]))dnl
ACJF_CHECK_LIB_TESTER([$1], [$2], ACJF_CHECK_LIB_TESTMACROGEN([$3], [$4], [$5]), [$6], [$7])dnl
])

dnl NEW ACJF_CONFIG_PKG USAGE:
dnl
dnl ACJF_CONFIG_PKG(
dnl   <pkgname>,
dnl   <tags>
dnl   <srcdir subdirectory name>)
dnl
dnl tags (empty defaults to compile):
dnl   disabled:         if no --with-xxxx option is specified disable the package
dnl
dnl OBSOLETE ACJF_CONFIG_PKG USAGE: 
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl   <srcdir subdirectory name>)
dnl
dnl create --with-pkgname option to selectively activate and deactivate
dnl compilation of the package.
AC_DEFUN([ACJF_CONFIG_PKG], [dnl
  m4_if(m4_eval([$#<=1]), [1],
   [m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])
    m4_pushdef([ACJF_VAR_SUBDIR], [[$1]])
    m4_pushdef([ACJF_VAR_TAGS], [[]])],
   [m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])
    m4_if(m4_eval([$#<=2]), [1],
     [m4_if(m4_bregexp([$2], [disabled\|compile]), [-1],
       [m4_pushdef([ACJF_VAR_SUBDIR], [[$2]])
        m4_pushdef([ACJF_VAR_TAGS], [[]])],
       [m4_pushdef([ACJF_VAR_SUBDIR], [[$1]])
        m4_pushdef([ACJF_VAR_TAGS], [[$2]])])],
     [m4_pushdef([ACJF_VAR_TAGS], [[$2]])
      m4_pushdef([ACJF_VAR_SUBDIR], [[$3]])])])
  dnl echo "[FLUPS_VAR_PKGNAME]: ACJF_VAR_PKGNAME"
  dnl echo "[FLUPS_VAR_SUBDIR]:  ACJF_VAR_SUBDIR"
  dnl echo "[FLUPS_VAR_TAGS]:    ACJF_VAR_TAGS"
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, ACJF_M4_LIST_PUSH_BACK(ACJF_VAR_TAGS,[[compile]]))
  acjf_var_bundled=no
  acjf_var_alt=no
  for acjf_var_item in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
    eval acjf_var_item_type=\$${acjf_var_item}_type;
    if test x"$acjf_var_item_type" = x"bundled" -o \
            x"$acjf_var_item_type" = x"pkg-config-bundled"; then
      acjf_var_bundled=yes
    else
      acjf_var_alt=yes
    fi
  done
  if test -d "$srcdir/ACJF_VAR_SUBDIR"; then
    if test x"$acjf_var_bundled" = x"yes"; then
      AC_CONFIG_SUBDIRS(ACJF_VAR_SUBDIR)
    fi
  else
    if test x"$acjf_var_bundled" = x"yes" -a x"$acjf_var_alt" = x"no"; then
      AC_MSG_ERROR([source tree version for ]ACJF_VAR_PKGNAME[ is missing!])
    fi
  fi
  unset acjf_var_bundled
  unset acjf_var_alt
  unset acjf_var_item
  unset acjf_var_item_type
  m4_popdef([ACJF_VAR_PKGNAME])
  m4_popdef([ACJF_VAR_SUBDIR])
  m4_popdef([ACJF_VAR_TAGS])
])
