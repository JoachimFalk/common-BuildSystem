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

dnl check for type
dnl ACJF_CHECK_TYPE( <typename>,
dnl		     <includes>,
dnl		     <action if yes>,
dnl		     <action if no> )
AC_DEFUN([ACJF_CHECK_TYPE],
[acjf_check_type_headers=""
m4_foreach_w(acjf_header,[$2],
 [AC_CHECK_HEADER(acjf_header,
   [acjf_check_type_headers="$acjf_check_type_headers
#include \"]acjf_header[\""]
  )]
)

AC_MSG_CHECKING([for $1])
AC_CACHE_VAL([ac_cv_type_]ACJF_M4_CANON_CV([$1]),
 [AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM([[$acjf_check_type_headers]],
     [[$1 x;]])],
   [ac_cv_type_]ACJF_M4_CANON_CV([$1])[="yes";],
   [ac_cv_type_]ACJF_M4_CANON_CV([$1])[="no";])])
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
