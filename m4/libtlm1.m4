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

dnl ACJF_CHECK_LIB_TLM1 check for tlm1 library (has only headers)
dnl ACJF_CHECK_LIB_TLM1(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_TLM1],
[dnl
AC_LANG_PUSH([C++])

ACJF_CHECK_LIB_SYSTEMC(
 [acjf_found_pkg_tlm1="";],
 [acjf_found_pkg_tlm1="no";])
if test x"$acjf_found_pkg_tlm1" = x"no"; then
  m4_if([$2], [], [AC_MSG_ERROR([Cannot find systemc library required by tlm, bailing out!])], [true;])
fi

acjf_libtlm1_CPPFLAGS="$CPPFLAGS"; CPPFLAGS="$CPPFLAGS $SYSTEMC_INCLUDE"
acjf_libtlm1_LDFLAGS="$LDFLAGS"; LDFLAGS="$LDFLAGS $SYSTEMC_LDFLAGS"

ACJF_CHECK_LIB(
  [tlm1],
  [],
  [
#include <tlm.h>
#include <systemc.h>
#include <assert.h>
#define  main _main

int sc_main(int argc, char *argv[]) { return 0; }],
  [
SC_MODULE(foo) {
public:
  sc_port<tlm::tlm_put_if<int> > output;
  sc_port<tlm::tlm_get_if<int> > input;
public:
  SC_CTOR(foo) {
    SC_THREAD(copy);
  }
protected:
  void copy() {
    while (true) {
      if (input->nb_can_get() && output->nb_can_put()) {
        bool success;
        int val;

        success = input->nb_get(val); assert(success);
        success = output->nb_put(val); assert(success);
        input->get(val);
        output->put(val);
        output->put(input->get());
      }
      wait(sc_time(10,SC_NS));
    }
  }
} bar("bar")
  ],
  [systemc],
  [$1], [$2])

CPPFLAGS="$acjf_libtlm1_CPPFLAGS"; unset acjf_libtlm1_CPPFLAGS
LDFLAGS="$acjf_libtlm1_LDFLAGS"; unset acjf_libtlm1_LDFLAGS
AC_LANG_POP

if test x"$acjf_found_pkg_tlm1" = x"yes"; then
  TLM1_INCLUDE="$TLM1_INCLUDE $SYSTEMC_INCLUDE"
  TLM1_LDFLAGS="$TLM1_LDFLAGS $SYSTEMC_LDFALGS"
fi
])
