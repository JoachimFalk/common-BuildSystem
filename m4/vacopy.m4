dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2001 - 2006 Joachim Falk <joachim.falk@gmx.de>
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
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

dnl check for va_copy __va_copy or role your own
AC_DEFUN([ACJF_CHECK_VA_COPY],
[AC_CACHE_CHECK(
 [for va_copy],
 [ac_cv_func_va_copy],
 [AC_LINK_IFELSE(
   [AC_LANG_PROGRAM([[#include <stdarg.h>]],
     [[va_list ap1, ap2; va_copy(ap1, ap2);]])],
   [ac_cv_func_va_copy="yes"],
   [ac_cv_func_va_copy="no"])])
if test "x$ac_cv_func_va_copy" = "xyes"; then
  AC_DEFINE(HAVE_VA_COPY,1,[Do we have va_copy in stdarg.h than define this])
else
  AC_CACHE_CHECK(
   [for __va_copy],
   [ac_cv_func___va_copy],
   [AC_LINK_IFELSE(
     [AC_LANG_PROGRAM([[#include <stdarg.h>]],
       [[va_list ap1, ap2; __va_copy(ap1, ap2);]])],
     [ac_cv_func___va_copy="yes"],
     [ac_cv_func___va_copy="no"])])
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
