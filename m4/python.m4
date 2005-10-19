dnl Defines ACJF_PROG_PYTHON, which sets up the --with-python command line
dnl argument and also sets various flags needed for embedded Python if it is
dnl requested.

AC_DEFUN([ACJF_PROG_PYTHON],
[AC_ARG_VAR([PYTHON], [Location of Python interpretor])

acjf_old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH

AC_ARG_WITH([python],
    [AC_HELP_STRING([--with-python], [Path to python interpreter])],
    [case $withval in
    *)   PYTHON=$withval
         if test x"$LD_LIBRARY_PATH" = x; then
           LD_LIBRARY_PATH=`dirname $PYTHON`/../lib
         else
           LD_LIBRARY_PATH=`dirname $PYTHON`/../lib:$LD_LIBRARY_PATH
         fi
         ;;
    '')  ;;
    esac],
    [])

AM_PATH_PYTHON([$1])

dnl A better way of doing this rather than grepping through the Makefile would
dnl be to use distutils.sysconfig, but this module isn't available in older
dnl versions of Python.
AC_MSG_CHECKING([for Python linkage])
py_prefix=`$PYTHON -c 'import sys; print sys.prefix'`
py_libdir="$py_prefix/lib/python$PYTHON_VERSION"
PYTHON_LDFLAGS="-L$py_prefix/lib -Wl,-rpath $py_prefix/lib -L$py_libdir/config  -Wl,-rpath $py_libdir/config"
PYTHON_INCLUDES="-I$py_prefix/include/python$PYTHON_VERSION"
py_linkage=""
for py_linkpart in LIBS LIBC LIBM LOCALMODLIBS BASEMODLIBS \
                   LINKFORSHARED LDFLAGS ; do
    py_linkage="$py_linkage "`grep "^${py_linkpart}=" \
                                   $py_libdir/config/Makefile \
                              | sed -e 's/^.*=//'`
done
PYTHON_LIBS="-lpython$PYTHON_VERSION $py_linkage"
PYTHON_LIBS=`echo $PYTHON_LIBS | sed -e 's/[ \\t]*/ /g'`

LD_LIBRARY_PATH=$acjf_old_LD_LIBRARY_PATH

AC_MSG_RESULT([$py_libdir])
AC_SUBST([PYTHON])
AC_SUBST([PYTHON_LDFLAGS])
AC_SUBST([PYTHON_INCLUDES])
AC_SUBST([PYTHON_LIBS])])
