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

dnl dnl ACJF_PROG_PYTHON(
dnl dnl  [<tags>,]
dnl dnl  [<code if found, default does nothing>,
dnl dnl  [<code if not found, default is bailout>]])
dnl dnl
dnl dnl tags
dnl dnl   version:xxx at least version xxx of python is required
dnl dnl
dnl dnl If python found define:
dnl dnl   PYTHON  path to python interpreter
dnl AC_DEFUN([ACJF_PROG_PYTHON], [ACJF_CHECK_HELPER_SET_VARS([$@], [
dnl   AC_ARG_WITH([python],
dnl     AS_HELP_STRING(
dnl      [[--with-python]],
dnl      m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
dnl       [[Path to python interpreter]],
dnl       [[Path to python interpreter, no to disable]])),
dnl    [[acjf_with_prog_python="$withval"]])dnl
dnl   m4_pushdef([ACJF_VAR_VERSION], [])dnl
dnl   ACJF_M4_FOREACH([ACJF_VAR_TAG], ACJF_VAR_TAGS,
dnl    [dnl set ACJF_VAR_VERSION from version:xxx tag
dnl     m4_if(m4_bregexp(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<version:]), [0],
dnl      [m4_define([ACJF_VAR_VERSION], m4_bpatsubst(ACJF_M4_UNQUOTE(ACJF_VAR_TAG), [\<version:\(.*\)], [[\1]]))dnl
dnl    ])])dnl
dnl   if test x"${acjf_python_found+set}" != x"set"; then
dnl     if test x"$acjf_with_prog_python" != x"no"; then
dnl       if test x"$acjf_with_prog_python" != x"yes"; then
dnl         PYTHON="$acjf_with_prog_python"
dnl       fi
dnl       AM_PATH_PYTHON(ACJF_VAR_VERSION,
dnl        [acjf_python_found="yes";],
dnl        [acjf_python_found="no";])dnl
dnl     else
dnl        acjf_python_found="no"
dnl     fi
dnl     if test x"$acjf_python_found" = x"no"; then
dnl       unset PYTHON
dnl     fi
dnl   fi
dnl   m4_popdef([ACJF_VAR_VERSION])dnl
dnl   m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
dnl    [if test x"$acjf_python_found" = x"no"; then
dnl       AC_MSG_ERROR([No suitable Python interpreter found, bailing out!])
dnl     fi
dnl    ],
dnl    [if test x"$acjf_python_found" != x"no"; then
dnl       m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
dnl        [true;],
dnl        [dnl echo "ACJF_VAR_CODE_IF_TRUE";
dnl         ACJF_VAR_CODE_IF_TRUE])
dnl     else
dnl       m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
dnl        [true;],
dnl        [dnl echo "ACJF_VAR_CODE_IF_FALSE";
dnl         ACJF_VAR_CODE_IF_FALSE])
dnl     fi
dnl    ])
dnl ])])

dnl ACJF_CHECK_PYTHON(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl check for python library
AC_DEFUN([ACJF_CHECK_PYTHON], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_ARG_WITH([python],
    AS_HELP_STRING(
     [[--with-python]],
     m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
      [[Path to python-config file]],
      [[Path to python-config file, no to disable]])),
   [[acjf_with_python="$withval"]])dnl
  ACJF_SEARCHLOC_CLEAR([python])
  case "$acjf_with_python" in
    [""|yes])
      ACJF_SEARCHLOC_ADD_CONFIGSCRIPT([python], [python-config])
      m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [],
       [ACJF_SEARCHLOC_ADD_DISABLED([python])])
      ;;
    [python*-config|*[/\\]python*-config])
      ACJF_SEARCHLOC_ADD_CONFIGSCRIPT([python], [$acjf_with_python])
      ;;
    no)
      ACJF_SEARCHLOC_ADD_DISABLED([python])
      ;;
    *)
      AC_MSG_ERROR([Cannot parse option $acjf_with_python given to --with-python-config option, bailing out!])
      ;;
  esac


  dnl  dnl A better way of doing this rather than grepping through the Makefile would
  dnl  dnl be to use distutils.sysconfig, but this module isn't available in older
  dnl  dnl versions of Python.
  dnl  AC_MSG_CHECKING([for Python linkage])
  dnl  py_prefix=`$PYTHON -c 'import sys; print sys.prefix'`
  dnl  py_exec_prefix=`$PYTHON -c 'import sys; print sys.exec_prefix'`
  dnl  py_libdir="$py_prefix/lib/python$PYTHON_VERSION"
  dnl  py_exec_libdir="$py_exec_prefix/lib/python$PYTHON_VERSION"
  dnl  PYTHON_LDFLAGS="-L$py_exec_prefix/lib -L$py_exec_libdir/config"
  dnl  PYTHON_INCLUDE="-I$py_exec_prefix/include/python$PYTHON_VERSION -I$py_prefix/include/python$PYTHON_VERSION"
  dnl  py_linkage=""
  dnl  for py_linkpart in LIBS LIBC LIBM LOCALMODLIBS BASEMODLIBS \
  dnl                     LINKFORSHARED LDFLAGS ; do
  dnl      py_linkage="$py_linkage "`grep "^${py_linkpart}=" \
  dnl                                     $py_exec_libdir/config/Makefile \
  dnl                                | sed -e 's/^.*=//'`
  dnl  done
  dnl  PYTHON_LIBS="-lpython$PYTHON_VERSION $py_linkage"
  dnl  PYTHON_LIBS=`echo $PYTHON_LIBS | sed -e 's/[ \\t]*/ /g'`
  dnl
  dnl  LD_LIBRARY_PATH=$acjf_old_LD_LIBRARY_PATH
  dnl
  dnl  AC_MSG_RESULT([$py_libdir])
  dnl  AC_SUBST([PYTHON])
  dnl  AC_SUBST([PYTHON_LDFLAGS])
  dnl  AC_SUBST([PYTHON_INCLUDE])
  dnl  AC_SUBST([PYTHON_LIBS])
  dnl  dnl PYTHON_INCLUDES is backward compatibility cruft
  dnl  PYTHON_INCLUDES="$PYTHON_INCLUDE"
  dnl  AC_SUBST([PYTHON_INCLUDES])

  ACJF_CHECK_LIB_TESTER([python], [[configscript:python-config]],
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
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
     ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
])])
