dnl vim: set sw=2 ts=8 syn=config:
dnl Copyright (C) 2001 - 2014 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_SEARCHLOC_CLEAR
dnl   <pkgname>)
dnl
dnl Clear search list for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_CLEAR], [AC_REQUIRE([ACJF_INIT])dnl
  unset [acjf_]ACJF_M4_CANON_DC([$1])[_search_list];
])

dnl ACJF_SEARCHLOC_COPY(
dnl   <src pkgname>, <dst pkgname>)
dnl
dnl Copy search option form <src pkgname>, usually derived by macro
dnl ACJF_ARG_WITHPKG, to <dst pkgname>. This enables the usage of
dnl a simple --with-<src pkgname> option to control the location of
dnl multiple libraries <dst pkgname>s.
AC_DEFUN([ACJF_SEARCHLOC_COPY], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$2])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list]"
])

dnl ACJF_SEARCHLOC_ADD_INTERN(
dnl   <pkgname>)
dnl
dnl Add source tree version to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_INTERN], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_bundled";
])

dnl ACJF_SEARCHLOC_ADD_STD(
dnl   <pkgname>)
dnl
dnl Add standard include/lib to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_STD], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_std";
])

dnl ACJF_SEARCHLOC_ADD_DISABLED(
dnl   <pkgname>)
dnl
dnl Add disabled as a valid state for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_DISABLED], [AC_REQUIRE([ACJF_INIT])dnl
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] acjf_disabled";
])

dnl ACJF_SEARCHLOC_ADD_PREFIX(
dnl   <pkgname>,
dnl   <prefix>)
dnl
dnl Add <prefix> to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_PREFIX], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="from install location $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="inclib"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2/include"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$2/lib"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_ADD_INCLIB(
dnl   <pkgname>,
dnl   <include path>,
dnl   <lib path>)
dnl
dnl Add <include path> and <lib path> to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_INCLIB], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="includes from $2, libs from $3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="inclib"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_incpath="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_libpath="$3"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_ADD_PKGCONFIG_INTERN(
dnl   <pkgname>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> from source tree
AC_DEFUN([ACJF_SEARCHLOC_ADD_PKGCONFIG_INTERN], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="source tree via pkg-config for $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config-bundled"];
  dnl ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$2"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_ADD_PKGCONFIG_STD(
dnl   <pkgname>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> from standard pkg-config search path
AC_DEFUN([ACJF_SEARCHLOC_ADD_PKGCONFIG_STD], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="standard search paths via pkg-config for $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config"];
  dnl ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_pkg_config_dir=""];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_ADD_PKGCONFIG_PREFIX(
dnl   <pkgname>,
dnl   <prefix>,
dnl   <pkgconfig>)
dnl
dnl Add <pkgconfig> under <prefix>/lib/pkgconfig to the list of search locations for <pkgname>.
AC_DEFUN([ACJF_SEARCHLOC_ADD_PKGCONFIG_PREFIX], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="$2 via pkg-config for $3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="pkg-config"];
  dnl ACJF_VAR_ANONYMOUS_SHELL_VAR[_modules="$3"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_pkg_config_dir="$2/lib/pkgconfig"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_ADD_CONFIGSCRIPT(
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
AC_DEFUN([ACJF_SEARCHLOC_ADD_CONFIGSCRIPT], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ANONYMOUS_SHELL_VAR], ACJF_GEN_ANONYMOUS_SHELL_VAR)
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_desc="configuration from $2"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_type="configscript"];
  ACJF_VAR_ANONYMOUS_SHELL_VAR[_configscript="$2"];
  dnl Register vars on search list!
  [acjf_]ACJF_M4_CANON_DC([$1])[_search_list]="$[acjf_]ACJF_M4_CANON_DC([$1])[_search_list] ACJF_VAR_ANONYMOUS_SHELL_VAR";
  m4_popdef([ACJF_VAR_ANONYMOUS_SHELL_VAR])
])

dnl ACJF_SEARCHLOC_EVALUATE(
dnl   <varprefix>,
dnl   <searchentry>)
dnl 
dnl Requires:
dnl   ACJF_VAR_SUBDIR         must be defined
dnl   ACJF_VAR_PKGNAME        must be defined
dnl   ACJF_VAR_PKGCONFIGMOD   must be defined
dnl   ACJF_VAR_CONFIGSCRIPT   must be defined
dnl
dnl evaluate the given <searchentry> and set the shell variables
dnl   <varprefix>_desc
dnl   <varprefix>_type
dnl   <varprefix>_invalid
dnl   <varprefix>_incpath
dnl   <varprefix>_libpath
dnl   <varprefix>_cppflags_other
dnl   <varprefix>_ldflags_other
dnl   <varprefix>_libs
dnl   <varprefix>_deps
dnl
AC_DEFUN([ACJF_SEARCHLOC_EVALUATE], [AC_REQUIRE([ACJF_INIT])AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
  m4_ifdef([ACJF_VAR_SUBDIR],       [], [m4_fatal([Missing definition of ACJF_VAR_SUBDIR macro!])])dnl
  m4_ifdef([ACJF_VAR_PKGNAME],      [], [m4_fatal([Missing definition of ACJF_VAR_PKGNAME macro!])])dnl
  m4_ifdef([ACJF_VAR_PKGCONFIGMOD], [], [m4_fatal([Missing definition of ACJF_VAR_PKGCONFIGMOD macro!])])dnl
  m4_ifdef([ACJF_VAR_CONFIGSCRIPT], [], [m4_fatal([Missing definition of ACJF_VAR_CONFIGSCRIPT macro!])])dnl
  eval [$1_desc=\$${$2}_desc]
  eval [$1_type=\$${$2}_type]
  eval [$1_invalid=\$${$2}_invalid]
  eval [$1_incpath=\$${$2}_incpath]
  eval [$1_libpath=\$${$2}_libpath]
  eval [$1_cppflags_other=\$${$2}_cppflags_other]
  eval [$1_ldflags_other=\$${$2}_ldflags_other]
  eval [$1_libs=\$${$2}_libs]
  eval [$1_deps=\$${$2}_deps]
dnl  echo "INITIAL:"
dnl  echo ["  $1_desc=${$1_desc}"]
dnl  echo ["  $1_type=${$1_type}"]
dnl  echo ["  $1_invalid=${$1_invalid}"]
dnl  echo ["  $1_incpath=${$1_incpath}"]
dnl  echo ["  $1_libpath=${$1_libpath}"]
dnl  echo ["  $1_cppflags_other=${$1_cppflags_other}"]
dnl  echo ["  $1_ldflags_other=${$1_ldflags_other}"]
dnl  echo ["  $1_libs=${$1_libs}"]
dnl  echo ["  $1_deps=${$1_deps}"]
  
  if test [x"${$1_invalid}" != x"yes"]; then
    if test [x"${$1_type}" = x"bundled" -o x"${$1_type}" = x"pkg-config-bundled";] then
      m4_if(ACJF_VAR_SUBDIR, [],
       [AC_MSG_ERROR([Internal error: internal location specified for ACJF_VAR_PKGNAME but source tree location not given in configure.in!])])dnl
      _ACJF_PKG_SRCTREE_SEARCHER(acjf_var_pkgname_srcdir)dnl
      if test [x"${acjf_var_pkgname_srcdir}" != x"/invalid" -a -f "${acjf_abs_top_builddir}/${acjf_var_pkgname_srcdir}/Makefile";] then
        dnl we need abs pathes (${acjf_abs_top_srcdir}) here to enable a correct fixup also for relative configure calls.
        [$1_srcdir="${acjf_abs_top_srcdir}/${acjf_var_pkgname_srcdir}"]
        dnl we need abs pathes (${acjf_abs_top_builddir}) here to enable a correct fixup also for relative configure calls.
        [$1_builddir="${acjf_abs_top_builddir}/${acjf_var_pkgname_srcdir}"]
      else
        [$1_invalid="yes"]
      fi
      unset acjf_var_pkgname_srcdir
    fi
  fi
  if test [x"${$1_invalid}" != x"yes"]; then
    if test [x"${$1_type}" = x"bundled";] then
      if test [-d "${$1_srcdir}/pkginclude"]; then
        [$1_incpath="${$1_builddir}/pkginclude ${$1_srcdir}/pkginclude"]
      else
        [$1_incpath="${$1_builddir} ${$1_srcdir}/include ${$1_srcdir}"]
      fi
      dnl we need abs pathes ($acjf_abs_top_builddir) here to enable a correct fixup also for relative configure calls.
      [$1_libpath="${$1_builddir}"]
      [$1_cppflags_other=""]
      [$1_ldflags_other=""]
      [$1_libs=""]
      [$1_invalid="no"]
    elif test [x"${$1_type}" = x"pkg-config" -o \
               x"${$1_type}" = x"pkg-config-bundled" -o \
               x"${$1_type}" = x"configscript";] then
      if test [x"${$1_type}" = x"pkg-config" -o x"${$1_type}" = x"pkg-config-bundled";] then
        eval [$1_modules=\$${$2}_modules]
        if test [x"${$1_modules}" = x"";] then
          [$1_modules]="ACJF_VAR_PKGCONFIGMOD"
        fi
        if test [x"${$1_type}" = x"pkg-config-bundled";] then
          [$1_pkg_config_dir="${$1_builddir}/pkgconfig"]
          [$1_pkg_config_path="${$1_pkg_config_dir}"]
          [$1_desc="source tree directory ]ACJF_VAR_SUBDIR[ to provide the pkg-config module ${$1_modules}"]
          if test -f "${$1_pkg_config_dir}/.pkg_config_path"; then
            while read line; do
              case "$line" in
                "") # ignore
                  ;;
                /*) # abs path
                  [$1_pkg_config_path="${$1_pkg_config_path}:${line}"]
                  ;;
                *) # rel path
                  [$1_pkg_config_path="${$1_pkg_config_path}:${$1_pkg_config_dir}/${line}"]
                  ;;
              esac
            done < "${$1_pkg_config_dir}/.pkg_config_path"
          fi
        else # x"${$1_type}" = x"pkg-config"
          eval [$1_pkg_config_dir=\$${$2}_pkg_config_dir]
          [$1_pkg_config_path="${$1_pkg_config_dir}"]
          if test [x"${$1_pkg_config_dir}" = x""]; then
            [$1_desc="standard search path to provide the pkg-config module ${$1_modules}"]
          else
            [$1_desc="${$1_pkg_config_dir} to provide the pkg-config module ${$1_modules}"]
          fi
        fi
        if test x"$PKG_CONFIG_PATH" = x""; then
          [acjf_var_pkg_config_path="${$1_pkg_config_path}"]
        else
          [acjf_var_pkg_config_path="${$1_pkg_config_path}:${PKG_CONFIG_PATH}"]
        fi
        dnl echo "PKG_CONFIG_PATH: $acjf_var_pkg_config_path"
        if test -n "$PKG_CONFIG" && AC_RUN_LOG([PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG --exists --print-errors "${$1_modules}";]); then
          dnl echo "yep"
          [$1_invalid="no"]
          [acjf_var_includedir=""]
          [acjf_var_include=""]
          [acjf_var_cppflags=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG --cflags "${$1_modules}" 2>/dev/null`]
          [acjf_var_cflags=""]
          [acjf_var_cxxflags=""]
          [acjf_var_libdir=""]
          [acjf_var_ldflags=""]
          [acjf_var_libs=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG --libs "${$1_modules}" 2>/dev/null`]
        else
          dnl echo "nope"
          [$1_invalid="yes"]
          _PKG_SHORT_ERRORS_SUPPORTED
          if test [x"$_pkg_short_errors_supported" = x"yes";] then
            acjf_var_PKG_ERRORS=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG --short-errors --errors-to-stdout --print-errors "$2"`
          else 
            acjf_var_PKG_ERRORS=`PKG_CONFIG_PATH="$acjf_var_pkg_config_path"; export PKG_CONFIG_PATH; $PKG_CONFIG --errors-to-stdout --print-errors "$2"`
          fi
          # Put the nasty error message in config.log where it belongs
          echo "$acjf_var_PKG_ERRORS" >&AS_MESSAGE_LOG_FD
        fi
        unset acjf_var_pkg_config_path
      else
        eval [$1_rel_configscript=\$${$2}_configscript]
        if test [x"${$1_rel_configscript}" = x"";] then
          [$1_rel_configscript]="ACJF_VAR_CONFIGSCRIPT"
        fi
        AC_PATH_PROG([$1_configscript], [${$1_rel_configscript}], [not found])
        if test [x"${$1_configscript}" != x"not found";] then
          [$1_invalid="no"]
          [$1_desc="configuration from ${$1_configscript}"]
          [acjf_var_includedir=`${$1_configscript} --includedir 2>/dev/null` || acjf_var_includedir='']
          [acjf_var_include=`${$1_configscript} --include 2>/dev/null` || acjf_var_include='']
          [acjf_var_cppflags=`${$1_configscript} --cppflags 2>/dev/null` || acjf_var_cppflags='']
          [acjf_var_cflags=`${$1_configscript} --cflags 2>/dev/null` || acjf_var_cflags='']
          [acjf_var_cxxflags=`${$1_configscript} --cxxflags 2>/dev/null` || acjf_var_cxxflags='']
          [acjf_var_libdir=`${$1_configscript} --libdir 2>/dev/null` || acjf_var_libdir='']
          [acjf_var_ldflags=`${$1_configscript} --ldflags 2>/dev/null` || acjf_var_ldflags='']
          [acjf_var_libs=`${$1_configscript} --libs 2>/dev/null` || acjf_var_libs='']
        else
          [$1_invalid="yes"]
        fi
      fi
      if test [x"${$1_invalid}" != x"yes"]; then
        [$1_incpath=""]
        [$1_libpath=""]
        [$1_cppflags_other=""]
        [$1_ldflags_other=""]
        [$1_libs=""]
        set dummy $acjf_var_include $acjf_var_cppflags $acjf_var_cflags $acjf_var_cxxflags
        shift
        while test $[]# != 0
        do
          case $[]1 in
            [-[ID])]
              acjf_var_option=$[]1
              acjf_var_optarg=$[]2
              acjf_var_shift=shift
              ;;
            [-[ID]*)]
              acjf_var_option=`expr "x$[]1" : 'x\(..\)'`
              acjf_var_optarg=`expr "x$[]1" : 'x..\(.*\)'`
              acjf_var_shift=:
              ;;
            [*)]
              # This is not an option, so the user has probably given explicit
              # arguments.
              acjf_var_option=$[]1
              acjf_var_shift=:
          esac
          case $acjf_var_option in
            -I)
              if test [x"${$1_incpath}" != x"";] then
                if ! expr [x" ${$1_incpath} " : x".*[ 	]$acjf_var_optarg[ 	]" > /dev/null;] then
                  [$1_incpath="${$1_incpath} $acjf_var_optarg"]
                fi
              else
                [$1_incpath="$acjf_var_optarg"]
              fi
              $acjf_var_shift
              ;;
            -D)
              [$1_cppflags_other="${$1_cppflags_other} -D$acjf_var_optarg"; $acjf_var_shift]
              ;;
            *)
              [$1_cppflags_other="${$1_cppflags_other} $acjf_var_option"]
              ;;
          esac
          shift
        done
        if test x"$acjf_var_includedir" != x""; then
          if test [x"${$1_incpath}" != x"";] then
            if ! expr [x" ${$1_incpath} " : x".*[ 	]$acjf_var_includedir[ 	]" > /dev/null;] then
              [$1_incpath="${$1_incpath} $acjf_var_includedir"]
            fi
          else
            [$1_incpath="$acjf_var_includedir"]
          fi
        fi
        if test x"$acjf_var_libdir" != x""; then
          if test [x"${$1_libpath}" != x"";] then
            if ! expr [x" ${$1_libpath} " : x".*[ 	]$acjf_var_libdir[ 	]" > /dev/null;] then
              [$1_libpath="${$1_libpath} $acjf_var_libdir"]
            fi
          else
            [$1_libpath="$acjf_var_libdir"]
          fi
        fi
        set dummy $acjf_var_libs $acjf_var_ldflags
        shift
        while test $[]# != 0
        do
          case $[]1 in
            [-L)]
              acjf_var_option=$[]1
              acjf_var_optarg=$[]2
              acjf_var_shift=shift
              ;;
            [-[Ll]*)]
              acjf_var_option=`expr "x$[]1" : 'x\(..\)'`
              acjf_var_optarg=`expr "x$[]1" : 'x..\(.*\)'`
              acjf_var_shift=:
              ;;
            [*)]
              # This is not an option, so the user has probably given explicit
              # arguments.
              acjf_var_option=$[]1
              acjf_var_shift=:
          esac
          case $acjf_var_option in
            -L)
              if test [x"${$1_libpath}" != x"";] then
                if ! expr [x" ${$1_libpath} " : x".*[ 	]$acjf_var_optarg[ 	]" > /dev/null;] then
                  [$1_libpath="${$1_libpath} $acjf_var_optarg"]
                fi
              else
                [$1_libpath="$acjf_var_optarg"]
              fi
              $acjf_var_shift
              ;;
            -l)
              for acjf_var_item in [${$1_libpath}]; do
                if test -f "${acjf_var_item}/lib${acjf_var_optarg}.la"; then
                  [$1_deps="${$1_deps} ${acjf_var_item}/lib${acjf_var_optarg}.la"]
                  break;
                elif test -f "${acjf_var_item}/lib${acjf_var_optarg}.so"; then
                  [$1_deps="${$1_deps} ${acjf_var_item}/lib${acjf_var_optarg}.so"]
                  break;
                elif test -f "${acjf_var_item}/lib${acjf_var_optarg}.a"; then
                  [$1_deps="${$1_deps} ${acjf_var_item}/lib${acjf_var_optarg}.a"]
                  break;
                fi
              done
              unset acjf_var_item
              [$1_libs="${$1_libs} -l$acjf_var_optarg"]
              $acjf_var_shift
              ;;
            lib*.la|lib*.a|lib*.so|*/lib*.la|*/lib*.a|*/lib*.so)
              [$1_deps="${$1_deps} $acjf_var_option"]
              acjf_var_flummy=`dirname "$acjf_var_option"`
              if test [x"${$1_libpath}" != x"";] then
                if ! expr [x" ${$1_libpath} " : x".*[ 	]$acjf_var_flummy[ 	]" > /dev/null;] then
                  [$1_libpath="${$1_libpath} $acjf_var_flummy"]
                fi
              else
                [$1_libpath="$acjf_var_flummy"]
              fi
              [acjf_var_flummy=`basename "$acjf_var_option"`]
              [acjf_var_flummy=`expr "$acjf_var_flummy" : "lib\(.*\)\."`]
              [$1_libs="${$1_libs} -l$acjf_var_flummy"]
              unset acjf_var_flummy
              $acjf_var_shift
              ;;
            *)
              [$1_ldflags_other="${$1_ldflags_other} $acjf_var_option"]
              ;;
          esac
          shift
        done
      fi
      unset acjf_var_option
      unset acjf_var_optarg
      unset acjf_var_shift
      unset acjf_var_includedir
      unset acjf_var_include
      unset acjf_var_cppflags
      unset acjf_var_cflags
      unset acjf_var_cxxflags
      unset acjf_var_libdir
      unset acjf_var_ldflags
      unset acjf_var_libs
    fi
  fi
dnl  echo "FINAL:"
dnl  echo ["  $1_desc=${$1_desc}"]
dnl  echo ["  $1_type=${$1_type}"]
dnl  echo ["  $1_invalid=${$1_invalid}"]
dnl  echo ["  $1_incpath=${$1_incpath}"]
dnl  echo ["  $1_libpath=${$1_libpath}"]
dnl  echo ["  $1_cppflags_other=${$1_cppflags_other}"]
dnl  echo ["  $1_ldflags_other=${$1_ldflags_other}"]
dnl  echo ["  $1_libs=${$1_libs}"]
dnl  echo ["  $1_deps=${$1_deps}"]
])

dnl ACJF_TAGS_OVERRIDE(
dnl   <tags used for update>,
dnl   <tags to override by update>)
dnl RETUNRS
dnl   <updated tags>
AC_DEFUN([ACJF_TAGS_OVERRIDE],
 [m4_if([$1], [], [[$2]], [[$1,$2]])])dnl
dnl [m4_if([$1], [], [[[$2]]], [[[$1,$2]]])])dnl

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
dnl   intern:xxx       provide intern tag to --with-<pkgname> option to use compiled <pkgname> in srcdir subdirectory xxx
dnl                    the srcdir subdirectory defaults to <pkgname> if only "intern" is given as a tag
dnl   compile:xxx      provide intern tag to --with-<pkgname> option to compile <pkgname> in srcdir subdirectory xxx
dnl   extern           provide extern tag to --with-<pkgname> option to use an externally installed version of <pkgname>
dnl   pkgconfig:xxx    use pkgconfig module xxx to find the package
dnl   configscript:xxx use config script xxx to find the package
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
  m4_pushdef([ACJF_VAR_SUBDIR], [])dnl
  dnl if no tags are specified add extern tag
  m4_if([$2], [],
   [m4_pushdef([ACJF_VAR_TAGS], [[[extern]]])],
   [m4_pushdef([ACJF_VAR_TAGS], [[$2]])])dnl
  dnl append disabled tag to tags if not found
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<disabled\>]), [-1],
   [ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_TAGS], [[disabled]])])dnl
  dnl Iterate over tags to set ACJF_VAR_SUBDIR from intern:xxx or compile:xxx tag
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
   [dnl set ACJF_VAR_SUBDIR from intern:xxx or compile:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern:\|^compile:]), [0],
     [m4_define([ACJF_VAR_SUBDIR], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^[^:]*:\(.*\)], [[\1]]))])dnl
    dnl set ACJF_VAR_SUBDIR to default ACJF_VAR_PKGNAME if intern or compile tag given
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern$\|^compile$]), [0],
     [m4_define([ACJF_VAR_SUBDIR], ACJF_M4_QUOTE(ACJF_VAR_PKGNAME))])dnl
   ])dnl
  m4_pushdef([ACJF_VAR_CONFIGSCRIPT], [])dnl
  m4_pushdef([ACJF_VAR_PKGCONFIGMOD], [])dnl
  m4_pushdef([ACJF_VAR_INTERNMSG], [[intern to use the source tree version from the ]ACJF_VAR_SUBDIR[ directory]])dnl
  m4_pushdef([ACJF_VAR_COMPILEMSG], [[intern to compile the source tree version located in the ]ACJF_VAR_SUBDIR[ directory]])dnl
  m4_pushdef([ACJF_VAR_EXTERNMSG], [[prefix or extern to use an installed library]])dnl
  dnl Iterate over tags to set ACJF_VAR_CONFIGSCRIPT or ACJF_VAR_PKGCONFIGMOD as well as update the messages for
  dnl intern, compile, extern according to the modus used to locate the package.
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
   [dnl set ACJF_VAR_CONFIGSCRIPT from configscript:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [configscript:]), [0],
     [m4_define([ACJF_VAR_CONFIGSCRIPT], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^configscript:\(.*\)], [[\1]]))dnl
      m4_define([ACJF_VAR_INTERNMSG],  [m4_fatal([Internal error: source tree location possible for ]ACJF_VAR_PKGNAME[ but configscript: modus used to locate the package not supported for source tree location!])])dnl
      m4_define([ACJF_VAR_COMPILEMSG], [m4_fatal([Internal error: compiling package possible for ]ACJF_VAR_PKGNAME[ but configscript: modus used to locate the package not supported for source tree location!])])dnl
      m4_define([ACJF_VAR_EXTERNMSG], [[extern or location of configscript ]ACJF_VAR_CONFIGSCRIPT[ to use an installed library]])])dnl
    dnl set ACJF_VAR_PKGCONFIGMOD from pkgconfig:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [pkgconfig:]), [0],
     [m4_define([ACJF_VAR_PKGCONFIGMOD], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^pkgconfig:\(.*\)], [[\1]]))dnl
      m4_define([ACJF_VAR_INTERNMSG],  [[intern to use the source tree version from the ]ACJF_VAR_SUBDIR[ directory to provide the pkg-config module ]ACJF_VAR_PKGCONFIGMOD])dnl
      m4_define([ACJF_VAR_COMPILEMSG], [[intern to compile the source tree version located in the ]ACJF_VAR_SUBDIR[ directory to provide the pkg-config module ]ACJF_VAR_PKGCONFIGMOD])dnl
      m4_define([ACJF_VAR_EXTERNMSG], [[extern or location of pkg-config module ]ACJF_VAR_PKGCONFIGMOD[ to use an installed library]])])dnl
   ])dnl
  dnl m4_pattern_allow([ACJF_VAR_PKGNAME])dnl
  dnl echo "[ACJF_VAR_PKGNAME]: ACJF_M4_QUOTE(ACJF_VAR_PKGNAME)"
  dnl m4_pattern_allow([ACJF_VAR_SUBDIR])dnl
  dnl echo "[ACJF_VAR_SUBDIR]: ACJF_M4_QUOTE(ACJF_VAR_SUBDIR)"
  dnl m4_pattern_allow([ACJF_VAR_TAGS])dnl
  dnl echo "[ACJF_VAR_TAGS]: ACJF_M4_QUOTE(ACJF_VAR_TAGS)"
  dnl m4_pattern_allow([ACJF_VAR_CONFIGSCRIPT])dnl
  dnl echo "[ACJF_VAR_CONFIGSCRIPT]: ACJF_M4_QUOTE(ACJF_VAR_CONFIGSCRIPT)"
  dnl m4_pattern_allow([ACJF_VAR_PKGCONFIGMOD])dnl
  dnl echo "[ACJF_VAR_PKGCONFIGMOD]: ACJF_M4_QUOTE(ACJF_VAR_PKGCONFIGMOD)"
  dnl m4_pattern_allow([ACJF_VAR_INTERNMSG])dnl
  dnl echo "[ACJF_VAR_INTERNMSG]: ACJF_M4_QUOTE(ACJF_VAR_INTERNMSG)"
  dnl m4_pattern_allow([ACJF_VAR_COMPILEMSG])dnl
  dnl echo "[ACJF_VAR_COMPILEMSG]: ACJF_M4_QUOTE(ACJF_VAR_COMPILEMSG)"
  dnl m4_pattern_allow([ACJF_VAR_EXTERNMSG])dnl
  dnl echo "[ACJF_VAR_EXTERNMSG]: ACJF_M4_QUOTE(ACJF_VAR_EXTERNMSG)"
  dnl Iterate over tags to assemble the help message for the --with-<pkgname> option.
  m4_pushdef([ACJF_VAR_WITHOPT], ACJF_M4_DOWNCASE(m4_bpatsubst(ACJF_M4_QUOTE(ACJF_VAR_PKGNAME), [\([^][a-zA-Z0-9]\|[ 	]+\)],[-])))dnl
  m4_pushdef([ACJF_VAR_WITHLIST], [])dnl
  m4_pushdef([ACJF_VAR_DEFAULTMSG], [[ (default)]])dnl
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
   [dnl m4_pattern_allow([ACJF_VAR_TAG])dnl
    dnl echo "[ACJF_VAR_TAG]: ACJF_M4_QUOTE(ACJF_VAR_TAG)"
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern$\|^intern:]), [0], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], ACJF_VAR_INTERNMSG[]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^compile$\|^compile:]), [0], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], ACJF_VAR_COMPILEMSG[]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [extern], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], ACJF_VAR_EXTERNMSG[]ACJF_VAR_DEFAULTMSG)dnl
    ], [m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [disabled], [
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_WITHLIST], [no to disable]ACJF_VAR_DEFAULTMSG)dnl
    ])])])])dnl
    dnl only first is marked as default
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern$\|^intern:\|^compile$\|^compile:\|^extern$\|^disabled$]), [0],
     [m4_define([ACJF_VAR_DEFAULTMSG], [[]])])dnl
   ])dnl
  m4_popdef([ACJF_VAR_DEFAULTMSG])dnl
  m4_popdef([ACJF_VAR_EXTERNMSG])dnl
  m4_popdef([ACJF_VAR_COMPILEMSG])dnl
  m4_popdef([ACJF_VAR_INTERNMSG])dnl
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
  dnl via ACJF_SEARCHLOC_ADD_XXX macros.
  ACJF_SEARCHLOC_CLEAR(ACJF_VAR_PKGNAME)dnl
  acjf_var_matchtag=no
  acjf_var_disabled=no
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS, [
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern$\|^intern:\|^compile$\|^compile:]), [0],
     [if test x"$acjf_var_disabled" != x"yes"; then
       case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
          ""|yes|intern)
            m4_if(ACJF_VAR_PKGCONFIGMOD, [],
             [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
               [dnl neither configscript nor pkgconfig mode
                ACJF_SEARCHLOC_ADD_INTERN(ACJF_VAR_PKGNAME)
               ],
               [dnl configscript mode


               ])
             ],
             [dnl pkgconfig mode
              ACJF_SEARCHLOC_ADD_PKGCONFIG_INTERN(ACJF_VAR_PKGNAME, ACJF_VAR_PKGCONFIGMOD)dnl
             ])dnl
            acjf_var_matchtag=yes
            ;;
        esac
      fi
     ])dnl
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^extern$\|^compile$\|^compile:]), [0],
     [if test x"$acjf_var_disabled" != x"yes"; then
        case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
          ""|yes|extern)
            m4_if(ACJF_VAR_PKGCONFIGMOD, [],
             [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
               [dnl neither configscript nor pkgconfig mode
                if test x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]" != x"" -o \
                        x"$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]" != x""; then
                  ACJF_SEARCHLOC_ADD_INCLIB(ACJF_VAR_PKGNAME,
                    [$acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath],
                    [$acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath])
                else
                  ACJF_SEARCHLOC_ADD_STD(ACJF_VAR_PKGNAME)
                fi
               ],
               [dnl configscript mode
                ACJF_SEARCHLOC_ADD_CONFIGSCRIPT(ACJF_VAR_PKGNAME)
               ])
             ],
             [dnl pkgconfig mode
              ACJF_SEARCHLOC_ADD_PKGCONFIG_STD(ACJF_VAR_PKGNAME, ACJF_VAR_PKGCONFIGMOD)dnl
             ])dnl
            acjf_var_matchtag=yes
            ;;
          "/"*)
            m4_if(ACJF_VAR_PKGCONFIGMOD, [],
             [m4_if(ACJF_VAR_CONFIGSCRIPT, [],
               [dnl neither configscript nor pkgconfig mode
                ACJF_SEARCHLOC_ADD_PREFIX(ACJF_VAR_PKGNAME, $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME))
               ],
               [dnl configscript mode
                ACJF_SEARCHLOC_ADD_CONFIGSCRIPT(ACJF_VAR_PKGNAME,$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME))
               ])
             ],
             [dnl pkgconfig mode
              ACJF_SEARCHLOC_ADD_PKGCONFIG_PREFIX(ACJF_VAR_PKGNAME, $[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME), ACJF_VAR_PKGCONFIGMOD)dnl
             ])dnl
            acjf_var_matchtag=yes
            ;;
        esac
      fi
     ])dnl
    m4_if(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [disabled],
     [if test x"$acjf_var_disabled" != x"yes"; then
        case "$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)" in
          ""|no)
            ACJF_SEARCHLOC_ADD_DISABLED(ACJF_VAR_PKGNAME)
            acjf_var_matchtag=yes
            acjf_var_disabled=yes
            ;;
        esac
      fi
     ])dnl
  ])dnl
  if test x"$acjf_var_matchtag" = x"no"; then
    AC_MSG_ERROR([Option --with-]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)=$[acjf_with_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[ is not supported!])
  fi
  unset acjf_var_matchtag
  unset acjf_var_disabled
  m4_popdef([ACJF_VAR_PKGCONFIGMOD])dnl
  m4_popdef([ACJF_VAR_CONFIGSCRIPT])dnl
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_SUBDIR])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
])dnl ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_ARG_WITHPKG::$1]), ...)
m4_divert_pop([INIT_PREPARE])
])

dnl ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib list,.e.g., xerces-c systemc>)
dnl
dnl This macro generates a macro ACJF_M4_ANONYMOUS_XXX testing for presence
dnl of the given library. The generated macro takes two arguments, i.e.,
dnl
dnl   ACJF_M4_ANONYMOUS_XXX(
dnl     <name of lib check (pkgname)>,
dnl     <shell variable prefix set by ACJF_SEARCHLOC_EVALUATE>,
dnl    [<code if found, default does nothing>,
dnl    [<code if not found, default does nothing>]])
AC_DEFUN([ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK], [AC_REQUIRE([ACJF_INIT])dnl
m4_pushdef([ACJF_VAR_ANONYMOUS_M4_MACRO], ACJF_GEN_ANONYMOUS_M4_MACRO)dnl
ACJF_VAR_ANONYMOUS_M4_MACRO[]dnl
dnl ACJF_M4_ANONYMOUS_XXX(
dnl   <name of lib check (pkgname)>,
dnl   <shell variable prefix set by ACJF_SEARCHLOC_EVALUATE>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
m4_define(ACJF_VAR_ANONYMOUS_M4_MACRO, ACJF_M4_QUOTEDARGS([
  AC_MSG_CHECKING([for §1 package in ${§2_desc}])
  m4_if([$3], [], [
    AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[$1]], [[$2]])],
      [AC_MSG_RESULT([yes]); §3],
      [AC_MSG_RESULT([no]); §4])
  ], [
    if test [x"${§2_type}" = x"bundled" -o \
             x"${§2_type}" = x"pkg-config-bundled"]; then
      AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([[$1]], [[$2]])],
        [AC_MSG_RESULT([yes]); §3],
        [AC_MSG_RESULT([no]); §4])
    else
      acjf_var_LIBS=""
      for acjf_var_item2 in $3; do
        if echo "$acjf_var_item2" | grep "^-l" 1>/dev/null; then
          acjf_var_LIBS="$acjf_var_LIBS $acjf_var_item2";
        else
          acjf_var_LIBS="$acjf_var_LIBS -l$acjf_var_item2";
        fi
      done
      LIBS="$LIBS $acjf_var_LIBS";
      AC_LINK_IFELSE(
        [AC_LANG_PROGRAM([[$1]], [[$2]])],
        [AC_MSG_RESULT([yes]); [acjf_cv_]ACJF_M4_CANON_DC(§1)[_libs]="${[acjf_var_LIBS]}"; §3],
        [AC_MSG_RESULT([no]); §4])
    fi
  ])
]))dnl
m4_popdef([ACJF_VAR_ANONYMOUS_M4_MACRO])dnl
])

dnl ACJF_PKG_TESTMACROGEN_DUMMY()
dnl
dnl This macro uses the macro _ACJF_PKG_TESTMACRO_DUMMY defined below
dnl
dnl   _ACJF_PKG_TESTMACRO_DUMMY(
dnl     <name of lib check (pkgname)>,
dnl     <description shell variable>,
dnl    [<code if found, default does nothing>,
dnl    [<code if not found, default does nothing>]])
AC_DEFUN([ACJF_PKG_TESTMACROGEN_DUMMY], [[_ACJF_PKG_TESTMACRO_DUMMY]])

dnl _ACJF_PKG_TESTMACRO_DUMMY(
dnl   <name of lib check (pkgname)>,
dnl   <description shell variable>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl If not source tree location => execute code if not found
dnl If source tree location => execute code if found
m4_define([_ACJF_PKG_TESTMACRO_DUMMY], [
  AC_MSG_CHECKING([for $1 package in ${$2_desc}])
  if test [x"${$2_type}" = x"bundled" -o \
           x"${$2_type}" = x"pkg-config-bundled" -o \
           x"${$2_type}" = x"pkg-config"]; then
    AC_MSG_RESULT([yes]);
    m4_if([$3], [], [true], [$3])
  else
    AC_MSG_RESULT([no]);
    m4_if([$4], [], [false], [$4])
  fi
])

dnl _ACJF_PKG_SRCTREE_SEARCHER helper macro
m4_define([_ACJF_PKG_SRCTREE_SEARCHER], [
  $1="/invalid";
  m4_pushdef([_ACJF_VAR_DIR],ACJF_VAR_SUBPROJECT_DIR[dummy])dnl
  ACJF_M4_WHILE([m4_if(_ACJF_VAR_DIR, [.], [0], [1])],
   [m4_define([_ACJF_VAR_DIR], ACJF_M4_PATH_DIRNAME(_ACJF_VAR_DIR))dnl
    for acjf_var_subdir in ACJF_VAR_SUBDIR; do
      if test x"$$1" = x"/invalid" -a \
              -d "$srcdir/_ACJF_VAR_DIR/$acjf_var_subdir"; then
        $1="_ACJF_VAR_DIR/$acjf_var_subdir";
      fi
    done
  ])dnl
  m4_popdef([_ACJF_VAR_DIR])dnl
  # Last ditch effort try one uplevel directory
  for acjf_var_subdir in ACJF_VAR_SUBDIR; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../$acjf_var_subdir"; then
      $1="../$acjf_var_subdir";
    fi
  done
  # Last ditch effort try two uplevel directories
  for acjf_var_subdir in ACJF_VAR_SUBDIR; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../../$acjf_var_subdir"; then
      $1="../../$acjf_var_subdir";
    fi
  done
  # Last ditch effort try three uplevel directories
  for acjf_var_subdir in ACJF_VAR_SUBDIR; do
    if test x"$$1" = x"/invalid" -a \
            -d "$srcdir/../../../$acjf_var_subdir"; then
      $1="../../../$acjf_var_subdir";
    fi
  done
  # cleanup
  unset acjf_var_subdir
])

dnl ACJF_CHECK_HELPER_SET_VARS(
dnl  <arglist>,
dnl  <m4 code to evalute with var environment>)
dnl 
dnl The argument list <arglist> should conform to
dnl ([<tags>],
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl This sets the folowing m4 defined for the <m4 code to evalute with var environment>
dnl
dnl ACJF_VAR_TAGS
dnl ACJF_VAR_CODE_IF_TRUE
dnl ACJF_VAR_CODE_IF_FALSE
AC_DEFUN([ACJF_CHECK_HELPER_SET_VARS], [
  m4_pushdef([ACJF_VAR_ARGSLIST], [[$1]])dnl
  dnl m4_pattern_allow([ACJF_VAR_ARGSLIST])dnl
  dnl echo "[ACJF_VAR_ARGSLIST]: ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_if(m4_eval(ACJF_M4_ARG_SIZE(ACJF_VAR_ARGSLIST)>3), [1],
   [m4_fatal([At most three arguments required, but given "$1"!])])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [\<disabled\>\|\<intern:\|\<intern\>\|\<extern\>\|\<pkgconfig:\|\<configscript:\|\<version:]), [-1], 
   [m4_pushdef([ACJF_VAR_TAGS], [[]])],
   [m4_pushdef([ACJF_VAR_TAGS], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])])dnl
  dnl m4_pattern_allow([ACJF_VAR_TAGS])dnl
  dnl echo "[ACJF_VAR_TAGS]: ACJF_M4_QUOTE(ACJF_VAR_TAGS)"
  dnl echo "[ACJF_VAR_ARGSLIST]: ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_TRUE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_TRUE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_TRUE)"
  dnl echo "[ACJF_VAR_ARGSLIST]: ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_FALSE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_FALSE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_FALSE)"
  dnl echo "[ACJF_VAR_ARGSLIST]: ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_popdef([ACJF_VAR_ARGSLIST])dnl
  $2 dnl this is <m4 code to evalute with var environment>
  dnl cleanup var environment
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
])dnl

dnl NEW ACJF_CHECK_LIB_TESTER USAGE:
dnl
dnl ACJF_CHECK_LIB_TESTER(
dnl   <name of lib check (pkgname)>,
dnl   <tags>,
dnl   <test macro>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl tags
dnl   intern:xxx       if enabled via --with-<pkgname> option, then search for <pkgname> in srcdir subdirectory xxx 
dnl                    the srcdir subdirectory defaults to <pkgname> if only "intern" is given as a tag
dnl
dnl OBSOLETE ACJF_CHECK_LIB_TESTER USAGE:
dnl
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
dnl If pkg found define:
dnl   PKGNAME_FOUND           yes
dnl   PKGNAME_INCPATH         whitespace seperated list of include directories
dnl                           excluding standard compiler search directories
dnl   PKGNAME_INCLUDE         only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER  odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS        PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LIBPATH         library directory if pkg is compiled from source tree
dnl   PKGNAME_LIBPATH         whitespace seperated list of library directories
dnl                           excluding standard compiler/linker search directories
dnl                           if pkg is from extern
dnl   PKGNAME_LFLAGS          only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER   odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS         PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS            -l options (whitespace seperated)
dnl   PKGNAME_DEPENDENCIES    fully qualified path to the libs if possible
dnl   PKGNAME_PKG_CONFIG_PATH if pkg-config or pkg-config-bundled mode
dnl   pkg_pkgname_srcdir      source tree directory if the pkg is compiled from source tree
dnl   pkg_pkgname_builddir    build directory if the pkg is compiled from source tree
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := true
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true  if pkg is compiled from source tree
dnl                                                    false otherwise
dnl If pkg not found define:
dnl   PKGNAME_FOUND          no
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := false
AC_DEFUN([ACJF_CHECK_LIB_TESTER], [AC_REQUIRE([ACJF_INIT])dnl
  m4_if(m4_eval([$#<3]), [1], [m4_fatal([At least three arguments required for ACJF_CHECK_LIB_TESTER])])dnl
  m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])dnl
  m4_pushdef([ACJF_VAR_SUBDIR], [])dnl
  m4_if(m4_bregexp([$2], [\<disabled\>\|\<intern\>\|\<intern:\|\<extern\>\|\<configscript:\|\<pkgconfig:]), [-1],
   [m4_pushdef([ACJF_VAR_TAGS], [[intern:$2]])],
   [m4_pushdef([ACJF_VAR_TAGS], [[$2]])])dnl
  m4_pushdef([ACJF_VAR_TEST_MACRO], [[$3]])dnl
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], [[$4]])dnl
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], [[$5]])dnl
  dnl Iterate over tags to set
  dnl ACJF_VAR_SUBDIR       from intern:xxx tag
  dnl ACJF_VAR_CONFIGSCRIPT from configscript:xxx tag
  dnl ACJF_VAR_PKGCONFIGMOD from pkgconfig:xxx tag
  m4_pushdef([ACJF_VAR_CONFIGSCRIPT], [])dnl
  m4_pushdef([ACJF_VAR_PKGCONFIGMOD], [])dnl
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
   [dnl set ACJF_VAR_SUBDIR from intern:xxx or compile:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern:\|^compile:]), [0],
     [m4_define([ACJF_VAR_SUBDIR], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^[^:]*:\(.*\)], [[\1]]))])dnl
    dnl set ACJF_VAR_SUBDIR to default ACJF_VAR_PKGNAME if intern or compile tag given
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^intern$\|^compile$]), [0],
     [m4_define([ACJF_VAR_SUBDIR], ACJF_M4_QUOTE(ACJF_VAR_PKGNAME))])dnl
    dnl set ACJF_VAR_CONFIGSCRIPT from configscript:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^configscript:]), [0],
     [m4_define([ACJF_VAR_CONFIGSCRIPT], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^configscript:\(.*\)], [[\1]]))])dnl
    dnl set ACJF_VAR_PKGCONFIGMOD from pkgconfig:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^pkgconfig:]), [0],
     [m4_define([ACJF_VAR_PKGCONFIGMOD], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [^pkgconfig:\(.*\)], [[\1]]))])dnl
   ])dnl
  dnl m4_pattern_allow([ACJF_VAR_PKGNAME])
  dnl echo "[ACJF_VAR_PKGNAME]: ACJF_VAR_PKGNAME"
  dnl m4_pattern_allow([ACJF_VAR_SUBDIR])
  dnl echo "[ACJF_VAR_SUBDIR]: ACJF_VAR_SUBDIR"
  dnl m4_pattern_allow([ACJF_VAR_TAGS])
  dnl echo "[ACJF_VAR_TAGS]: ACJF_VAR_TAGS"
  dnl m4_pattern_allow([ACJF_VAR_CONFIGSCRIPT])
  dnl echo "[ACJF_VAR_CONFIGSCRIPT]: ACJF_VAR_CONFIGSCRIPT"
  dnl m4_pattern_allow([ACJF_VAR_PKGCONFIGMOD])
  dnl echo "[ACJF_VAR_PKGCONFIGMOD]: ACJF_VAR_PKGCONFIGMOD"
  
  ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::$1::subdir::$2]),
   [dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::$1::subdir::$2]) [[BEGIN]]"
    m4_pushdef([ACJF_VAR_ANON_SHELLVARPREFIX], ACJF_GEN_ANONYMOUS_SHELL_VAR)

    dnl dnl For debug
    dnl echo "CODE IF TRUE: _[]ACJF_M4_CANON_DC(ACJF_VAR_CODE_IF_TRUE)[]_"
    dnl echo "CODE IF FALSE: _[]ACJF_M4_CANON_DC(ACJF_VAR_CODE_IF_FALSE)[]_"

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
        ACJF_SEARCHLOC_EVALUATE([acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME), ACJF_VAR_ANON_SHELLVARPREFIX[item])
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
           [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME),
           [break],
           [false])])
        fi
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]
      done
    elif test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"bundled" -o \
            x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"pkg-config-bundled"; then
      # Reevaluate as we do not cache all stuff for bundled software
      ACJF_VAR_ANON_SHELLVARPREFIX[item]="[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)"
      ACJF_SEARCHLOC_EVALUATE([acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME), ACJF_VAR_ANON_SHELLVARPREFIX[item])
    fi

    CPPFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS]";
    LDFLAGS="$ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS]";
    LIBS="$ACJF_VAR_ANON_SHELLVARPREFIX[LIBS]";
    unset ACJF_VAR_ANON_SHELLVARPREFIX[CPPFLAGS];
    unset ACJF_VAR_ANON_SHELLVARPREFIX[LDFLAGS];
    unset ACJF_VAR_ANON_SHELLVARPREFIX[LIBS];

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

dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_desc]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_cppflags_other]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]"
dnl echo "[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_deps]: $[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_deps]"

    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_DEPENDENCIES])dnl
    m4_pattern_allow(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PKG_CONFIG_PATH])dnl
    m4_pattern_allow([pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir])dnl
    m4_pattern_allow([pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir])dnl
    m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND])dnl
    m4_pattern_allow([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION])dnl

    dnl Cleanup stuff first
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_DEPENDENCIES]
    unset ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PKG_CONFIG_PATH]
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]
    unset [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]

    m4_divert_push([INIT_PREPARE])
    ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]),
      [AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND], [false])])
    m4_divert_pop([INIT_PREPARE])
    AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND],
      test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" != x"$acjf_disabled_type")
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
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_ldflags_other]"
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS]="$ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS] $ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER]"
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]"
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_DEPENDENCIES]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_deps]"
    else
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND]="no"
    fi
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_FOUND])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS_OTHER])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS_OTHER])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS])dnl
    AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_DEPENDENCIES])dnl
    ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_ARGSTOLIST(
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCPATH],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_INCLUDE],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_CPPFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBPATH],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LDFLAGS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_LIBS],
      ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_DEPENDENCIES]))dnl

    m4_if(ACJF_VAR_SUBDIR, [], [],
     [m4_divert_push([INIT_PREPARE])
      ACJF_M4_ONCECODE(ACJF_M4_CANON_DC([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION]),
        [AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION], [false])])
      m4_divert_pop([INIT_PREPARE])
      AM_CONDITIONAL([PKG_]ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_USE_SRCDIR_VERSION],
        test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"bundled" -o \
             x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"pkg-config-bundled")
      if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"bundled" -o \
              x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"pkg-config-bundled"; then
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]"
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]"
        dnl no caching of incpath, libpath, srcdir, builddir for bundled stuff
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_incpath]
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libpath]
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir]
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_libs]
        unset [acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_deps]
      fi
      AC_SUBST([pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir])dnl
      AC_SUBST([pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir])dnl
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_ARGSTOLIST(
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_srcdir],
        [pkg_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_builddir]))dnl
     ])dnl

    m4_if(ACJF_VAR_PKGCONFIGMOD, [], [],
     [if test x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"pkg-config" -o \
              x"$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_type]" = x"pkg-config-bundled"; then
        test -d pkgconfig || mkdir pkgconfig
        touch pkgconfig/.pkg_config_path
        echo "$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_pkg_config_path]" | tr ':' '\n' | while read line; do
          echo "$line"
        done >> pkgconfig/.pkg_config_path
        ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PKG_CONFIG_PATH]="$[acjf_cv_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_pkg_config_path]"
      fi
      AC_SUBST(ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PKG_CONFIG_PATH])
      ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_SUBSTVARFIXUP], ACJF_M4_ARGSTOLIST(
        ACJF_M4_CANON_DN(ACJF_VAR_PKGNAME)[_PKG_CONFIG_PATH]))dnl
     ])dnl

    m4_popdef([ACJF_VAR_ANON_SHELLVARPREFIX])dnl
    dnl echo "Are here: ACJF_M4_CANON_DC([ACJF_CHECK_LIB_TESTER::$1::subdir::$2]) [[END]]"
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

  m4_popdef([ACJF_VAR_PKGCONFIGMOD])dnl
  m4_popdef([ACJF_VAR_CONFIGSCRIPT])dnl
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_TEST_MACRO])dnl
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_SUBDIR])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
])dnl

dnl NEW ACJF_CHECK_PKG USAGE:
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl tags (empty defaults to intern, precedence is in order of sequence):
dnl   disabled         if no --with-<pkgname> option is specified disable the package
dnl   intern:xxx       provide intern tag to --with-<pkgname> option to use compiled <pkgname> in srcdir subdirectory xxx
dnl                    the srcdir subdirectory defaults to <pkgname> if only "intern" is given as a tag
dnl   extern           provide extern tag to --with-<pkgname> option to use an externally installed version of <pkgname>
dnl   pkgconfig:xxx    use pkgconfig module xxx to find the package
dnl   configscript:xxx use config script xxx to find the package
dnl
dnl Examples:
dnl   [[intern]]             => Use internal version if not disabled
dnl   [[disabled],[intern]]  => If no --with-<pkgname> option is given the package is disabled
dnl
dnl OBSOLETE ACJF_CHECK_PKG USAGE:
dnl
dnl ACJF_CHECK_PKG(
dnl   <pkgname>,
dnl  [<possible location in source tree>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl After execution of the macro
dnl
dnl If pkg found define:
dnl   PKGNAME_FOUND           yes
dnl   PKGNAME_INCPATH         whitespace seperated list of include directories
dnl                           excluding standard compiler search directories
dnl   PKGNAME_INCLUDE         only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER  odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS        PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LIBPATH         library directory if pkg is compiled from source tree
dnl   PKGNAME_LIBPATH         whitespace seperated list of library directories
dnl                           excluding standard compiler/linker search directories
dnl                           if pkg is from extern
dnl   PKGNAME_LFLAGS          only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER   odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS         PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS            -l options (whitespace seperated)
dnl   PKGNAME_DEPENDENCIES    fully qualified path to the libs if possible
dnl   PKGNAME_PKG_CONFIG_PATH if pkg-config or pkg-config-bundled mode
dnl   pkg_pkgname_srcdir      source tree directory if the pkg is compiled from source tree
dnl   pkg_pkgname_builddir    build directory if the pkg is compiled from source tree
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := true
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true  if pkg is compiled from source tree
dnl                                                    false otherwise
dnl If pkg not found define:
dnl   PKGNAME_FOUND          no
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := false
AC_DEFUN([ACJF_CHECK_PKG], [AC_REQUIRE([ACJF_INIT])dnl
  m4_pushdef([ACJF_VAR_ARGSLIST], [[$@]])dnl
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_PKGNAME], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))dnl
  dnl m4_pattern_allow([ACJF_VAR_PKGNAME])dnl
  dnl echo "[ACJF_VAR_PKGNAME]: ACJF_M4_QUOTE(ACJF_VAR_PKGNAME)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_TAGS], [[]])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [\<disabled\>\|\<intern:\|\<intern\>\|\<extern\>\|\<pkgconfig:\|\<configscript:]), [-1],
   [m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [[=;]\|^$]), [-1],
     [m4_define([ACJF_VAR_TAGS], ACJF_M4_QUOTE([intern:]ACJF_M4_UNQUOTE(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
   ])],
   [m4_define([ACJF_VAR_TAGS], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])])dnl
  dnl m4_pattern_allow([ACJF_VAR_TAGS])dnl
  dnl echo "[ACJF_VAR_TAGS]: ACJF_M4_QUOTE(ACJF_VAR_TAGS)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  dnl check that no extern tag is given
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<extern\>]), [-1], [],
   [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<pkgconfig:]), [-1],
     [m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<configscript:]), [-1],
       [m4_fatal([No extern tag supported in ACJF_CHECK_PKG(]ACJF_M4_QUOTE(ACJF_VAR_PKGNAME)[,]ACJF_M4_QUOTE(ACJF_VAR_TAGS)[,...) without pkgconfig:xxx or configscript:xxx tags!])])])])dnl
  dnl append intern tag to tags if not found
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<intern:\|\<intern\>]), [-1],
   [ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_TAGS], [[intern]])])
  dnl echo "[ACJF_VAR_TAGS]: ACJF_M4_QUOTE(ACJF_VAR_TAGS)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_TRUE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_TRUE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_TRUE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_FALSE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_FALSE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_FALSE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS)dnl
  ACJF_CHECK_LIB_TESTER(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS,
    ACJF_PKG_TESTMACROGEN_DUMMY,
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
  m4_popdef([ACJF_VAR_ARGSLIST])dnl
])

dnl NEW ACJF_CHECK_LIB USAGE:
dnl
dnl ACJF_CHECK_LIB(
dnl   <name of lib check (pkgname)>,
dnl   <tags>,
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl  [<lib name>,] only needed if neither pkgconfig:xxx nor configscript:xxx tags are given
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl tags (empty defaults to extern, precedence is in order of sequence):
dnl   disabled         if no --with-<pkgname> option is specified disable the package
dnl   intern:xxx       provide intern tag to --with-<pkgname> option to use compiled <pkgname> in srcdir subdirectory xxx
dnl                    the srcdir subdirectory defaults to <pkgname> if only "intern" is given as a tag
dnl   extern           provide extern tag to --with-<pkgname> option to use an externally installed version of <pkgname>
dnl   pkgconfig:xxx    use pkgconfig module xxx to find the package
dnl   configscript:xxx use config script xxx to find the package
dnl
dnl Examples:
dnl   [[intern]]             => Use internal version if not disabled
dnl   [[disabled],[intern]]  => If no --with-<pkgname> option is given the package is disabled
dnl
dnl OBSOLETE ACJF_CHECK_LIB USAGE:
dnl
dnl ACJF_CHECK_LIB(
dnl   <name of lib check (pkgname)>,
dnl   <possible location in source tree>,
dnl   <actual include directives>,
dnl   <code in main routine for link check>,
dnl   <lib name>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl If pkg found define:
dnl   PKGNAME_FOUND           yes
dnl   PKGNAME_INCPATH         whitespace seperated list of include directories
dnl                           excluding standard compiler search directories
dnl   PKGNAME_INCLUDE         only -I flags (whitespace seperated)
dnl   PKGNAME_CPPFLAGS_OTHER  odd compile flags like defines or -pthread (whitespace seperated)
dnl   PKGNAME_CPPFLAGS        PKGNAME_INCLUDE and PKGNAME_CPPFLAGS_OTHER all in one
dnl   PKGNAME_LIBPATH         library directory if pkg is compiled from source tree
dnl   PKGNAME_LIBPATH         whitespace seperated list of library directories
dnl                           excluding standard compiler/linker search directories
dnl                           if pkg is from extern
dnl   PKGNAME_LFLAGS          only -L flags (whitespace seperated)
dnl   PKGNAME_LDFLAGS_OTHER   odd link flags like -rpath, -pthread, etc.
dnl   PKGNAME_LDFLAGS         PKGNAME_LFLAGS and PKGNAME_LDFLAGS_OTHER all in one
dnl   PKGNAME_LIBS            -l options (whitespace seperated)
dnl   PKGNAME_DEPENDENCIES    fully qualified path to the libs if possible
dnl   PKGNAME_PKG_CONFIG_PATH if pkg-config or pkg-config-bundled mode
dnl   pkg_pkgname_srcdir      source tree directory if the pkg is compiled from source tree
dnl   pkg_pkgname_builddir    build directory if the pkg is compiled from source tree
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := true
dnl   AM_CONDITIONAL PKG_PKGNAME_USE_SRCDIR_VERSION := true  if pkg is compiled from source tree
dnl                                                    false otherwise
dnl If pkg not found define:
dnl   PKGNAME_FOUND          no
dnl   AM_CONDITIONAL PKG_PKGNAME_FOUND              := false
AC_DEFUN([ACJF_CHECK_LIB], [dnl
  m4_pushdef([ACJF_VAR_ARGSLIST], [[$@]])dnl
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_PKGNAME], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))dnl
  dnl m4_pattern_allow([ACJF_VAR_PKGNAME])dnl
  dnl echo "[ACJF_VAR_PKGNAME]: ACJF_M4_QUOTE(ACJF_VAR_PKGNAME)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_TAGS], [[]])dnl
  m4_if(m4_bregexp(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [\<disabled\>\|\<intern:\|\<intern\>\|\<extern\>\|\<pkgconfig:\|\<configscript:]), [-1],
   [m4_if(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST), [[]],
     [m4_define([ACJF_VAR_TAGS], [[[extern]]])ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])],
     [m4_define([ACJF_VAR_TAGS], ACJF_M4_QUOTE(ACJF_M4_QUOTE([intern:]ACJF_M4_UNQUOTE(ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)),[extern])))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])
   ])],
   [m4_define([ACJF_VAR_TAGS], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST))ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST])])dnl
  dnl m4_pattern_allow([ACJF_VAR_TAGS])dnl
  dnl echo "[ACJF_VAR_TAGS]: ACJF_M4_QUOTE(ACJF_VAR_TAGS)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_TESTCODE_INCLUDE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))dnl
  dnl m4_pattern_allow([ACJF_VAR_TESTCODE_INCLUDE])dnl
  dnl echo "[ACJF_VAR_TESTCODE_INCLUDE]: ACJF_M4_QUOTE(ACJF_VAR_TESTCODE_INCLUDE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_TESTCODE_BODY], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))dnl
  dnl m4_pattern_allow([ACJF_VAR_TESTCODE_BODY])dnl
  dnl echo "[ACJF_VAR_TESTCODE_BODY]: ACJF_M4_QUOTE(ACJF_VAR_TESTCODE_BODY)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  dnl check if we need ACJF_VAR_TESTCODE_LIB
  m4_if(m4_bregexp(ACJF_VAR_TAGS, [\<pkgconfig:\|\<configscript:]), [-1],
    [m4_pushdef([ACJF_VAR_TESTCODE_LIB], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))],
    [m4_pushdef([ACJF_VAR_TESTCODE_LIB], [])])dnl
  dnl m4_pattern_allow([ACJF_VAR_TESTCODE_LIB])dnl
  dnl echo "[ACJF_VAR_TESTCODE_LIB]: ACJF_M4_QUOTE(ACJF_VAR_TESTCODE_LIB)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_TRUE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_TRUE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_TRUE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_TRUE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  m4_pushdef([ACJF_VAR_CODE_IF_FALSE], ACJF_M4_LIST_FRONT(ACJF_VAR_ARGSLIST)ACJF_M4_LISTVAR_POP_FRONT([ACJF_VAR_ARGSLIST]))
  dnl m4_pattern_allow([ACJF_VAR_CODE_IF_FALSE])dnl
  dnl echo "[ACJF_VAR_CODE_IF_FALSE]: ACJF_M4_QUOTE(ACJF_VAR_CODE_IF_FALSE)"
  dnl echo "ACJF_M4_QUOTE(ACJF_VAR_ARGSLIST)"
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS)dnl
  ACJF_CHECK_LIB_TESTER(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS,
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
      ACJF_VAR_TESTCODE_INCLUDE,
      ACJF_VAR_TESTCODE_BODY,
      ACJF_VAR_TESTCODE_LIB),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  m4_popdef([ACJF_VAR_CODE_IF_FALSE])dnl
  m4_popdef([ACJF_VAR_CODE_IF_TRUE])dnl
  m4_popdef([ACJF_VAR_TESTCODE_LIB])
  m4_popdef([ACJF_VAR_TESTCODE_BODY])
  m4_popdef([ACJF_VAR_TESTCODE_INCLUDE])
  m4_popdef([ACJF_VAR_TAGS])dnl
  m4_popdef([ACJF_VAR_PKGNAME])dnl
  m4_popdef([ACJF_VAR_ARGSLIST])dnl
])

dnl NEW ACJF_CONFIG_PKG USAGE:
dnl
dnl ACJF_CONFIG_PKG(
dnl   <pkgname>,
dnl   <tags>)
dnl
dnl tags (empty defaults to compile):
dnl   disabled        if no --with-xxxx option is specified disable the package
dnl   compile:xxx     search for <pkgname> in srcdir subdirectory xxx
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
  m4_pushdef([ACJF_VAR_PKGNAME], [[$1]])dnl
  dnl default srcdir subdirectory is <pkgname>
  m4_pushdef([ACJF_VAR_SUBDIR], [[$1]])dnl
  m4_if(m4_eval([$#<=1]), [1],
   [m4_pushdef([ACJF_VAR_TAGS], [[[compile:$1]]])],
   [m4_if(m4_bregexp([$2], [\<disabled\>\|\<compile\>\|\<compile:]), [-1],
     [m4_pushdef([ACJF_VAR_TAGS], [[[compile:$2]]])],
     [m4_pushdef([ACJF_VAR_TAGS], [[$2]])dnl
   ])])dnl
  dnl Iterate over tags to set ACJF_VAR_SUBDIR.
  ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
   [dnl set ACJF_VAR_SUBDIR from compile:xxx tag
    m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<compile:]), [0],
     [m4_define([ACJF_VAR_SUBDIR], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<compile:\(.*\)], [[\1]]))dnl
   ])])dnl
  dnl echo "[FLUPS_VAR_PKGNAME]: ACJF_VAR_PKGNAME"
  dnl echo "[FLUPS_VAR_SUBDIR]:  ACJF_VAR_SUBDIR"
  dnl echo "[FLUPS_VAR_TAGS]:    ACJF_VAR_TAGS"
  ACJF_ARG_WITHPKG(ACJF_VAR_PKGNAME, ACJF_VAR_TAGS)
  acjf_var_bundled=no
  acjf_var_alt=no
  for acjf_var_item in $[acjf_]ACJF_M4_CANON_DC(ACJF_VAR_PKGNAME)[_search_list]; do
    eval acjf_var_item_type=\$${acjf_var_item}_type;
    dnl echo "$1: $acjf_var_item_type"
    if test x"$acjf_var_item_type" = x"bundled" -o \
            x"$acjf_var_item_type" = x"pkg-config-bundled"; then
      acjf_var_bundled=yes
    else
      acjf_var_alt=yes
    fi
  done
  if test -f "$srcdir/ACJF_VAR_SUBDIR/configure.in" \
       -o -f "$srcdir/ACJF_VAR_SUBDIR/configure.ac" ; then
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
