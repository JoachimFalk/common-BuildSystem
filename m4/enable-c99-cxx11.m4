dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2015 Joachim Falk <joachim.falk@gmx.de>
dnl   2018 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2020 Joachim Falk <joachim.falk@gmx.de>
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

dnl ACJF_CHECK_DIALECTS_C99_CXX11(
dnl  [<code if supported, default does nothing>,
dnl  [<code if not supported, default is bailout>]])
dnl
dnl After execution of the macro
dnl
dnl If C99 and C++11 are supported define:
dnl   C99FLAGS    if C99 is supported
dnl   CXX11FLAGS  if C++11 is supported
AC_DEFUN([ACJF_CHECK_DIALECTS_C99_CXX11],
 [acjf_var_C99FLAGS_set=${acjf_cv_C99FLAGS+set}
  if test x"${acjf_var_C99FLAGS_set}" = x"set"; then
    AC_MSG_CHECKING([for the required flags for the C compiler ${CC} to support C99])
  fi
  AC_CACHE_VAL([acjf_cv_C99FLAGS],
   [AC_LANG_PUSH([C])
    acjf_var_CFLAGS="${CFLAGS}"
    for acjf_cv_C99FLAGS in "" "-std=gnu99"; do
      if test x"${acjf_cv_C99FLAGS}" = x""; then
        AC_MSG_CHECKING([if the C compiler ${CC} supports C99 without any additional flags])
      else
        AC_MSG_CHECKING([if the C compiler ${CC} supports C99 with the ${acjf_cv_C99FLAGS} flag])
      fi
      CFLAGS="${acjf_var_CFLAGS} ${acjf_cv_C99FLAGS}"
      AC_COMPILE_IFELSE(
       [AC_LANG_PROGRAM([[
#include <stdint.h>
#include <stdbool.h>

#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L
# error "WTF?!"
#endif //!defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L
]],[[
for (int flummy = 12; flummy > 3; --flummy)
  ;
bool testbool = true;
]], [])],
       [AC_MSG_RESULT([yes]); break;],
       [AC_MSG_RESULT([no]); acjf_cv_C99FLAGS="unsupported";])
    done
    CFLAGS="${acjf_var_CFLAGS}"
    AC_LANG_POP])
  if test x"${acjf_var_C99FLAGS_set}" = x"set"; then
    if test x"${acjf_cv_C99FLAGS}" = x""; then
      AC_MSG_RESULT([none required])
    else
      AC_MSG_RESULT([${acjf_cv_C99FLAGS}])
    fi
  fi
  unset acjf_var_CFLAGS
  unset acjf_var_C99FLAGS_set

  acjf_var_CXX11FLAGS_set=${acjf_cv_CXX11FLAGS+set}
  if test x"${acjf_var_CXX11FLAGS_set}" = x"set"; then
    AC_MSG_CHECKING([for the required flags for the C++ compiler ${CXX} to support C++11])
  fi
  AC_CACHE_VAL([acjf_cv_CXX11FLAGS],
   [AC_LANG_PUSH([C++])
    acjf_var_CXXFLAGS="${CXXFLAGS}"
    for acjf_cv_CXX11FLAGS in "" "-std=gnu++11" "-std=gnu++0x"; do
      if test x"${acjf_cv_CXX11FLAGS}" = x""; then
        AC_MSG_CHECKING([if the C++ compiler ${CXX} supports C++11 without any additional flags])
      else
        AC_MSG_CHECKING([if the C++ compiler ${CXX} supports C++11 with the ${acjf_cv_CXX11FLAGS} flag])
      fi
      CXXFLAGS="${acjf_var_CXXFLAGS} ${acjf_cv_CXX11FLAGS}"
      AC_COMPILE_IFELSE(
       [AC_LANG_PROGRAM([[
#include <cstdint>
]], [[
static_assert(true, "This should compile!");
]], [])],
       [AC_MSG_RESULT([yes]); break;],
       [AC_MSG_RESULT([no]); acjf_cv_CXX11FLAGS="unsupported";])
    done
    CXXFLAGS="${acjf_var_CXXFLAGS}"
    AC_LANG_POP])
  if test x"${acjf_var_CXX11FLAGS_set}" = x"set"; then
    if test x"${acjf_cv_CXX11FLAGS}" = x""; then
      AC_MSG_RESULT([none required])
    else
      AC_MSG_RESULT([${acjf_cv_CXX11FLAGS}])
    fi
  fi
  unset acjf_var_CXXFLAGS
  unset acjf_var_CXX11FLAGS_set

  if test x"${acjf_cv_C99FLAGS}" != x"unsupported"; then
    C99FLAGS=${acjf_cv_C99FLAGS}
    AC_SUBST([C99FLAGS])
  fi
  if test x"${acjf_cv_CXX11FLAGS}" != x"unsupported"; then
    CXX11FLAGS=${acjf_cv_CXX11FLAGS}
    AC_SUBST([CXX11FLAGS])
  fi

  if test x"${acjf_cv_C99FLAGS}"   != x"unsupported" -a \
          x"${acjf_cv_CXX11FLAGS}" != x"unsupported"; then
    m4_if([$1], [], [true;], [$1])
  else
    m4_if([$1$2], [],
     [if test x"${acjf_cv_C99FLAGS}" = x"unsupported"; then
        AC_MSG_ERROR([No support for C99, bailing out!])
      else
        AC_MSG_ERROR([No support for C++11, bailing out!])
      fi],
     [m4_if([$2], [], [true;], [$2])])
  fi
])

dnl ACJF_ENABLE_DIALECTS_C99_CXX11
dnl
dnl Finds compiler options to turn on C99 and C++11 support and sets AM_CFLAGS and
dnl AM_CXXFLAGS accordingly. If no support is present, we bail out!
AC_DEFUN([ACJF_ENABLE_DIALECTS_C99_CXX11],
 [ACJF_CHECK_DIALECTS_C99_CXX11
  AM_CFLAGS="$AM_CFLAGS $C99FLAGS"
  AC_SUBST([AM_CFLAGS])
  AM_CXXFLAGS="$AM_CXXFLAGS $CXX11FLAGS"
  AC_SUBST([AM_CXXFLAGS])
])
