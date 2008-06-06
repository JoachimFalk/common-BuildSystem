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
AC_DEFUN([ACJF_CHECK_LIB_GMP],
[dnl
AC_LANG_PUSH([C])

AC_ARG_WITH(gmp,
        [  --with-gmp=DIR          DIR where the gmp package is installed],
	[ echo "Package gmp : $withval" &&
	  gmp_package=$withval &&
          GMP_INC=$gmp_package/include &&
          GMP_LIB=$gmp_package/lib &&
          NEED_MP="yes"])

AC_ARG_WITH(gmp_include,
        [  --with-gmp-include=DIR  DIR where gmp.h is installed],
	[ echo "Package gmp-include : $withval" &&
	  gmp_include_package=$withval &&
          GMP_INC=$gmp_include_package &&
	  NEED_MP="yes"])

AC_ARG_WITH(gmp_library,
        [  --with-gmp-library=DIR  DIR where the gmp library is installed],
	[ echo "Package gmp-library : $withval" &&
	  gmp_library_package=$withval &&
          GMP_LIB=$gmp_library_package &&
	  NEED_MP="yes"])

dnl /**************************************************************************
dnl  *                            Where is GMP?                               *
dnl  **************************************************************************/


dnl Checking for gmp
AC_MSG_CHECKING(whether gmp works)
if test "$gmp_package" = "no"; then
  echo "GMP package not defined"
  AC_MSG_RESULT(no)
#  TO_BUILD_MP=""
else
  if test "$NEED_MP" = "no"; then
    echo "Mode normal GMP"
#    TO_BUILD="$TO_BUILD MP"
    AC_CHECK_HEADER(gmp.h,
                    [AC_CHECK_LIB(gmp,
		                  __gmpz_init,
		                  [EXTRA_LIBS="$EXTRA_LIBS -lgmp"],
				  [echo "Can't find gmp library." &&
				   echo "MP version will not be builded." &&
				   TO_BUILD_MP=""])],
		    [echo "Can't find gmp headers." &&
		     echo "MP version will not be builded." &&
		     TO_BUILD_MP=""])
  else
    dnl Default given by --with-X is "yes", --without-X is "no".
    if test "$gmp_package" != "yes" ; then
      echo "(GMP path has been set by user)"
      GMP_DIR=$gmp_package
      GMP_LIB=$GMP_DIR/lib
      GMP_INC=$GMP_DIR/include
      EXTRA_INC="-I$GMP_INC"
      EXTRA_LIBS="$EXTRA_LIBS -L$GMP_LIB"
      dnl Useful for AC_CHECK_X to find what we want.
      CPPFLAGS="-I$GMP_DIR/include $CPPFLAGS"
      LDFLAGS="-L$GMP_DIR/lib $LDFLAGS"
    fi
    
    if test "$gmp_include_package" != "yes" ; then
      CPPFLAGS="-I$GMP_DIR/include $CPPFLAGS"
      EXTRA_INC="-I$GMP_INC"
    fi
    
    if test "$gmp_library_package" != "yes" ; then
      EXTRA_LIBS="$EXTRA_LIBS -L$GMP_LIB"
      LDFLAGS="-L$GMP_DIR/lib $LDFLAGS"
    fi
     
    AC_CHECK_HEADER(gmp.h,
                    [],
                    [AC_MSG_ERROR(Can't find gmp headers.)])
    AC_CHECK_LIB(gmp,
                 __gmpz_init,
                 [EXTRA_LIBS="$EXTRA_LIBS -lgmp"],
                 [AC_MSG_ERROR(Can't find gmp library.)])
    
    AC_MSG_RESULT(yes)
  fi
fi

AC_LANG_POP
])
