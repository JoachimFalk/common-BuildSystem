m4_changequote([,])
m4_define([m4_if],m4_defn([m4_ifelse]))
m4_define([m4_bregexp],m4_defn([m4_regexp]))
m4_define([m4_bpatsubst],m4_defn([m4_patsubst]))
m4_define([dnl],m4_defn([m4_dnl]))
m4_define([AC_DEFUN],m4_defn([m4_define]))

m4_define([a],[unquoted_a])
m4_define([b],[unquoted_b])
m4_define([c],[unquoted_c])
m4_define([d],[unquoted_d])

m4_include([jfsugar.m4])


