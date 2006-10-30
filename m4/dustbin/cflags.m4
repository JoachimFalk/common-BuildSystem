dnl vim: set sw=2 ts=8 syn=config:
dnl
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

AC_DEFUN([ACJF_APPEND_CFLAGS], [CFLAGS="$CFLAGS $1"])
AC_DEFUN([ACJF_APPEND_CXXFLAGS], [CXXFLAGS="$CXXFLAGS $1"])

# ACJF_PROG_CC_ACCEPTS_OPT([OPTIONS], [ACTION-IF-YES], [ACTION-IF-NO])
#  ACTION-IF-YES: default add option to CFLAGS
# -------------
# Check whether option works, even if CFLAGS is set, in case the package
# plays around with CFLAGS (such as to build both debugging and normal
# versions of a library), tasteless as that idea is.
AC_DEFUN([ACJF_PROG_CC_ACCEPTS_OPT],
[ ac_save_CFLAGS=$CFLAGS
  CFLAGS="$CFLAGS $1"
  AC_CACHE_CHECK([whether $CC accepts $1], [acjf_cv_prog_cc_]ACJF_M4_CANON_CV([$1]),
                 [AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [acjf_cv_prog_cc_]ACJF_M4_CANON_CV([$1])[=yes],
                                                         [acjf_cv_prog_cc_]ACJF_M4_CANON_CV([$1])[=no])])
  CFLAGS=$ac_save_CFLAGS
  m4_if($#, 1, [dnl
    if test "x$ac_test_CFLAGS" != "xset" -a \
            "x$[acjf_cv_prog_cc_]ACJF_M4_CANON_CV([$1])" = "xyes"; then
      ACJF_APPEND_CFLAGS([$1])
    fi], [dnl
    if test "x$[acjf_cv_prog_cc_]ACJF_M4_CANON_CV([$1])" = "xyes"; then
      $2
    else
      $3
    fi])[]dnl
])# ACJF_PROG_CC_ACCEPTS_OPT

# ACJF_PROG_CXX_ACCEPTS_OPT([OPTIONS], [ACTION-IF-YES], [ACTION-IF-NO])
#  ACTION-IF-YES: default add option to CFLAGS
# -------------
# Check whether option works, even if CFLAGS is set, in case the package
# plays around with CFLAGS (such as to build both debugging and normal
# versions of a library), tasteless as that idea is.
AC_DEFUN([ACJF_PROG_CXX_ACCEPTS_OPT],
[ ac_save_CXXFLAGS=$CXXFLAGS
  CXXFLAGS="$CXXFLAGS $1"
  AC_CACHE_CHECK([whether $CXX accepts $1], [acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1]),
                 [AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1])[=yes],
                                                         [acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1])[=no])])
  CXXFLAGS=$ac_save_CXXFLAGS
  echo "CXXFLAGS: $CXXFLAGS"
  echo "ac_test_CXXFLAGS: $ac_test_CXXFLAGS"
  echo "[acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1]): $[acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1])"
  m4_if($#, 1, [dnl
    if test "x$ac_test_CFLAGS" != "xset" -a \
            "x$[acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1])" = "xyes"; then
      ACJF_APPEND_CXXFLAGS([$1])
    fi], [dnl
    if test "x$[acjf_cv_prog_cxx_]ACJF_M4_CANON_CV([$1])" = "xyes"; then
      $2
    else
      $3
    fi])[]dnl
  ; echo "CXXFLAGS: $CXXFLAGS"[]dnl
])# ACJF_PROG_CXX_ACCEPTS_OPT
