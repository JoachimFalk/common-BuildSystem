# ACJF_CHECK_VAR(VARIABLE, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# -----------------------------------------------------------------
AC_DEFUN([ACJF_CHECK_VAR],
[AS_VAR_PUSHDEF([ac_var], [acjf_cv_var_$1])dnl
AC_CACHE_CHECK([for $1], ac_var,
[AC_TRY_LINK([int *p;], [extern int $1 []; p = $1;],
                [AS_VAR_SET(ac_var, yes)],
                [AS_VAR_SET(ac_var, no)])])
AS_IF([test AS_VAR_GET(ac_var) = yes], [$2], [$3])dnl
AS_VAR_POPDEF([ac_var])dnl
])# ACJF_CHECK_VAR

# ACJF_CHECK_VARS(VARIABLE..., [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------------------
AC_DEFUN([ACJF_CHECK_VARS],
[AC_FOREACH([AC_Var], [$1],
  [AH_TEMPLATE(AS_TR_CPP(HAVE_[]AC_Var),
               [Define to 1 if you have the ']AC_Var[' variable.])])dnl
for ac_variable in $1
do
ACJF_CHECK_VAR($ac_variable,
              [AC_DEFINE_UNQUOTED([AS_TR_CPP([HAVE_$ac_variable])]) $2],
              [$3])dnl
done
])# ACJF_CHECK_VARS
