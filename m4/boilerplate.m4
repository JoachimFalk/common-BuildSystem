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

dnl ACJF_INIT
AC_DEFUN([ACJF_INIT],[
m4_define([ACJF_VAR_SUBPROJECT_DIR], [])dnl
m4_define([ACJF_VAR_SUBSTVARFIXUP], [[AM_LDFLAGS,AM_CPPFLAGS]])dnl
acjf_top_builddir=`pwd`
acjf_top_srcdir=`cd "$srcdir" && pwd`
AH_TOP(
[/* vim: set sw=2 ts=8 syn=c: */

#ifndef _INCLUDED_CONFIG_H
#define _INCLUDED_CONFIG_H
])dnl
])

dnl ACJF_DONE
AC_DEFUN([ACJF_DONE],[AC_REQUIRE([ACJF_INIT])dnl
ACJF_M4_FOREACH(ACJF_VAR_SUBSTVARFIXUP,
 [[§1]=`echo "$[§1]" | sed dnl
    -e "s@\(-I\|-L\|\<\)$acjf_top_srcdir\(/\|\>\)@\1\\$(top_srcdir)\2@g" dnl
    -e "s@\(-I\|-L\|\<\)$acjf_top_builddir\(/\|\>\)@\1\\$(top_builddir)\2@g"`
  AC_SUBST([§1])])dnl
case $ac_aux_dir in
  $srcdir/*)
    auxdir='$(top_srcdir)/'`echo $ac_aux_dir | sed -e "s|^$srcdir/||"`
    ;;
  *)
    auxdir='$(top_builddir)/'"$ac_aux_dir";
    ;;
esac
AC_SUBST([auxdir])dnl
AH_BOTTOM(
[#endif /* _INCLUDED_CONFIG_H */
])])

# m4_si nclude([subproject subdir/configure.in.frag])
## do not remove space between m4_si and nclude because
## the concatenated name is automagically hardcoded in aclocal
m4_define([m4_sinclude],[dnl
m4_pushdef([ACJF_VAR_SUBPROJECT_DIR], ACJF_M4_PATH_DIRNAME([$1])[/])dnl
m4_builtin([sinclude], [$1])dnl
m4_popdef([ACJF_VAR_SUBPROJECT_DIR])dnl
])
