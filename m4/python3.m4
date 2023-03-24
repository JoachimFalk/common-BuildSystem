dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2023 FAU -- Joachim Falk <joachim.falk@fau.de>
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

dnl ACJF_CHECK_PYTHON3(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl check for python3 library
AC_DEFUN([ACJF_CHECK_PYTHON3], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_ARG_WITH([python3],
    AS_HELP_STRING(
     [[--with-python3]],
     m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [],
      [[Path to python3-config file]],
      [[Path to python3-config file, no to disable]])),
   [[acjf_with_python="$withval"]])dnl
  ACJF_SEARCHLOC_CLEAR([python3])
  case "$acjf_with_python3" in
    [""|yes])
      ACJF_SEARCHLOC_ADD_CONFIGSCRIPT([python3], [python3-config --embed])
      m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [],
       [ACJF_SEARCHLOC_ADD_DISABLED([python3])])
      ;;
    [python3*-config|*[/\\]python3*-config])
      ACJF_SEARCHLOC_ADD_CONFIGSCRIPT([python3], [$acjf_with_python --embed])
      ;;
    no)
      ACJF_SEARCHLOC_ADD_DISABLED([python3])
      ;;
    *)
      AC_MSG_ERROR([Cannot parse option $acjf_with_python3 given to --with-python3 option, bailing out!])
      ;;
  esac

  ACJF_CHECK_LIB_TESTER([python3], ACJF_VAR_TAGS,
    ACJF_PKG_TESTMACROGEN_COMPILE_OR_LINK_CHECK(
     [
#define PY_SSIZE_T_CLEAN
#include <Python.h>

static int numargs=0;

/* Return the number of arguments of the application command line */
static PyObject*
emb_numargs(PyObject *self, PyObject *args)
{
    if(!PyArg_ParseTuple(args, ":numargs"))
        return NULL;
    return PyLong_FromLong(numargs);
}

static PyMethodDef EmbMethods[] = {
    {"numargs", emb_numargs, METH_VARARGS,
     "Return the number of arguments received by the process."},
    {NULL, NULL, 0, NULL}
};

static PyModuleDef EmbModule = {
    PyModuleDef_HEAD_INIT, "emb", NULL, -1, EmbMethods,
    NULL, NULL, NULL, NULL
};

static PyObject*
PyInit_emb(void)
{
    return PyModule_Create(&EmbModule);
}
     ],
     [
  int argc = 3;
  const char *argv[] = { "flup", "emb", "numargs", NULL };

  if (argc < 3) {
    fprintf(stderr,"Usage: call pythonfile funcname [args]\n");
    return 1;
  }

  wchar_t *program = Py_DecodeLocale(argv[0], NULL);
  if (program == NULL) {
    fprintf(stderr, "Fatal error: cannot decode argv[0]\n");
    exit(1);
  }
  Py_SetProgramName(program);  /* optional but recommended */

  numargs = argc;
  PyImport_AppendInittab("emb", &PyInit_emb);

  Py_Initialize();

  PyRun_SimpleString("from time import time,ctime\n"
                     "print('Today is', ctime(time()))\n");
  PyRun_SimpleString("from emb import numargs\n"
                     "print('Number of command line arguments:', numargs())\n");
  PyObject *pName = PyUnicode_DecodeFSDefault(argv[1]);
  /* Error checking of pName left out */
  PyObject *pModule = PyImport_Import(pName);
  Py_DECREF(pName);

  if (pModule != NULL) {
    PyObject *pFunc = PyObject_GetAttrString(pModule, argv[2]);
    /* pFunc is a new reference */

    if (pFunc && PyCallable_Check(pFunc)) {
      PyObject *pArgs = PyTuple_New(argc - 3);
      for (int i = 0; i < argc - 3; ++i) {
        PyObject *pValue = PyLong_FromLong(atoi(argv[i + 3]));
        if (!pValue) {
          Py_DECREF(pArgs);
          Py_DECREF(pModule);
          fprintf(stderr, "Cannot convert argument\n");
          return 1;
        }
        /* pValue reference stolen here: */
        PyTuple_SetItem(pArgs, i, pValue);
      }
      PyObject *pValue = PyObject_CallObject(pFunc, pArgs);
      Py_DECREF(pArgs);
      if (pValue != NULL) {
        printf("Result of call: %ld\n", PyLong_AsLong(pValue));
        Py_DECREF(pValue);
      } else {
        Py_DECREF(pFunc);
        Py_DECREF(pModule);
        PyErr_Print();
        fprintf(stderr,"Call failed\n");
        return 1;
      }
    } else {
      if (PyErr_Occurred())
        PyErr_Print();
      fprintf(stderr, "Cannot find function \"%s\"\n", argv[2]);
    }
    Py_XDECREF(pFunc);
    Py_DECREF(pModule);
  } else {
    PyErr_Print();
    fprintf(stderr, "Failed to load \"%s\"\n", argv[1]);
    return 1;
  }
  if (Py_FinalizeEx() < 0) {
    return 120;
  }

  PyMem_RawFree(program);
  return 0;
     ],
     [ ]),
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
])])
