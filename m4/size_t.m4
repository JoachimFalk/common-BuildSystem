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


