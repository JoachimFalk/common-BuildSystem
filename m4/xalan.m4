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

AC_DEFUN([ACJF_CHECK_LIB_XALAN],
[dnl
AC_LANG_PUSH([C++])
WITH_XALAN_INCLUDE=
WITH_XALAN_LIB=
WITH_XALAN_BASE=
AC_ARG_WITH(xalan-include,
  [  --with-xalan-include  Path to Xalan include directory],
  [WITH_XALAN_INCLUDE="$withval"])
  
AC_ARG_WITH(xalan-lib,
  [  --with-xalan-lib      Path to Xalan lib directory],
  [WITH_XALAN_LIB="$withval"])

if test x"$WITH_XALAN_INCLUDE" != "x"; then
  WITH_XALAN_BASE=`echo $WITH_XALAN_INCLUDE | sed -e 's@^\(.*\)[[/\\]]include\([[/\\]].*\|\)[$]@\1@'`
elif test x"$WITH_XALAN_LIB" != "x"; then
  WITH_XALAN_BASE=`echo $WITH_XALAN_LIB | sed -e 's@^\(.*\)[[/\\]]lib\([[/\\]].*\|\)[$]@\1@'`
fi
  
acjf_list=""
if test x"$WITH_XALAN_INCLUDE" != x; then
  acjf_list="$acjf_list $WITH_XALAN_INCLUDE";
fi
if test x"$WITH_XALAN_BASE" != x; then
  acjf_list="$acjf_list $WITH_XALAN_BASE/include";
fi
if test x"$XALAN_BASE" != x; then
  acjf_list="$acjf_list $XALAN_BASE/include";
fi

ACJF_CHECK_HEADER(
  [xalan],
  [#include <xalanc/XPath/XPathEvaluator.hpp>],
  [xalanc::XPathEvaluator::initialize();],
  [$acjf_list])

acjf_list=""
if test x"$WITH_XALAN_LIB" != x; then
  acjf_list="$acjf_list $WITH_XALAN_LIB";
fi
if test x"$WITH_XALAN_BASE" != x; then
  acjf_list="$acjf_list $WITH_XALAN_BASE/lib";
fi
if test x"$XALAN_BASE" != x; then
  acjf_list="$acjf_list $XALAN_BASE/lib";
fi

acjf_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$acjf_CPPFLAGS $XALAN_INCLUDE";
ACJF_CHECK_LIBONLY(
  [xalan],
  [#include <xalanc/XPath/XPathEvaluator.hpp>],
  [xalanc::XPathEvaluator::initialize();],
  [xalan-c],
  [$acjf_list])
CPPFLAGS="$acjf_CPPFLAGS"

AC_LANG_POP
])
