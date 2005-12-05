dnl vim: set sw=2 ts=8 syn=config:
dnl
dnl Copyright (C) Joachim Falk <joachim.falk@gmx.de> $Date: 2003/01/24 13:23:54 $
dnl
dnl all.m4 is part of the SysteMoC distribution of Joachim Falk;
dnl you can redistribute it and/or modify it under the terms of the
dnl GNU General Public License as published by the Free Software Foundation;
dnl either version 2 of the License, or (at your option) any later version.
dnl
dnl The jflibs distributio is distributed in the hope that it will be useful,
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
AH_TOP(
[/* vim: set sw=2 ts=8 syn=c: */

#ifndef _INCLUDED_CONFIG_H
#define _INCLUDED_CONFIG_H
])])

dnl ACJF_DONE
AC_DEFUN([ACJF_DONE],[
AC_SUBST([ac_aux_dir])
AH_BOTTOM(
[#endif /* _INCLUDED_CONFIG_H */
])])

AC_DEFUN([ACJF_APPEND_CFLAGS], [CFLAGS="$CFLAGS $1"])
AC_DEFUN([ACJF_APPEND_CXXFLAGS], [CXXFLAGS="$CXXFLAGS $1"])

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
       acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH="$acjf_ldflags";
       break],
      [dnl AC_MSG_RESULT([no])
       acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH="x"])
  done
  dnl CPPFLAGS="$acjf_CPPFLAGS"; 
  LDFLAGS="$acjf_LDFLAGS"; LIBS="$acjf_LIBS";
])
if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH]" != x"x"; then
  AC_MSG_RESULT([$acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH])
  if test x"[$acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH]" != x"$acjf_STDLIB"; then
    ACJF_M4_CANON_DN([$1])_LDFLAGS="[-L$acjf_cv_]ACJF_M4_CANON_DN([$1])[_LIBPATH]"
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

dnl ACJF_ARG_DEBUG(<default yes|no>,
dnl		   <CFLAG option added if yes>,
dnl		   <CFLAG option added if no>)
AC_DEFUN([ACJF_ARG_DEBUG], 
[dnl
AC_BEFORE([$0],  [ACJF_APPEND_CFLAGS])dnl
AC_BEFORE([$0], [ACJF_APPEND_CXXFLAGS])dnl
AC_MSG_CHECKING([whether to build with debug])
AC_ARG_ENABLE(
  debug,
  [[  --enable-debug          enable debuging [default=$1]]],
  [case "$enableval" in
     yes) enable_debug=yes ;;
     no)  enable_debug=no  ;;
     *)   enable_debug=no  ;;
   esac],
  [enable_debug=$1]
)
AC_MSG_RESULT($enable_debug)
if test "x$enable_debug" = "xyes"; then
  if test "$ac_test_CFLAGS" = set; then
    CFLAGS="$CFLAGS $2"
  elif test $ac_cv_prog_cc_g = yes; then
    if test "$GCC" = yes; then
      CFLAGS="-Wall -ggdb $2"
    else
      CFLAGS="-g $2"
    fi
  else
    CFLAGS="$2"
  fi
  if test "$ac_test_CXXFLAGS" = set; then
    CXXFLAGS="$CXXFLAGS $2"
  elif test $ac_cv_prog_cxx_g = yes; then
    if test "$GCC" = yes; then
      CXXFLAGS="-Wall -ggdb $2"
    else
      CXXFLAGS="-g $2"
    fi
  else
    CXXFLAGS="$2"
  fi
else
  if test "$ac_test_CFLAGS" = set; then
    CFLAGS="$CFLAGS $3"
  else
    if test "$GCC" = yes; then
      CFLAGS="-O2 $3"
    else
      CFLAGS="-O $3"
    fi
  fi
  if test "$ac_test_CXXFLAGS" = set; then
    CXXFLAGS="$CXXFLAGS $3"
  else
    if test "$GCC" = yes; then
      CXXFLAGS="-O2 $3"
    else
      CXXFLAGS="-O $3"
    fi
  fi
fi
AM_CONDITIONAL(DEBUG, test x$enable_debug = xyes)
])

dnl check for type
dnl ACJF_CHECK_TYPE( <typename>,
dnl		     <includes>,
dnl		     <action if yes>,
dnl		     <action if no> )
AC_DEFUN([ACJF_CHECK_TYPE],
[acjf_check_type_headers=""
AC_FOREACH(acjf_header,[$2],
 [AC_CHECK_HEADER(acjf_header,
   [acjf_check_type_headers="$acjf_check_type_headers
#include \"]acjf_header[\""]
  )]
)

AC_MSG_CHECKING([for $1])
AC_CACHE_VAL([ac_cv_type_]ACJF_M4_CANON_CV([$1]),
 [AC_TRY_COMPILE(
   [$acjf_check_type_headers],
   [$1 x;],
   [ac_cv_type_]ACJF_M4_CANON_CV([$1])[="yes";],
   [ac_cv_type_]ACJF_M4_CANON_CV([$1])[="no";]
  )]
)
if eval "test \"x\${ac_cv_type_[]ACJF_M4_CANON_CV([$1])}\" = \"xyes\""; then
  AC_MSG_RESULT([yes])
  AC_DEFINE([HAVE_]ACJF_M4_CANON_DN([$1]),1,[define if you have the ']$1[' type])
  m4_if([$3], , , [$3])dnl
else
  AC_MSG_RESULT([no])
  m4_if([$4], , , [$4])dnl
fi])

dnl check for stdint
AC_DEFUN([ACJF_CHECK_STDINT],
[acjflib_miss_stdint=no
ACJF_CHECK_TYPE(int8_t,
  [stdlib.h stddef.h sys/types.h stdint.h],,
  [acjflib_miss_stdint=yes])
ACJF_CHECK_TYPE(int16_t,
  [stdlib.h stddef.h sys/types.h stdint.h],,
  [acjflib_miss_stdint=yes])
ACJF_CHECK_TYPE(int32_t,
  [stdlib.h stddef.h sys/types.h stdint.h],,
  [acjflib_miss_stdint=yes])
ACJF_CHECK_TYPE(int64_t,
  [stdlib.h stddef.h sys/types.h stdint.h],,
  [acjflib_miss_stdint=yes])

if test "x$acjflib_miss_stdint" != "xno"; then
  AC_CHECK_SIZEOF(char,1)
  AC_CHECK_SIZEOF(short,2)
  AC_CHECK_SIZEOF(int,4)
  AC_CHECK_SIZEOF(long,4)
  AC_CHECK_SIZEOF(long long,8)
fi])

dnl checking for size_t and ssize_t and make sure they exist
AC_DEFUN([ACJF_TYPE_SIZE_T],
[acjflib_miss_size_t=""
acjflib_miss_ssize_t=""
ACJF_CHECK_TYPE(size_t,
  [stdlib.h stddef.h sys/types.h],,
  [acjflib_miss_size_t=yes])
ACJF_CHECK_TYPE(ssize_t,
  [stdlib.h stddef.h sys/types.h],,
  [acjflib_miss_ssize_t=yes])
if test "x$acjflib_miss_size_t" != "x$acjflib_miss_ssize_t"; then
  AC_CHECK_SIZEOF(char,1)
  AC_CHECK_SIZEOF(short,2)
  AC_CHECK_SIZEOF(int,4)
  AC_CHECK_SIZEOF(long,4)
  AC_CHECK_SIZEOF(long long,8)
  if test "x$acjflib_miss_size_t" = "xyes"; then
    AC_CHECK_SIZEOF(ssize_t,4)
    case "x$ac_cv_sizeof_ssize_t" in
      "x$ac_cv_sizeof_char")
        acjflib_miss_size_t="unsigned char";
      ;;
      "x$ac_cv_sizeof_short")
        acjflib_miss_size_t="unsigned short";
      ;;
      "x$ac_cv_sizeof_int")
        acjflib_miss_size_t="unsigned int";
      ;;
      "x$ac_cv_sizeof_long")
        acjflib_miss_size_t="unsigned long";
      ;;
      "x$ac_cv_sizeof_long_long")
        acjflib_miss_size_t="unsigned long long";
      ;;
      *)
        acjflib_miss_size_t="fuck what now can't find suitable size_t";
      ;;
    esac
  else
    AC_CHECK_SIZEOF(size_t,4)
    case "x$ac_cv_sizeof_size_t" in
      "x$ac_cv_sizeof_char")
        acjflib_miss_ssize_t="char";
      ;;
      "x$ac_cv_sizeof_short")
        acjflib_miss_ssize_t="short";
      ;;
      "x$ac_cv_sizeof_int")
        acjflib_miss_ssize_t="int";
      ;;
      "x$ac_cv_sizeof_long")
        acjflib_miss_ssize_t="long";
      ;;
      "x$ac_cv_sizeof_long_long")
        acjflib_miss_ssize_t="long long";
      ;;
      *)
        acjflib_miss_ssize_t="fuck what now can't find suitable ssize_t";
      ;;
    esac
  fi
elif test "x$acjflib_miss_size_t" = "xyes"; then
  acjflib_miss_size_t="unsigned int";
  acjflib_miss_ssize_t="int";
fi
if test "x$acjflib_miss_size_t" != "x"; then
  AC_DEFINE_UNQUOTED([size_t],[$acjflib_miss_size_t],
    [define this to your size_t type if you dont have one predefined])
fi
if test "x$acjflib_miss_ssize_t" != "x"; then
  AC_DEFINE_UNQUOTED([ssize_t],[$acjflib_miss_ssize_t],
    [define this to your ssize_t type if you dont have one predefined])
fi])

dnl check for va_copy __va_copy or role your own
AC_DEFUN([ACJF_CHECK_VA_COPY],
[AC_CACHE_CHECK(
 [for va_copy],
 [ac_cv_func_va_copy],
 [AC_TRY_LINK(
   [#include <stdarg.h>],
   [va_list ap1, ap2;
    va_copy( ap1, ap2 );],
   [ac_cv_func_va_copy="yes"],
   [ac_cv_func_va_copy="no"]
  )]
)
if test "x$ac_cv_func_va_copy" = "xyes"; then
  AC_DEFINE(HAVE_VA_COPY,1,[Do we have va_copy in stdarg.h than define this])
else
  AC_CACHE_CHECK(
   [for __va_copy],
   [ac_cv_func___va_copy],
   [AC_TRY_LINK(
     [#include <stdarg.h>],
     [va_list ap1, ap2;
      __va_copy( ap1, ap2 );],
     [ac_cv_func___va_copy="yes"],
     [ac_cv_func___va_copy="no"]
    )]
  )
  if test "x$ac_cv_func___va_copy" = "xyes"; then
    AC_DEFINE(HAVE___VA_COPY,1,[Do we have __va_copy in stdarg.h than define this])
  else
    AC_DEFINE(DO_VA_PTR_COPY,1,[have neither va_copy nor __va_copy than define this and pray])
  fi
fi
AH_BOTTOM([/*
 * NOTE: Some routine need va_copy() from stdarg.h, as
 * specified by C9X, to be able to traverse the same list of arguments twice.
 * I don't know of any other standard and portable way of achieving the same.
 * With some versions of gcc you may use __va_copy(). You might even get away
 * with "ap2 = ap", in this case it may not be safe to call va_end(ap2) !
 */
#ifdef HAVE_VA_COPY
 /* dito have it */
#else
# if HAVE___VA_COPY
#   define va_copy( dest, src ) __va_copy( dest, src )
# else
#   if DO_VA_PTR_COPY
#     define va_copy( dest, src ) do { dest = src; } while ( 0 )
#   else
      /* fuck what now ? */
#   endif
# endif
#endif])
])

dnl check for cross tool
dnl ACJF_CHECK_CROSSTOOL( <toolname>,
dnl			  <default name> )
AC_DEFUN([ACJF_CHECK_CROSSTOOL],
[m4_pattern_allow([$1_FOR_BUILD])
acjf_test_CFLAGS=${CFLAGS+set}; acjf_save_CFLAGS="$CFLAGS";
acjf_test_CXXFLAGS=${CXXFLAGS+set}; acjf_save_CXXFLAGS="$CXXFLAGS";
if test "x$host" != "x$build"; then
  dnl Supporting Canadian Cross in Configure Scripts
  if test "x$$1" = "x"; then
    $1="$host_alias-$2";
  fi
  AC_CHECK_PROGS( [$1_FOR_BUILD], $2 )
fi
ifdef([AC_PROG_$1],
  [AC_PROG_$1],
  [AC_CHECK_PROGS( $1, $2 )])
if test "x$host" = "x$build"; then
  [$1_FOR_BUILD]="$$1"
  AC_SUBST([$1_FOR_BUILD])
fi
if test x$acjf_test_CFLAGS = xset; then
  CFLAGS="$acjf_save_CFLAGS";
else
  unset CFLAGS
fi
if test x$acjf_test_CXXFLAGS = xset; then
  CFLAGS="$acjf_save_CXXFLAGS";
else
  unset CXXFLAGS
fi
])

dnl
dnl Check for presense of various libraries
dnl ACJF_CHECK_LIBS( <libs> )
dnl
AC_DEFUN([ACJF_CHECK_LIBS],
[for acjf_lib in $1; do
  AC_CHECK_LIB([$acjf_lib],[main])
done])

dnl
dnl Add packages to the include and lib pathes
dnl
AC_DEFUN([ACJF_NEED_PKG],
[for dir in $1; do
  if test -d ../$dir; then
    INCLUDES="$INCLUDES -I../$dir/include";
    AM_LDFLAGS="$AM_LDFLAGS -L../$dir -L../$dir/.libs";
  fi
done
AC_SUBST(INCLUDES)
AC_SUBST(AM_LDFLAGS)
])

AC_DEFUN([ACJF_INVESTIGATE_CCBASE],
[AC_CACHE_CHECK([for the $CC compiler base],
  [acjf_cv_path_ccbase],
  [acjf_cv_path_ccbase=`which $CC`;
   acjf_cv_path_ccbase="`dirname $acjf_cv_path_ccbase`/..";
   if test "x$host_alias" != "x"; then
     acjf_cv_path_ccbase="$acjf_cv_path_ccbase/$host_alias";
   fi])
])

dnl
dnl Add packages to the include and lib pathes
dnl
AC_DEFUN([ACJF_NEED_LIBIBERTY],
[AC_CHECK_LIB(iberty, libiberty_concat_ptr,
  [],
  [AC_MSG_ERROR([cannot find -liberty, bailing out])])
ACJF_INVESTIGATE_CCBASE
AC_CACHE_CHECK([for libiberty headers],
  [acjf_cv_includepath_libiberty],
  [if test -d "$includedir/libiberty"; then
    acjf_cv_includepath_libiberty="$(includedir)/libiberty";
  elif test -d "$acjf_cv_path_ccbase/include/libiberty"; then
    acjf_cv_includepath_libiberty="$acjf_cv_path_ccbase/include/libiberty";
  fi])
  if test x"$acjf_cv_includepath_libiberty" != x; then
    INCLUDES="$INCLUDES -I $acjf_cv_includepath_libiberty";
    AC_SUBST(INCLUDES)
  else
    AC_MSG_ERROR([cannot find libiberty headers, bailing out])
  fi
])

# ACJF_CHECK_VAR(VARIABLE, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# -----------------------------------------------------------------
AC_DEFUN([ACJF_CHECK_VAR],
[AS_VAR_PUSHDEF([ac_var], [acjf_cv_var_$1])dnl
AC_CACHE_CHECK([for $1], ac_var,
[AC_TRY_LINK([int *p;], [extern int $1 []; p = $1;],
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
