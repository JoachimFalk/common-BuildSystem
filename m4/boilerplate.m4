dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2001 - 2013 Joachim Falk <joachim.falk@gmx.de>
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2011 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2013 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2015 FAU -- Tobias Schwarzer <tobias.schwarzer@fau.de>
dnl   2015 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_INIT
AC_DEFUN([ACJF_INIT],[
ac_test_CPPFLAGS=${CPPFLAGS+set}
ac_save_CPPFLAGS=$CPPFLAGS
AH_TOP(
[/* vim: set sw=2 ts=8 syn=c: */

#ifndef _INCLUDED_CONFIG_H
#define _INCLUDED_CONFIG_H
])dnl
m4_define([ACJF_VAR_SUBPROJECT_DIR], [])dnl
m4_define([ACJF_VAR_SUBSTVARFIXUP], [[AM_LDFLAGS,AM_CPPFLAGS]])dnl
m4_define([ACJF_VAR_SHELL_ANONVAR_COUNTER], 0)
m4_define([ACJF_VAR_M4_ANONMACRO_COUNTER], 0)
acjf_abs_top_builddir=`pwd`
acjf_abs_top_srcdir=`cd "$srcdir" && pwd`
m4_define([ACJF_VAR_ROOT_BUILDDIR], m4_esyscmd([
  dir="."
  while test ! -d "$dir/BuildSystem" -o -L "$dir/BuildSystem"; do
    if test x`cd "$dir" && pwd` = x"/"; then
      exit 0;
    fi
    if test x"$dir" = x"."; then
      dir=".."
    else
      dir="../$dir"
    fi
  done
  # echo -n no newline
  echo -n "$dir"
]))dnl
m4_if(ACJF_VAR_ROOT_BUILDDIR, [], [AC_MSG_ERROR([Cannot find BuildSystem, bailing out!])])
AC_CONFIG_AUX_DIR(ACJF_VAR_ROOT_BUILDDIR/BuildSystem)
m4_if(ACJF_VAR_ROOT_BUILDDIR, [.],
 [acjf_root_srcdir="$srcdir"],
 [acjf_root_srcdir="$srcdir/ACJF_VAR_ROOT_BUILDDIR"])
acjf_root_builddir="ACJF_VAR_ROOT_BUILDDIR"
acjf_abs_root_srcdir=`cd "$acjf_root_srcdir" && pwd`
acjf_abs_root_builddir=`cd "$acjf_root_builddir" && pwd`
dnl Predefined search options for <pkgname>_search_list
acjf_std_incpath=""
acjf_std_libpath=""
acjf_std_desc="standard compiler search paths"
acjf_std_type="std"
acjf_bundled_desc="source tree"
acjf_bundled_type="bundled"
acjf_disabled_desc="disabled"
acjf_disabled_type="disabled"
if test -f pkgconfig/.pkg_config_path; then
  rm -f pkgconfig/.pkg_config_path
fi
])

dnl ACJF_GEN_ANONYMOUS_SHELL_VAR
AC_DEFUN([ACJF_GEN_ANONYMOUS_SHELL_VAR],
[[_acjf_var_anon]ACJF_VAR_SHELL_ANONVAR_COUNTER[_]dnl
m4_define([ACJF_VAR_SHELL_ANONVAR_COUNTER], m4_eval(ACJF_VAR_SHELL_ANONVAR_COUNTER+1))])

dnl ACJF_GEN_ANONYMOUS_M4_MACRO
AC_DEFUN([ACJF_GEN_ANONYMOUS_M4_MACRO],
[[_ACJF_M4_ANON]ACJF_VAR_M4_ANONMACRO_COUNTER[_]dnl
m4_define([ACJF_VAR_M4_ANONMACRO_COUNTER], m4_eval(ACJF_VAR_M4_ANONMACRO_COUNTER+1))])

dnl ACJF_DONE
AC_DEFUN([ACJF_DONE],[
AC_REQUIRE([ACJF_INIT])dnl
AH_BOTTOM(
[#endif /* _INCLUDED_CONFIG_H */
])
case $ac_aux_dir in
  $srcdir/*)
    auxdir='$(top_srcdir)/'`echo $ac_aux_dir | sed -e "s|^$srcdir/||"`
    ;;
  *)
    auxdir='$(top_builddir)/'"$ac_aux_dir";
    ;;
esac
AC_SUBST([auxdir])dnl
case $acjf_root_srcdir in
  $srcdir/*)
    root_srcdir='$(top_srcdir)/'`echo $acjf_root_srcdir | sed -e "s|^$srcdir/||"`
    ;;
  *)
    root_srcdir='$(top_builddir)/'"$acjf_root_srcdir";
    ;;
esac
AC_SUBST([root_srcdir])dnl
root_builddir='$(top_builddir)/'"$acjf_root_builddir";
AC_SUBST([root_builddir])dnl
if test -d "$srcdir/pkgconfig"; then
  acjf_var_pkg_config_path="${acjf_abs_top_builddir}/pkgconfig"
  if test -f pkgconfig/.pkg_config_path; then
    while read line; do
      case "$line" in
        "") # ignore
          ;;
        /*) # abs path
          [acjf_var_pkg_config_path="${acjf_var_pkg_config_path}:${line}"]
          ;;
        *) # rel path
          [acjf_var_pkg_config_path="${acjf_var_pkg_config_path}:${acjf_abs_top_builddir}/pkgconfig/${line}"]
          ;;
      esac
    done < pkgconfig/.pkg_config_path
    if test x"$PKG_CONFIG_PATH" != x""; then
      [acjf_var_pkg_config_path="${acjf_var_pkg_config_path}:${PKG_CONFIG_PATH}"]
    fi
  fi
  PKG_CONFIG_PATH="${acjf_var_pkg_config_path}"
fi
ACJF_M4_LISTVAR_PUSH_BACK([ACJF_VAR_SUBSTVARFIXUP], [PKG_CONFIG_PATH])dnl
ACJF_M4_FOREACH([ACJF_VAR_SUBSTVAR], ACJF_VAR_SUBSTVARFIXUP,
 [dnl FIXME: The ':' is a hardcoded unix path seperator!!!
  ACJF_VAR_SUBSTVAR=`echo "$ACJF_VAR_SUBSTVAR" | sed dnl Note that [: 	] contains a TAB character!!!
    -e ['s@/\.libs$][@@'] -e ['s@/\.libs\([: 	]\)@\1@g'] dnl
    -e ["s@\(-I\|-L\|^\|[: 	]\)$acjf_abs_top_builddir\(/\|$\|[: 	]\)@\1\\$(top_builddir)\2@g"] dnl
    -e ["s@\(-I\|-L\|^\|[: 	]\)$acjf_abs_top_srcdir\(/\|$\|[: 	]\)@\1\\$(top_srcdir)\2@g"] dnl
    -e ["s@\(-I\|-L\|^\|[: 	]\)$acjf_abs_root_builddir\(/\|$\|[: 	]\)@\1\\$(root_builddir)\2@g"] dnl
    -e ["s@\(-I\|-L\|^\|[: 	]\)$acjf_abs_root_srcdir\(/\|$\|[: 	]\)@\1\\$(root_srcdir)\2@g"]`
  AC_SUBST(ACJF_VAR_SUBSTVAR)])dnl
])

# m4_si nclude([subproject subdir/configure.in.frag])
## do not remove space between m4_si and nclude because
## the concatenated name is automagically hardcoded in aclocal
m4_define([m4_sinclude],[dnl
m4_pushdef([ACJF_VAR_SUBPROJECT_DIR], ACJF_M4_PATH_DIRNAME([$1])[/])dnl
m4_builtin([sinclude], [$1])dnl
m4_popdef([ACJF_VAR_SUBPROJECT_DIR])dnl
])
