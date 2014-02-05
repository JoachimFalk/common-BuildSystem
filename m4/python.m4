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

dnl Defines ACJF_PROG_PYTHON, which sets up the --with-python command line
dnl argument and also sets various flags needed for embedded Python if it is
dnl requested.

AC_DEFUN([ACJF_PROG_PYTHON],
 [AC_ARG_VAR([PYTHON], [Location of python interpreter])
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
  py_exec_prefix=`$PYTHON -c 'import sys; print sys.exec_prefix'`
  py_libdir="$py_prefix/lib/python$PYTHON_VERSION"
  py_exec_libdir="$py_exec_prefix/lib/python$PYTHON_VERSION"
  PYTHON_LDFLAGS="-L$py_exec_prefix/lib -L$py_exec_libdir/config"
  PYTHON_INCLUDE="-I$py_exec_prefix/include/python$PYTHON_VERSION -I$py_prefix/include/python$PYTHON_VERSION"
  py_linkage=""
  for py_linkpart in LIBS LIBC LIBM LOCALMODLIBS BASEMODLIBS \
                     LINKFORSHARED LDFLAGS ; do
      py_linkage="$py_linkage "`grep "^${py_linkpart}=" \
                                     $py_exec_libdir/config/Makefile \
                                | sed -e 's/^.*=//'`
  done
  PYTHON_LIBS="-lpython$PYTHON_VERSION $py_linkage"
  PYTHON_LIBS=`echo $PYTHON_LIBS | sed -e 's/[ \\t]*/ /g'`

  LD_LIBRARY_PATH=$acjf_old_LD_LIBRARY_PATH

  AC_MSG_RESULT([$py_libdir])
  AC_SUBST([PYTHON])
  AC_SUBST([PYTHON_LDFLAGS])
  AC_SUBST([PYTHON_INCLUDE])
  AC_SUBST([PYTHON_LIBS])
  dnl PYTHON_INCLUDES is backward compatibility cruft
  PYTHON_INCLUDES="$PYTHON_INCLUDE"
  AC_SUBST([PYTHON_INCLUDES])
])

dnl ACJF_CHECK_PYTHON(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl check for systemc library
AC_DEFUN([ACJF_CHECK_PYTHON],
 [ACJF_SEARCHLOC_ADD_CONFIGSCRIPT([python], [python2.7-config])
  ACJF_CHECK_LIB_TESTER([python], [], ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
    [
#include <Python.h>

static PyObject *FooError;

static PyObject *
foo_system(PyObject *self, PyObject *args) {
  const char *command;
  int sts;

  if (!PyArg_ParseTuple(args, "s", &command)) {
    PyErr_SetString(FooError, "Need a string argument");
    return NULL;
  }
  sts = system(command);
  if (sts < 0) {
    PyErr_SetFromErrno(PyExc_OSError);
    return NULL;
  } else if (sts > 0) {
    PyErr_SetString(FooError, "System command failed");
    return NULL;
  }
  return Py_BuildValue("i", sts);
}

static PyMethodDef FooMethods[] = {
  {"system",  foo_system, METH_VARARGS, "Execute a shell command."},
  {NULL, NULL, 0, NULL} /* Sentinel */
};

PyMODINIT_FUNC
initfoo(void) {
  PyObject *m;

  m = Py_InitModule("foo", FooMethods);
  if (m == NULL)
      return;

  FooError = PyErr_NewException("foo.error", NULL, NULL);
  Py_INCREF(FooError);
  PyModule_AddObject(m, "error", FooError);
}
    ],
    [
Py_SetProgramName("flup");

/* Initialize the Python interpreter.  Required. */
Py_Initialize();

/* Add a static module */
initfoo();
    ],
    []),
    [$1], [$2])dnl
])
