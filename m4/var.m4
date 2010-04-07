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

# ACJF_CHECK_VAR(VARIABLE, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# -----------------------------------------------------------------
AC_DEFUN([ACJF_CHECK_VAR],
[AS_VAR_PUSHDEF([ac_var], [acjf_cv_var_$1])dnl
AC_CACHE_CHECK([for $1], ac_var,
 [AC_LINK_IFELSE(
  [AC_LANG_PROGRAM(
    [[extern int $1;]],
    [[int *p; p = $1;]])],
  [AS_VAR_SET(ac_var, yes)],
  [AS_VAR_SET(ac_var, no)])])
AS_IF([test AS_VAR_GET(ac_var) = yes], [$2], [$3])dnl
AS_VAR_POPDEF([ac_var])dnl
])# ACJF_CHECK_VAR

# ACJF_CHECK_VARS(VARIABLE..., [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------------------
AC_DEFUN([ACJF_CHECK_VARS],
[AC_FOREACH([AC_Var], [$1],
  [AH_TEMPLATE(AS_TR_CPP(HAVE_[]AC_Var),
               [Define to 1 if you have the ']AC_Var[' variable.])])dnl
for ac_variable in $1
do
ACJF_CHECK_VAR($ac_variable,
              [AC_DEFINE_UNQUOTED([AS_TR_CPP([HAVE_$ac_variable])]) $2],
              [$3])dnl
done
])# ACJF_CHECK_VARS
