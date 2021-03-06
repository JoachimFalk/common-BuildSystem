dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2001 - 2009 Joachim Falk <joachim.falk@gmx.de>
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2013 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 FAU -- Joachim Falk <joachim.falk@fau.de>
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

dnl
dnl Miscellaneous helper macros
dnl

m4_define([_ACJF_M4_OPENSQUAREBRACKET],
  m4_changequote(<,>)<m4_changequote(<,>)<[>m4_changequote([,])>m4_changequote([,]))dnl
m4_define([_ACJF_M4_CLOSESQUAREBRACKET],
  m4_changequote(<,>)<m4_changequote(<,>)<]>m4_changequote([,])>m4_changequote([,]))dnl
dnl ACJF_M4_NULL(<arg>)
dnl
dnl Example:
dnl   [<]ACJF_M4_NULL([what-],[ever])[>]
dnl Result:
dnl   <>
AC_DEFUN([ACJF_M4_NULL], [])dnl
dnl ACJF_M4_QUOTE(<arg>)
dnl
dnl Example:
dnl   ACJF_M4_QUOTE([foo],[bar])
dnl Result:
dnl   [foo],[bar]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_QUOTE([foo],[bar]))
dnl Result:
dnl   [[foo],[bar]]
AC_DEFUN([ACJF_M4_QUOTE], [[$@]])dnl
dnl ACJF_M4_UNQUOTE(<arg>)
dnl
dnl Example:
dnl   ACJF_M4_UNQUOTE([foo],[bar])
dnl Result:
dnl   unquoted_foo,unquoted_bar
dnl
dnl Example:
dnl   ACJF_M4_UNQUOTE([[foo]],[[bar]])
dnl Result:
dnl   foo,bar
AC_DEFUN([ACJF_M4_UNQUOTE], [$*])dnl
AC_DEFUN([ACJF_M4_FLATEN],
[m4_if($#, 0, [],
  [m4_if(m4_bregexp([$1],\_ACJF_M4_OPENSQUAREBRACKET), -1,
    [[$1]],
    [ACJF_M4_FLATEN($1)])m4_if($#, 1, [],
    [,ACJF_M4_FLATEN(m4_shift($@))])])])dnl
dnl ACJF_M4_QUOTEDARGS([code with § instead of $])
dnl
dnl Example:
dnl   ACJF_M4_QUOTEDARGS([§1 == "bar"])
dnl Result:
dnl   $1 == "bar"
AC_DEFUN([ACJF_M4_QUOTEDARGS],
[m4_bpatsubst(
    m4_bpatsubst( [[[$1]]],
      [\([^§]\)§\([0123456789#@*]\)], [\1$\2]),
  [§\(§§*\)], [\1])])dnl
dnl ACJF_M4_CODECALL( [<arg1>,<arg2>,...], <code to call>)
dnl
dnl Example:
dnl   ACJF_M4_CODECALL( [a,b,c], [[$1] && [$2] || [$3]])
dnl Result:
dnl   a && b || c
AC_DEFUN([ACJF_M4_CODECALL],
[m4_pushdef([_ACJF_M4_CODECALL_DEF],ACJF_M4_QUOTEDARGS([$2]))dnl
_ACJF_M4_CODECALL_DEF(ACJF_M4_LISTTOARGS([$1]))[]dnl
m4_popdef([_ACJF_M4_CODECALL_DEF])])dnl
dnl ACJF_M4_ONCECODE( <protection m4_define>, <code> )
AC_DEFUN([ACJF_M4_ONCECODE],
[m4_ifdef([__oncecode__$1],
  [],
  [m4_define([__oncecode__$1], [Yes])$2])])dnl
dnl
dnl Macros for operations on args
dnl
AC_DEFUN([ACJF_M4_ARG_HEAD], [[$1]])dnl
AC_DEFUN([ACJF_M4_ARG_SIZE], [$#])dnl
AC_DEFUN([ACJF_M4_ARG_REVERSE],
[m4_if($#, 0, [], $#, 1, [[$1]],
  [ACJF_M4_ARG_REVERSE(m4_shift($@)),[$1]])])dnl
dnl
dnl Macros for operations on lists
dnl
dnl Helper function for ACJF_M4_LISTTOARGS don't call directly
m4_define([_ACJF_M4_LISTTOARGS],
[m4_if($#, 0, [],
  [m4_bpatsubst(
    [[$1]],
    \_ACJF_M4_CLOSESQUAREBRACKET[,]\_ACJF_M4_OPENSQUAREBRACKET,
    [,])m4_if($#, 1, [], [,_ACJF_M4_LISTTOARGS(m4_shift($@))])])dnl
])dnl
dnl ACJF_M4_LISTTOARGS([<item1>,<item2>,...])
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LISTTOARGS([a,b,c]))
dnl Result:
dnl   [a],[b],[c]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LISTTOARGS([a,[b,[c,d]],[e],[f],g,h]))
dnl Result:
dnl   [a],[[b,[c,d]]],[[e]],[[f]],[g],[h]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LISTTOARGS([a,[b,[c,d]]]))
dnl Result:
dnl   [a],[[b,[c,d]]]
AC_DEFUN([ACJF_M4_LISTTOARGS],
[_ACJF_M4_LISTTOARGS(
  m4_bpatsubst(
    [[$1]],
    [,],
    _ACJF_M4_CLOSESQUAREBRACKET[,]_ACJF_M4_OPENSQUAREBRACKET))])dnl
dnl ACJF_M4_ARGSTOLIST([<item1>],[<item2>],...)
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_ARGSTOLIST([foo],[bar],[a],[b]))
dnl Result:
dnl   [foo,bar,a,b]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_ARGSTOLIST([foo],[bar],[foo,bar]))
dnl Result:
dnl   [foo,bar,foo,bar]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_ARGSTOLIST(ACJF_M4_QUOTE([foo],[bar],[foo,bar])))
dnl Result:
dnl   [[foo],[bar],[foo,bar]]
dnl
AC_DEFUN([ACJF_M4_ARGSTOLIST], [[$*]])dnl
dnl ACJF_M4_LIST_SIZE([<item1>,<item2>,...])
dnl
dnl Example:
dnl   ACJF_M4_LIST_SIZE([a,b,c,d,ef,g,h])
dnl Result:
dnl   7
dnl
dnl Example:
dnl   ACJF_M4_LIST_SIZE([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   6
AC_DEFUN([ACJF_M4_LIST_SIZE],
[ACJF_M4_ARG_SIZE(ACJF_M4_LISTTOARGS([$1]))])dnl
dnl ACJF_M4_LIST_HEAD([<item1>,<item2>,...])
dnl
dnl Example:
dnl   ACJF_M4_LIST_HEAD([a,b,c,d,ef,g,h])
dnl Result:
dnl   a
dnl
dnl Example:
dnl   ACJF_M4_LIST_HEAD([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   a
dnl
dnl Example:
dnl   ACJF_M4_LIST_HEAD([[b,[c,d]],a])
dnl Result:
dnl   [b,[c,d]]
AC_DEFUN([ACJF_M4_LIST_HEAD],
[ACJF_M4_ARG_HEAD(ACJF_M4_LISTTOARGS([$1]))])dnl
dnl ACJF_M4_LIST_TAIL([<item1>,<item2>,...])
dnl
dnl Example:
dnl   ACJF_M4_LIST_TAIL([a,b,c,d,ef,g,h])
dnl Result:
dnl   b,c,d,ef,g,h
dnl
dnl Example:
dnl   ACJF_M4_LIST_TAIL([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   [b,[c,d]],[e],[f],g,h
dnl
dnl Example:
dnl   ACJF_M4_LIST_TAIL([[a,[b,[c,d]]],[e],[f],g,h])
dnl Result:
dnl   [e],[f],g,h
AC_DEFUN([ACJF_M4_LIST_TAIL],
[ACJF_M4_ARGSTOLIST(m4_shift(ACJF_M4_LISTTOARGS([$1])))])dnl
dnl ACJF_M4_LIST_REVERSE([<item1>,<item2>,...])
dnl Example:
dnl   ACJF_M4_LIST_REVERSE([a,b,c,d,ef,g,h])
dnl Result:
dnl   h,g,ef,d,c,b,a
dnl
dnl Example:
dnl   ACJF_M4_LIST_REVERSE([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   h,g,[f],[e],[b,[c,d]],a
AC_DEFUN([ACJF_M4_LIST_REVERSE],
[ACJF_M4_ARGSTOLIST(ACJF_M4_ARG_REVERSE(ACJF_M4_LISTTOARGS([$1])))])dnl
dnl ACJF_M4_LIST_FRONT([<item1>,<item2>,...])
dnl Example:
dnl   ACJF_M4_LIST_FRONT([a,b,c,d,ef,g,h])
dnl Result:
dnl   a
dnl
dnl Example:
dnl   ACJF_M4_LIST_FRONT([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   a
dnl
dnl Example:
dnl   ACJF_M4_LIST_FRONT([[b,[c,d]],a])
dnl Result:
dnl   [b,[c,d]]
AC_DEFUN([ACJF_M4_LIST_FRONT], m4_defn([ACJF_M4_LIST_HEAD]))dnl
dnl ACJF_M4_LIST_POP_FRONT([<item1>,<item2>,...])
dnl Example:
dnl   ACJF_M4_LIST_POP_FRONT([a,b,c,d,ef,g,h])
dnl Result:
dnl   b,c,d,ef,g,h
dnl
dnl Example:
dnl   ACJF_M4_LIST_POP_FRONT([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   [b,[c,d]],[e],[f],g,h
AC_DEFUN([ACJF_M4_LIST_POP_FRONT], m4_defn([ACJF_M4_LIST_TAIL]))dnl
dnl ACJF_M4_LIST_PUSH_FRONT( [<new_item>], [<item1>,<item2>,...] )
dnl Example:
dnl   ACJF_M4_LIST_PUSH_FRONT([a],[b,c,d,e,f])
dnl Result:
dnl   a,b,c,d,e,f
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_FRONT([],[]))
dnl Result:
dnl   []
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_FRONT([a],[]))
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_FRONT([],[a]))
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_FRONT([x,[y,z]], [a,[b,[c,d]],[e],[f],g,h]))
dnl Result:
dnl   [x,[y,z],a,[b,[c,d]],[e],[f],g,h]
AC_DEFUN([ACJF_M4_LIST_PUSH_FRONT],
 [m4_if([$1], [], [[$2]],
   [m4_if([$2], [], [[$1]], [[$1,$2]])])])dnl
dnl ACJF_M4_LIST_BACK([<item1>,<item2>,...])
dnl Example:
dnl   ACJF_M4_LIST_BACK([a,b,c,d,ef,g,h])
dnl Result:
dnl   h
dnl
dnl Example:
dnl   ACJF_M4_LIST_BACK([a,[b,[c,d]]])
dnl Result:
dnl   [b,[c,d]]
AC_DEFUN([ACJF_M4_LIST_BACK],
[ACJF_M4_LIST_FRONT(ACJF_M4_LIST_REVERSE([$1]))])dnl
dnl ACJF_M4_LIST_POP_BACK([<item1>,<item2>,...])
dnl Example:
dnl   ACJF_M4_LIST_POP_BACK([a,b,c,d,ef,g,h])
dnl Result:
dnl   a,b,c,d,ef,g
dnl
dnl Example:
dnl   ACJF_M4_LIST_POP_BACK([a,[b,[c,d]],[e],[f],g,h])
dnl Result:
dnl   a,[b,[c,d]],[e],[f],g
AC_DEFUN([ACJF_M4_LIST_POP_BACK],
[ACJF_M4_LIST_REVERSE(ACJF_M4_LIST_POP_FRONT(ACJF_M4_LIST_REVERSE([$1])))])dnl
dnl ACJF_M4_LIST_PUSH_BACK( [<new_item>], [<item1>,<item2>,...] )
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([a],[b,c,d,e,f]))
dnl Result:
dnl   [b,c,d,e,f,a]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([],[]))
dnl Result:
dnl   []
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([a],[]))
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([],[a]))
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([x,[y,z]], [a,[b,[c,d]],[e],[f],g,h]))
dnl Result:
dnl   [a,[b,[c,d]],[e],[f],g,h,x,[y,z]]
AC_DEFUN([ACJF_M4_LIST_PUSH_BACK], [ACJF_M4_LIST_PUSH_FRONT([$2],[$1])])dnl
dnl ACJF_M4_LIST_TOP( [<item1>,<item2>,...], <how many>)
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_LIST_TOP([a,b,c,d,ef,g,h],3))
dnl Result:
dnl   [a,b,c]
dnl
dnl Example:
dnl   ACJF_M4_LIST_TOP([a,[b,[c,d]],[e],[f],g,h], 2)
dnl Result:
dnl   a,[b,[c,d]]
AC_DEFUN([ACJF_M4_LIST_TOP],
[m4_if([$2], 0,
  [[]],
  [ACJF_M4_LIST_PUSH_FRONT(
    ACJF_M4_LIST_HEAD([$1]),
    ACJF_M4_LIST_TOP(ACJF_M4_LIST_TAIL([$1]),m4_decr([$2])))]dnl
)])dnl
dnl ACJF_M4_LIST_ELEM( [<item1>,<item2>,...], <index into list>)
dnl Example:
dnl   ACJF_M4_LIST_ELEM( [a,b,c,d,ef,g,h], 2)
dnl Result:
dnl   c
dnl
dnl Example:
dnl   ACJF_M4_LIST_ELEM([a,[b,[c,d]],[e],[f],g,h], 1)
dnl Result:
dnl   [b,[c,d]]
AC_DEFUN([ACJF_M4_LIST_ELEM],
[m4_if([$2], 0,
  [ACJF_M4_LIST_HEAD([$1])],
  [ACJF_M4_LIST_ELEM(ACJF_M4_LIST_TAIL([$1]),m4_decr([$2]))]dnl
)])dnl
dnl ACJF_M4_LIST_HASELEM( [list], [element], <code if yes>, <code if no> )
dnl
dnl Example:
dnl   ACJF_M4_LIST_HASELEM([a,b,a,c], [a], [yes], [no])
dnl Result:
dnl   unquoted_yes
dnl
dnl Example:
dnl   ACJF_M4_LIST_HASELEM([a,b,a,c], [x], [yes], [no])
dnl Result:
dnl   unquoted_no
dnl
dnl Example:
dnl   ACJF_M4_LIST_HASELEM([a, b,a,c], [b], [yes], [no])
dnl Result:
dnl   unquoted_no
dnl
dnl Example:
dnl   ACJF_M4_LIST_HASELEM([a,[b,[c,d]],[e],[f],g,h], [[b,[c,d]]], [yes], [no])
dnl Result:
dnl   unquoted_yes
AC_DEFUN([ACJF_M4_LIST_HASELEM],
[m4_if([$1], [],
  [$4],
  [m4_if(ACJF_M4_LIST_HEAD([$1]),[$2],
    [$3],
    [ACJF_M4_LIST_HASELEM(ACJF_M4_LIST_TAIL([$1]), [$2], [$3], [$4])])])[]dnl
])dnl
dnl
dnl Macros for operations on list variables.
dnl
dnl ACJF_M4_LISTVAR_REVERSE([<listvar>])
dnl Example:
dnl   m4_pushdef([listvar], [[a,b,c,d,ef,g,h]])dnl
dnl   ACJF_M4_LISTVAR_REVERSE([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   h,g,ef,d,c,b,a
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a,[b,[c,d]],[e],[f],g,h]])dnl
dnl   ACJF_M4_LISTVAR_REVERSE([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   h,g,[f],[e],[b,[c,d]],a
AC_DEFUN([ACJF_M4_LISTVAR_REVERSE], [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_REVERSE($1)))])dnl
dnl ACJF_M4_LISTVAR_POP_FRONT([<listvar>])
dnl Example:
dnl   m4_pushdef([listvar], [[a,[b,[c,d]],[e],[f],g,h]])dnl
dnl   ACJF_M4_LISTVAR_POP_FRONT([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [b,[c,d]],[e],[f],g,h
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[[b,[c,d]],a]])dnl
dnl   ACJF_M4_LISTVAR_POP_FRONT([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   a
AC_DEFUN([ACJF_M4_LISTVAR_POP_FRONT], [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_POP_FRONT($1)))])dnl
dnl ACJF_M4_LISTVAR_PUSH_FRONT([<listvar>], [<new_item>])
dnl Example:
dnl   m4_pushdef([listvar], [[b,c,d,e,f]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_FRONT([listvar], [a])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   a,b,c,d,e,f
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_FRONT([listvar], [])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   []
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_FRONT([listvar], [a])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_FRONT([listvar], [])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a,[b,[c,d]],[e],[f],g,h]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_FRONT([listvar], [x,[y,z]])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [x,[y,z],a,[b,[c,d]],[e],[f],g,h]
AC_DEFUN([ACJF_M4_LISTVAR_PUSH_FRONT], [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_FRONT([$2],$1)))])dnl
dnl ACJF_M4_LISTVAR_POP_BACK([<item1>,<item2>,...])
dnl Example:
dnl   m4_pushdef([listvar], [[a,b,c,d,ef,g,h]])dnl
dnl   ACJF_M4_LISTVAR_POP_BACK([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   a,b,c,d,ef,g
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a,[b,[c,d]],[e],[f],g,h]])dnl
dnl   ACJF_M4_LISTVAR_POP_BACK([listvar])dnl
dnl   listvar
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   a,[b,[c,d]],[e],[f],g
AC_DEFUN([ACJF_M4_LISTVAR_POP_BACK], [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_POP_BACK($1)))])dnl
dnl ACJF_M4_LISTVAR_PUSH_BACK([<listvar>], [<new_item>])
dnl Example:
dnl   m4_pushdef([listvar], [[b,c,d,e,f]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_BACK([listvar], [a])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [b,c,d,e,f,a]
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_BACK([listvar], [])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   []
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_BACK([listvar], [a])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_BACK([listvar], [])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [a]
dnl
dnl Example:
dnl   m4_pushdef([listvar], [[a,[b,[c,d]],[e],[f],g,h]])dnl
dnl   ACJF_M4_LISTVAR_PUSH_BACK([listvar], [x,[y,z]])dnl
dnl   ACJF_M4_QUOTE(listvar)
dnl   m4_popdef([listvar])dnl
dnl Result:
dnl   [a,[b,[c,d]],[e],[f],g,h,x,[y,z]]
AC_DEFUN([ACJF_M4_LISTVAR_PUSH_BACK], [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_PUSH_BACK([$2],$1)))])dnl
dnl
dnl Macros for looping constructs
dnl
dnl ACJF_M4_WHILE(<test code>, <code while body>)
dnl Example:
dnl   m4_pushdef([i],10)dnl
dnl   ACJF_M4_WHILE([m4_eval(i >= 1)],
dnl     [Loop is now "i".
dnl      m4_define([i],m4_eval(i - 1))[]dnl
dnl   ])dnl
dnl   m4_popdef([i])dnl
dnl Result:
dnl   Loop is now "10".
dnl   Loop is now "9".
dnl   Loop is now "8".
dnl   Loop is now "7".
dnl   Loop is now "6".
dnl   Loop is now "5".
dnl   Loop is now "4".
dnl   Loop is now "3".
dnl   Loop is now "2".
dnl   Loop is now "1".
AC_DEFUN([ACJF_M4_WHILE],
[m4_if($1, [1],
  [$2[]ACJF_M4_WHILE([$1],[$2])],
  [])[]dnl
])dnl
dnl OBSOLETE FOREACH USAGE: 
dnl
dnl ACJF_M4_FOREACH( [<item1>,<item2>,...], <code to iterate>)
dnl Example:
dnl   ACJF_M4_FOREACH( [a,b,c,d,ef,g,h],
dnl     [Loop is now "[$1]".
dnl   ])dnl
dnl Result:
dnl   Loop is now "a".
dnl   Loop is now "b".
dnl   Loop is now "c".
dnl   Loop is now "d".
dnl   Loop is now "ef".
dnl   Loop is now "g".
dnl   Loop is now "h".
dnl
dnl Example:
dnl   ACJF_M4_FOREACH([a,[b,[c,d]],[e],[f],g,h],
dnl     [Loop is now "[$1]".
dnl   ])dnl
dnl Result:
dnl   Loop is now "a".
dnl   Loop is now "[b,[c,d]]".
dnl   Loop is now "[e]".
dnl   Loop is now "[f]".
dnl   Loop is now "g".
dnl   Loop is now "h".
dnl
dnl NEW FOREACH USAGE: 
dnl
dnl ACJF_M4_FOREACH( [var], [<item1>,<item2>,...], <code to iterate>)
dnl Example:
dnl   ACJF_M4_FOREACH([ii], [a,b,c],
dnl    [ACJF_M4_FOREACH([jj], [d,e,f],
dnl      [Loop is now "ii:jj".]
dnl     )])dnl
dnl Result:
dnl   Loop is now "a:d".
dnl   Loop is now "a:e".
dnl   Loop is now "a:f".
dnl   Loop is now "b:d".
dnl   Loop is now "b:e".
dnl   Loop is now "b:f".
dnl   Loop is now "c:d".
dnl   Loop is now "c:e".
dnl   Loop is now "c:f".
m4_define([_ACJF_M4_FOREACH_OBSOLETE],
[m4_if([$1], [],
  [],
  [ACJF_M4_CODECALL(ACJF_M4_LIST_HEAD([$1]), [$2])[]dnl
_ACJF_M4_FOREACH_OBSOLETE(ACJF_M4_LIST_TAIL([$1]), [$2])])[]dnl
])dnl
m4_define([_ACJF_M4_FOREACH_HELPER],
[m4_if([$2], [],
  [],
  [m4_define([$1], ACJF_M4_QUOTE(ACJF_M4_LIST_HEAD([$2])))[]$3[]dnl
_ACJF_M4_FOREACH_HELPER([$1], ACJF_M4_LIST_TAIL([$2]), [$3])])[]dnl
])dnl
AC_DEFUN([ACJF_M4_FOREACH],
[m4_if([$#], [2],
 [_ACJF_M4_FOREACH_OBSOLETE([$1], [$2])],
 [m4_pushdef([$1])_ACJF_M4_FOREACH_HELPER([$1], [$2], [$3])m4_popdef([$1])])dnl
])dnl
dnl ACJF_M4_JOIN( [<item1>,<item2>,...], <code to iterate>, <join with> )
dnl Example:
dnl   ACJF_M4_JOIN( [a,b,c], [yes [$1] ], [ z ])
dnl Result:
dnl   unquoted_yes a  z unquoted_yes b  z unquoted_yes c 
AC_DEFUN([ACJF_M4_JOIN],
[m4_if([$1], [],
  [],
  [ACJF_M4_CODECALL(ACJF_M4_LIST_HEAD([$1]), [$2])[]m4_if(
    ACJF_M4_LIST_SIZE([$1]), 1,
    [],
    [[$3]ACJF_M4_JOIN(ACJF_M4_LIST_TAIL([$1]), [$2], [$3])])])[]dnl
])dnl
dnl ACJF_M4_MAP( [<item1>,<item2>,...], <code to iterate>)
dnl Example:
dnl   ACJF_M4_MAP( [a,b,c], [yes [$1]])
dnl Result:
dnl   unquoted_yes a,unquoted_yes b,unquoted_yes c
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_MAP( [a,b,c], [yes [$1]]))
dnl Result:
dnl   [unquoted_yes a,unquoted_yes b,unquoted_yes c]
AC_DEFUN([ACJF_M4_MAP],
[ACJF_M4_JOIN([$1],[$2],[,])])dnl
dnl
dnl String manipulation Macros
dnl
dnl ACJF_M4_ADDPOSTFIX([list], [postfix])
dnl   Add postfix to all the elements in the list
dnl
dnl Example:
dnl   ACJF_M4_ADDPOSTFIX([a,b,c],[foo])
dnl Result:
dnl   afoo,bfoo,cfoo
dnl
dnl Example:
dnl   ACJF_M4_ADDPOSTFIX([yes,yes],[ no])
dnl Result:
dnl   yes no,yes no
AC_DEFUN([ACJF_M4_ADDPOSTFIX], [ACJF_M4_MAP([$1],
  [[§1$2]])])dnl
dnl ACJF_M4_UNDERLINECONCAT(<arg1>,<arg2>,...)
dnl   concat all args to a single long line with __ seperating the former args
dnl Example:
dnl   ACJF_M4_UNDERLINECONCAT([a  ,  b],[c])
dnl Result:
dnl   a  ,  b__c
AC_DEFUN([ACJF_M4_UNDERLINECONCAT],
  [ACJF_M4_JOIN([$@], [§1], [__])])dnl
dnl ACJF_M4_UPCASE(<arg>) Upcase its arg
dnl 
dnl Example:
dnl   ACJF_M4_UPCASE([foo])
dnl Result:
dnl   FOO
dnl 
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_UPCASE([bar]))
dnl Result:
dnl   [BAR]
AC_DEFUN([ACJF_M4_UPCASE],
  [m4_translit([[$1]], [a-z], [A-Z])])dnl
dnl ACJF_M4_DOWNCASE(<arg>) Downcase its arg
dnl
dnl Example:
dnl   ACJF_M4_DOWNCASE([FOO])
dnl Result:
dnl   foo
dnl 
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_DOWNCASE([Bar]))
dnl Result:
dnl   [bar]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_DOWNCASE([BAR]))
dnl Result:
dnl   [bar]
AC_DEFUN([ACJF_M4_DOWNCASE],
  [m4_translit([[$1]], [A-Z], [a-z])])dnl
dnl Helper function for ACJF_M4_CAPITALIZE don't call directly
m4_define([_ACJF_M4_CAPITALIZE],
  [m4_bregexp([$1], [^\(\w\)\(\w*\)], [ACJF_M4_UPCASE([\1])[]ACJF_M4_DOWNCASE([\2])])])dnl
dnl ACJF_M4_CAPITALIZE(<arg>) Capitalize its arg
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_CAPITALIZE([foo]))
dnl Result:
dnl   [Foo]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_CAPITALIZE([bar]))
dnl Result:
dnl   [Bar]
AC_DEFUN([ACJF_M4_CAPITALIZE],
  [m4_bpatsubst([[$1]], [\w+], _ACJF_M4_CLOSESQUAREBRACKET[_ACJF_M4_CAPITALIZE([\&])]_ACJF_M4_OPENSQUAREBRACKET)])dnl
dnl ACJF_M4_STRIPSPACE(<arg1>,<arg2>,...) Erase leading and trailing spaces from args
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_STRIPSPACE([    foo    ]))
dnl Result:
dnl   [foo]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_STRIPSPACE([  bar   ]))
dnl Result:
dnl   [bar]
AC_DEFUN([ACJF_M4_STRIPSPACE],
  [m4_bpatsubst([$1],[^[ 	]*\(.*[^ 	]\)[ 	]*$],[[\1]])])dnl
dnl ACJF_M4_CANON(<arg>)
dnl   replace non alnum chars with '_'
dnl   replace spaces between the words with a single '_'.
dnl
dnl Example:
dnl   ACJF_M4_CANON([   foo  ,  bar   ])
dnl Result:
dnl   _foo___bar_
dnl
dnl Example:
dnl   ACJF_M4_CANON([foo])
dnl Result:
dnl   foo
dnl
dnl Example:
dnl   ACJF_M4_CANON([[foo]])
dnl Result:
dnl   [foo]
AC_DEFUN([ACJF_M4_CANON], [m4_bpatsubst([[$1]], [\([^][a-zA-Z0-9]\|[ 	]+\)],[_])])dnl
dnl ACJF_M4_CANON_CV(<arg>)
dnl   erase leading and trailing spaces from arg.
dnl   replace non alnum chars with '_'.
dnl   replace spaces between the words with a single '_'.
dnl
dnl Example:
dnl   ACJF_M4_CANON_CV([   foo  ,  bar   ])
dnl Result:
dnl   foo___bar
AC_DEFUN([ACJF_M4_CANON_CV],
  [ACJF_M4_CANON(ACJF_M4_STRIPSPACE($@))])dnl
dnl ACJF_M4_CANON_DN(<arg1>,<arg2>,...)
dnl   erase leading and trailing spaces from arg,
dnl   replace non alnum chars with '_',
dnl   replace spaces between the words with a single '_'
dnl   then upcase the stuff
dnl
dnl Example:
dnl   ACJF_M4_CANON_DN([   foo  ,  bar   ])
dnl Result:
dnl   FOO___BAR
AC_DEFUN([ACJF_M4_CANON_DN],
  [ACJF_M4_CANON_CV(ACJF_M4_UPCASE($@))])dnl
dnl ACJF_M4_CANON_DC(<arg>)
dnl   erase leading and trailing spaces from arg,
dnl   replace non alnum chars with '_',
dnl   replace spaces between the words with a single '_'
dnl   then downcase the stuff
dnl
dnl Example:
dnl   ACJF_M4_CANON_DC([   FOO  ,  BAR   ])
dnl Result:
dnl   foo___bar
AC_DEFUN([ACJF_M4_CANON_DC],
  [ACJF_M4_CANON_CV(ACJF_M4_DOWNCASE($@))])dnl
dnl
dnl Path manipulation Macros
dnl
dnl ACJF_M4_PATH_STRIP_TRAILING_SLASHE(<path>)
dnl   strip trailing '/' '\' from path
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_STRIP_TRAILING_SLASHES([\x\\]))
dnl Result:
dnl   [\x]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_STRIP_TRAILING_SLASHES([\\\]))
dnl Result:
dnl   [\]
AC_DEFUN([ACJF_M4_PATH_STRIP_TRAILING_SLASHES],
  [m4_bpatsubst(
    [[$1]],
    [\(..\)[/\\]*]_ACJF_M4_CLOSESQUAREBRACKET[$],
    [\1]_ACJF_M4_CLOSESQUAREBRACKET)[]dnl
])dnl
dnl Helper function for ACJF_M4_PATH_BASENAME don't call directly
m4_define([_ACJF_M4_PATH_BASENAME],
  [m4_bpatsubst(
    [[$1]],
    [^\[.*[/\\]\([^/\\]+\)\]$],
    [[\1]])[]dnl
])dnl
dnl ACJF_M4_PATH_BASENAME(<path>) 
dnl   get basename of path
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_BASENAME([\x\\]))
dnl Result:
dnl   [x]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_BASENAME([\x\.\]))
dnl Result:
dnl   [.]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_BASENAME([\\\]))
dnl Result:
dnl   [\]
AC_DEFUN([ACJF_M4_PATH_BASENAME],
[_ACJF_M4_PATH_BASENAME(
  ACJF_M4_PATH_STRIP_TRAILING_SLASHES([$1]))[]dnl
])dnl
dnl Helper function for ACJF_M4_PATH_DIRNAME don't call directly
m4_define([_ACJF_M4_PATH_DIRNAME],
  [m4_if(m4_bregexp([$1], [[/\\]]), [-1],
    [[.]],
    [m4_bpatsubst(
      [[$1]],
      [^\[\(.*[/\\]+\)[^/\\]+\]$],
      [ACJF_M4_PATH_STRIP_TRAILING_SLASHES([\1])])])[]dnl
])dnl
dnl ACJF_M4_PATH_DIRNAME(<path>) 
dnl   get dirname of path
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_DIRNAME([\\foo\\bar\\\]))
dnl Result:
dnl   [\\foo]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_DIRNAME([\x\\]))
dnl Result:
dnl   [\]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_DIRNAME([\\\]))
dnl Result:
dnl   [\]
dnl
dnl Example:
dnl   ACJF_M4_QUOTE(ACJF_M4_PATH_DIRNAME([foo]))
dnl Result:
dnl   [.]
AC_DEFUN([ACJF_M4_PATH_DIRNAME],
[_ACJF_M4_PATH_DIRNAME(
  ACJF_M4_PATH_STRIP_TRAILING_SLASHES([$1]))[]dnl
])dnl
dnl
m4_pattern_forbid([^ACJF_])dnl
