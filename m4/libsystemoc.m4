dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2011 FAU -- Martin Streubuehr <martin.streubuehr@fau.de>
dnl   2012 FAU -- Rafael Rosales <rafael.rosales@fau.de>
dnl   2013 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 Joachim Falk <joachim.falk@gmx.de>
dnl   2016 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2016 Jonathan Ah Sue <jonathan.ah.sue@intel.com>
dnl   2018 FAU -- Joachim Falk <joachim.falk@fau.de>
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

dnl _ACJF_CHECK_LIB_SYSTEMOC_TESTMACRO(
dnl   <name of lib check (pkgname)>,
dnl   <shell variable prefix set by ACJF_SEARCHLOC_EVALUATE>,
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default does nothing>]])
m4_define([_ACJF_CHECK_LIB_SYSTEMOC_TESTMACRO], [
  if test [x"$2" != x"acjf_cv_systemoc"]; then
    AC_MSG_ERROR([Internal error: Hardcoded variable prefix is different from expected one!])
  fi
  m4_pushdef([ACJF_VAR_SYSTEMOC_TESTCODE], [AC_LANG_PROGRAM(
    [[
#include <iostream>

#include <systemoc/smoc_moc.hpp>

#ifndef SYSTEMOC_VERSION
# error "NO SysteMoC!"
#endif

#include <cmath>
#include <cassert>
#include <cstdlib> // for atoi

#define main sc_main

using namespace std; 

// Maximum (and default) number of Src iterations. Lower default number via
//  command line parameter.
const int NUM_MAX_ITERATIONS = 1000000;

class Src: public smoc_actor {
public:
  smoc_port_out<double> out;
private:
  int i;
  
  void src() {
    std::cout << "src: " << i << std::endl;
    out[0] = i++;
  }
  
  smoc_firing_state start;
public:
  Src(sc_core::sc_module_name name, int from)
    : smoc_actor(name, start), i(from) {
    
      SMOC_REGISTER_CPARAM(from);
      
      start =
        (SMOC_VAR(i) <= NUM_MAX_ITERATIONS) >>
        out(1)                              >>
        SMOC_CALL(Src::src)                 >> start
      ;
  }
};

// Definition of the SqrLoop actor class
class SqrLoop
  // All actor classes must be derived
  // from the smoc_actor base class
  : public smoc_actor {
public:
  // Declaration of input and output ports
  smoc_port_in<double>  i1, i2;
  smoc_port_out<double> o1, o2;
private:
  // Declaration of the actor functionality
  // via member variables and methods
  double tmp_i1;
  
  // action functions triggered by the
  // FSM declared in the constructor
  void copyStore()  { o1[0] = tmp_i1 = i1[0];  }
  void copyInput()  { o1[0] = tmp_i1;          }
  void copyApprox() { o2[0] = i2[0];           }
  
  // guard  functions used by the
  // FSM declared in the constructor
  bool check() const {
    std::cout << "check: " << tmp_i1 << ", " << i2[0] << std::endl;
    return std::fabs(tmp_i1 - i2[0]*i2[0]) < 0.0001;
  }
  
  // Declaration of firing states for the FSM
  smoc_firing_state start;
  smoc_firing_state loop;
public:
  // Constructor responsible for declaring the
  // communication FSM and initializing the actor
  SqrLoop(sc_core::sc_module_name name)
    : smoc_actor(name, start) {
    start =
        i1(1)                               	>>
        o1(1)                               	>>
        SMOC_CALL(SqrLoop::copyStore)           >> loop
      ;
    loop  =
        (i2(1) &&  SMOC_GUARD(SqrLoop::check))  >>
        o2(1)                               	>>
        SMOC_CALL(SqrLoop::copyApprox)          >> start
      | (i2(1) && !SMOC_GUARD(SqrLoop::check))  >>
        o1(1)                               	>>
        SMOC_CALL(SqrLoop::copyInput)           >> loop
      ;
  }
};

class Approx: public smoc_actor {
public:
  smoc_port_in<double>  i1, i2;
  smoc_port_out<double> o1;
private:
  // Square root successive approximation step of Newton
  void approx(void) { o1[0] = (i1[0] / i2[0] + i2[0]) / 2; }
  
  smoc_firing_state start;
public:
  Approx(sc_core::sc_module_name name)
    : smoc_actor(name, start) {
    start =
        (i1(1) && i2(1))          >>
        o1(1)                     >>
        SMOC_CALL(Approx::approx) >> start
      ;
  }
};

class Dup: public smoc_actor {
public:
  smoc_port_in<double>  i1;
  smoc_port_out<double> o1, o2;

private:
  void dup() { 
    double in = i1[0];
    o1[0] = in;
    o2[0] = in;
  }
  
  smoc_firing_state start;
public:
  Dup(sc_core::sc_module_name name)
    : smoc_actor(name, start) {
    start =
        i1(1)                    >>
        (o1(1) && o2(1))         >>
        SMOC_CALL(Dup::dup)      >> start
      ;
  }
};

class Sink: public smoc_actor {
public:
  smoc_port_in<double> in;
private:
  void sink(void) {
    std::cout << "sink: " << in[0] << std::endl;
  }
  
  smoc_firing_state start;
public:
  Sink(sc_core::sc_module_name name)
    : smoc_actor(name, start) {
    start =
        in(1)                  >>
        SMOC_CALL(Sink::sink)  >> start
      ;
  }
};

class SqrRoot
: public smoc_graph {
public:
protected:
  Src      src;
  SqrLoop  sqrloop;
  Approx   approx;
  Dup      dup;
  Sink     sink;
public:
  SqrRoot(sc_core::sc_module_name name, const int from = 1 )
    : smoc_graph(name),
      src("a1", from),
      sqrloop("a2"),
      approx("a3"),
      dup("a4"),
      sink("a5") {
    connectNodePorts(src.out,    sqrloop.i1);
    connectNodePorts(sqrloop.o1, approx.i1);
    connectNodePorts(approx.o1,  dup.i1,
                     smoc_fifo<double>(1));
    connectNodePorts(dup.o1,     approx.i2,
                     smoc_fifo<double>() << 2 );
    connectNodePorts(dup.o2,     sqrloop.i2);
    connectNodePorts(sqrloop.o2, sink.in);
  }
};
    ]],
    [[
  int         argc   = 2;
  char const *argv[] = {"simulation-sqr", "1500", NULL};
  int from = 1;
  if (argc == 2) {
    const int iterations = atoi(argv[1]);
    assert(iterations < NUM_MAX_ITERATIONS);
    from = NUM_MAX_ITERATIONS - iterations;
  }
  smoc_top_moc<SqrRoot> sqrroot("sqrroot", from);
  sc_core::sc_start();
  return 0;
    ]])])
  acjf_var_systemoc_found=""
  if test [x"${$2_type}" = x"bundled" -o \
           x"${$2_type}" = x"pkg-config-bundled"]; then
    AC_MSG_CHECKING([if $1 from ${$2_desc} can compile an example])
    AC_COMPILE_IFELSE(
      [ACJF_VAR_SYSTEMOC_TESTCODE],
      [AC_MSG_RESULT([yes]); acjf_var_systemoc_found="yes"],
      [AC_MSG_RESULT([no]);  acjf_var_systemoc_found="no"])
  else
    AC_MSG_CHECKING([if $1 from ${$2_desc} can compile and link an example])
    AC_LINK_IFELSE(
      [ACJF_VAR_SYSTEMOC_TESTCODE],
      [AC_MSG_RESULT([yes]); acjf_var_systemoc_found="yes"],
      [AC_MSG_RESULT([no]);  acjf_var_systemoc_found="no"])
  fi
  m4_popdef([ACJF_VAR_SYSTEMOC_TESTCODE])dnl
  if test x"$acjf_var_systemoc_found" = x"yes"; then
    [$2_sgx_support=""]
    [$2_enable_hooking=""]
    [$2_enable_vp=""]
    [$2_enable_maestro=""]
    # Checks for header files.
    AC_MSG_CHECKING([for hooking support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <systemoc/smoc_config.h>
      ]],
      [[
  #ifndef SYSTEMOC_ENABLE_HOOKING
  # error "NO HOOKING!"
  #endif //SYSTEMOC_ENABLE_HOOKING
      ]])],
     [AC_MSG_RESULT([yes]); $2_enable_hooking="yes";],
     [AC_MSG_RESULT([no]); $2_enable_hooking="no";])
    # Checks for header files.
    AC_MSG_CHECKING([for SGX support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <systemoc/smoc_config.h>
      ]],
      [[
  #ifndef SYSTEMOC_ENABLE_SGX
  # error "NO SGX!"
  #endif //SYSTEMOC_ENABLE_SGX
      ]])],
     [AC_MSG_RESULT([yes]); $2_sgx_support="yes";],
     [AC_MSG_RESULT([no]); $2_sgx_support="no";])
    # Checks for header files.
    AC_MSG_CHECKING([for VPC support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <systemoc/smoc_config.h>
      ]],
      [[
  #ifndef SYSTEMOC_ENABLE_VPC
  # error "NO VPC!"
  #endif //SYSTEMOC_ENABLE_VPC
      ]])],
     [AC_MSG_RESULT([yes]); $2_enable_vpc="yes";],
     [AC_MSG_RESULT([no]); $2_enable_vpc="no";])
    # Checks for header files.
    AC_MSG_CHECKING([for Maestro support in $1 package])
    AC_COMPILE_IFELSE(
     [AC_LANG_PROGRAM(
      [[
  #include <systemoc/smoc_config.h>
      ]],
      [[
  #ifndef SYSTEMOC_ENABLE_MAESTRO
  # error "NO MAESTRO SUPPORT!"
  #endif //SYSTEMOC_ENABLE_MAESTRO
      ]])],
     [AC_MSG_RESULT([yes]); $2_enable_maestro="yes";],
     [AC_MSG_RESULT([no]); $2_enable_maestro="no";])
  fi
  if test x"$acjf_var_systemoc_found" = x"yes"; then
    unset acjf_var_systemoc_found
    m4_if([$3], [], [true], [$3])
  else
    unset acjf_var_systemoc_found
    m4_if([$4], [], [false], [$4])
  fi
])

dnl ACJF_CHECK_LIB_SYSTEMOC(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl This macro defines all the stuff documented in ACJF_CHECK_LIB plus the following:
dnl   SYSTEMOC_ENABLE_SGX     yes or no depending on the configuration in <systemoc/smoc_config.h>
dnl   SYSTEMOC_ENABLE_VPC     yes or no depending on the configuration in <systemoc/smoc_config.h>
dnl   SYSTEMOC_ENABLE_MAESTRO yes or no depending on the configuration in <systemoc/smoc_config.h>
dnl   AM_CONDITIONAL SYSTEMOC_ENABLE_SGX
dnl   AM_CONDITIONAL SYSTEMOC_ENABLE_VPC
dnl   AM_CONDITIONAL SYSTEMOC_ENABLE_MAESTRO
AC_DEFUN([ACJF_CHECK_LIB_SYSTEMOC], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  ACJF_ARG_WITHPKG([SysteMoC], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libsystemoc]]))dnl
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB_TESTER([SysteMoC], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[pkgconfig:libsystemoc]]),
    [_ACJF_CHECK_LIB_SYSTEMOC_TESTMACRO],
    m4_if(ACJF_VAR_CODE_IF_TRUE[]ACJF_VAR_CODE_IF_FALSE, [], [], [[true;]]))dnl
  SYSTEMOC_ENABLE_HOOKING="$acjf_cv_systemoc_enable_hooking"
  AM_CONDITIONAL([SYSTEMOC_ENABLE_HOOKING], test x"$acjf_cv_systemoc_enable_hooking" = x"yes")
  SYSTEMOC_ENABLE_SGX="$acjf_cv_systemoc_sgx_support"
  AM_CONDITIONAL([SYSTEMOC_ENABLE_SGX], test x"$acjf_cv_systemoc_sgx_support" = x"yes")
  SYSTEMOC_ENABLE_VPC="$acjf_cv_systemoc_enable_vpc"
  AM_CONDITIONAL([SYSTEMOC_ENABLE_VPC], test x"$acjf_cv_systemoc_enable_vpc" = x"yes")
  SYSTEMOC_ENABLE_MAESTRO="$acjf_cv_systemoc_enable_maestro"
  AM_CONDITIONAL([SYSTEMOC_ENABLE_MAESTRO], test x"$acjf_cv_systemoc_enable_maestro" = x"yes")
  if test [x"${SYSTEMOC_FOUND}" = x"yes";] then
    m4_if(ACJF_VAR_CODE_IF_TRUE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_TRUE";
      ACJF_VAR_CODE_IF_TRUE])
  else
    m4_if(ACJF_VAR_CODE_IF_FALSE, [], 
     [true;],
     [dnl echo "ACJF_VAR_CODE_IF_FALSE";
      ACJF_VAR_CODE_IF_FALSE])
  fi
  AC_LANG_POP
])])
