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

dnl ACJF_ARG_DEBUG(<default yes|no>,
dnl		   <CFLAG option added if yes>,
dnl		   <CFLAG option added if no>)
AC_DEFUN([ACJF_CHECK_LIB_PIP],
[dnl
AC_LANG_PUSH([C])

ACJF_CHECK_LIB_GMP

AC_ARG_WITH(piplib,
            [  --with-piplib=DIR       DIR Location of PIP],
            [ echo "Package piplib : $withval" && piplib_package=$withval],  
            [ piplib_package=yes ])

AC_SUBST(PIPLIB_INCLUDE)
AC_SUBST(PIPLIB_LDFLAGS)
AC_SUBST([PIPVERSION])
have_piplib=false
if test "$piplib_package" != "no"; then
    SAVE_CPPFLAGS="$CPPFLAGS"
    SAVE_LDFLAGS="$LDFLAGS"
    if test "$piplib_package" != "yes"; then
	PIPLIB_INCLUDE="-I$piplib_package/include $CPPFLAGS"
	PIPLIB_LDFLAGS="-L$piplib_package/lib $LDFLAGS"
    fi
    CPPFLAGS="$PIPLIB_INCLUDE $CPPFLAGS"
    LDFLAGS="$PIPLIB_LDFLAGS $LDFLAGS $EXTRA_LIBS"

    smoc_cv_piplibfatal="no"
    AC_CHECK_LIB(piplibMP, pip_solve,[
	AC_CHECK_MEMBER(PipOptions.Urs_parms,
        [PIPVERSION=136], [
	    AC_MSG_WARN([Piplib too old; please install version 1.3.6 or newer])
	    smoc_cv_piplibfatal="yes"
	],[#include <stdio.h>
	   #include <piplib/piplibMP.h>])
    ],[
	AC_MSG_WARN([Piplib not found])
	smoc_cv_piplibfatal="yes"
    ])
    if test "$smoc_cv_piplibfatal" = "no"; then
	have_piplib=true
    fi
    CPPFLAGS="$SAVE_CPPFLAGS"
    LDFLAGS="$SAVE_LDFLAGS"
fi
if test $have_piplib = no; then
  AC_MSG_ERROR([cannot find PIP library, bailing out])
fi

AC_LANG_POP
])
