dnl vim: set sw=2 ts=8 syn=config:
dnl
dnl Copyright (C) Joachim Falk <joachim.falk@gmx.de> $Date: 2003/01/24 13:23:54 $
dnl
dnl all.m4 is part of the SysteMoC distribution of Joachim Falk;
dnl you can redistribute it and/or modify it under the terms of the
dnl GNU General Public License as published by the Free Software Foundation;
dnl either version 2 of the License, or (at your option) any later version.
dnl
dnl The jflibs distributio is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public
dnl License along with this program; If not, write to
dnl the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
dnl Boston, MA 02111-1307, USA.
dnl
m4_define([_ACJF_M4_OPENSQUAREBRACKET],
  m4_changequote(<,>)<m4_changequote(<,>)<[>m4_changequote([,])>m4_changequote([,]))dnl
m4_define([_ACJF_M4_CLOSESQUAREBRACKET],
  m4_changequote(<,>)<m4_changequote(<,>)<]>m4_changequote([,])>m4_changequote([,]))dnl
AC_DEFUN([ACJF_M4_QUOTE], [[$@]])dnl
AC_DEFUN([ACJF_M4_UNQUOTE], [$*])dnl
AC_DEFUN([ACJF_M4_FLATEN],
[m4_if($#, 0, [],
  [m4_if(m4_bregexp([$1],\_ACJF_M4_OPENSQUAREBRACKET), -1,
    [[$1]],
    [ACJF_M4_FLATEN($1)])m4_if($#, 1, [],
    [,ACJF_M4_FLATEN(m4_shift($@))])])])dnl
AC_DEFUN([ACJF_M4_ARG_HEAD], [[$1]])dnl
AC_DEFUN([ACJF_M4_ARG_SIZE], [$#])dnl
AC_DEFUN([ACJF_M4_ARG_REVERSE],
[m4_if($#, 0, [], $#, 1, [[$1]],
  [ACJF_M4_ARG_REVERSE(m4_shift($@)),[$1]])])dnl
dnl
dnl Macros for operations on lists
dnl
AC_DEFUN([ACJF_M4_LISTTOARGS],
[m4_bpatsubst([$1],[\(\[.*\]\|[^,]*\)],[[\1]])])dnl
AC_DEFUN([ACJF_M4_ARGSTOLIST], [[$*]])dnl
dnl ACJF_M4_LIST_SIZE( [<item1>,<item2>,...] )
dnl Example:
dnl   ACJF_M4_LIST_SIZE( [a,b,c,d,ef,g,h] )
dnl Result:
dnl   7
AC_DEFUN([ACJF_M4_LIST_SIZE],
[ACJF_M4_ARG_SIZE(ACJF_M4_LISTTOARGS([$1]))])dnl
AC_DEFUN([ACJF_M4_LIST_HEAD],
[ACJF_M4_ARG_HEAD(ACJF_M4_LISTTOARGS([$1]))])dnl
AC_DEFUN([ACJF_M4_LIST_TAIL],
[ACJF_M4_ARGSTOLIST(m4_shift(ACJF_M4_LISTTOARGS([$1])))])dnl
AC_DEFUN([ACJF_M4_LIST_REVERSE],
[ACJF_M4_ARGSTOLIST(ACJF_M4_ARG_REVERSE(ACJF_M4_LISTTOARGS([$1])))])dnl
AC_DEFUN([ACJF_M4_LIST_FRONT], m4_defn([ACJF_M4_LIST_HEAD]))dnl
AC_DEFUN([ACJF_M4_LIST_POP_FRONT], m4_defn([ACJF_M4_LIST_TAIL]))dnl
dnl ACJF_M4_LIST_PUSH_FRONT( [<new_item>], [<item1>,<item2>,...] )
dnl Example:
dnl   ACJF_M4_LIST_PUSH_FRONT([a],[b,c,d,e,f])
dnl Result:
dnl   [a,b,c,d,e,f]
AC_DEFUN([ACJF_M4_LIST_PUSH_FRONT],
[ACJF_M4_ARGSTOLIST([$1]m4_if([$2], [],
  [],
  [,ACJF_M4_LISTTOARGS([$2])]))dnl
])dnl
AC_DEFUN([ACJF_M4_LIST_BACK],
[ACJF_M4_LIST_FRONT(ACJF_M4_LIST_REVERSE([$1]))])dnl
AC_DEFUN([ACJF_M4_LIST_POP_BACK],
[ACJF_M4_LIST_REVERSE(ACJF_M4_LIST_POP_FRONT(ACJF_M4_LIST_REVERSE([$1])))])dnl
dnl ACJF_M4_LIST_PUSH_BACK( [<new_item>], [<item1>,<item2>,...] )
dnl Example:
dnl   ACJF_M4_LIST_PUSH_BACK([a],[b,c,d,e,f])
dnl Result:
dnl   [b,c,d,e,f,a]
AC_DEFUN([ACJF_M4_LIST_PUSH_BACK],
[ACJF_M4_ARGSTOLIST(m4_if([$2], [],
  [],
  [ACJF_M4_LISTTOARGS([$2]),])[$1])dnl
])dnl
dnl ACJF_M4_LIST_TOP( [<item1>,<item2>,...], <how many>)
dnl Example:
dnl   ACJF_M4_LIST_TOP([a,b,c,d,ef,g,h],3)
dnl Result:
dnl   [a,b,c]
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
AC_DEFUN([ACJF_M4_LIST_ELEM],
[m4_if([$2], 0,
  [ACJF_M4_LIST_HEAD([$1])],
  [ACJF_M4_LIST_ELEM(ACJF_M4_LIST_TAIL([$1]),m4_decr([$2]))]dnl
)])dnl
dnl ACJF_M4_QUOTEDARGS([code with § instead of $])
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
dnl Example:
dnl   ACJF_M4_CODECALL( [a,b,c],
dnl     [$1 && $2 || $3
dnl   ])
dnl Result:
dnl   a && b || c
AC_DEFUN([ACJF_M4_CODECALL],
[m4_define([_ACJF_M4_CODECALL_DEF],ACJF_M4_QUOTEDARGS([$2]))dnl
_ACJF_M4_CODECALL_DEF($1)])dnl
dnl ACJF_M4_ISLISTELEM( [list], [element], [if yes], [if no] )
AC_DEFUN([ACJF_M4_ISLISTELEM],
[m4_if(ACJF_M4_QUOTE($1), [[]],
  [$4],
  [m4_if(ACJF_M4_ARG_HEAD($1),[$2],
    [ACJF_M4_CODECALL(ACJF_M4_QUOTE(ACJF_M4_ARG_HEAD($1)),[$3])],
    [ACJF_M4_ISLISTELEM(ACJF_M4_QUOTE(m4_shift($1)), [$2], [$3], [$4])])])[]dnl
])dnl
dnl ACJF_M4_FOREACH( [<item1>,<item2>,...], <code to iterate>)
dnl Example:
dnl   ACJF_M4_FOREACH( [a,b,c,d,ef,g,h],
dnl     [Loop is now "$1".
dnl   ])
AC_DEFUN([ACJF_M4_FOREACH],
[m4_if(ACJF_M4_QUOTE($1), [[]],
  [],
  [ACJF_M4_CODECALL(ACJF_M4_QUOTE(ACJF_M4_ARG_HEAD($1)),[$2])[]dnl
ACJF_M4_FOREACH(ACJF_M4_QUOTE(m4_shift($1)), [$2])])dnl
])dnl
dnl ACJF_M4_JOINLIST( [<item1>,<item2>,...], <code to iterate>, <join with> )
dnl Example:
dnl   ACJF_M4_JOINLIST( [a,b,c], [_s[$1]_data], [ && ])
dnl Result:
dnl   _sa_data && _sb_data && _sc_data
AC_DEFUN([ACJF_M4_JOINLIST],
[m4_if(ACJF_M4_QUOTE($1), [[]],
  [],
  [ACJF_M4_CODECALL(ACJF_M4_QUOTE(ACJF_M4_ARG_HEAD($1)),[$2])[]m4_if(
      ACJF_M4_ARG_SIZE($1), 1,
      [], [$3[]ACJF_M4_JOINLIST(ACJF_M4_QUOTE(m4_shift($1)),[$2],[$3])])])])dnl
dnl ACJF_M4_MAP( [<item1>,<item2>,...], <code to iterate>)
dnl Example:
dnl   ACJF_M4_MAP( [a,b,c], [_s[$1]_data])
dnl Result:
dnl   [[_sa_data],[_sb_data],[_sc_data]]
AC_DEFUN([ACJF_M4_MAP],
[ACJF_M4_QUOTE(ACJF_M4_JOINLIST( [$1], [$2], [, ]))])dnl
dnl
dnl String manipulation Macros
dnl
dnl Upcase its args
AC_DEFUN([ACJF_M4_UPCASE], [ACJF_M4_UNQUOTE(ACJF_M4_MAP([$@],
  [m4_translit([[§1]], [a-z], [A-Z])]))])dnl
dnl Downcase its args
AC_DEFUN([ACJF_M4_DOWNCASE], [ACJF_M4_UNQUOTE(ACJF_M4_MAP([$@],
  [m4_translit([[§1]], [A-Z], [a-z])]))])dnl
dnl Helper function for ACJF_M4_CAPITALIZE don't call directly
AC_DEFUN([ACJF_M4_CAPITALIZE1], [m4_bregexp([$1], [^\(\w\)\(\w*\)], [ACJF_M4_UPCASE([\1])[]ACJF_M4_DOWNCASE([\2])])])dnl
dnl Capitalize its args
AC_DEFUN([ACJF_M4_CAPITALIZE], [ACJF_M4_UNQUOTE(ACJF_M4_MAP([$@],
  [m4_bpatsubst([§1], [\w+], [ACJF_M4_CAPITALIZE1([\&])])]))])dnl
dnl erase leading and trailing spaces from args
AC_DEFUN([ACJF_M4_STRIPSPACE], [ACJF_M4_UNQUOTE(ACJF_M4_MAP([$@],
  [m4_bpatsubst([§1],[^[ 	]*\(.*[^ 	]\)[ 	]*$],[[\1]])]))])dnl
dnl replace spaces between the words with a single '_'
AC_DEFUN([ACJF_M4_CANON], [ACJF_M4_UNQUOTE(ACJF_M4_MAP([$@],
  [m4_bpatsubst([[§1]],[\([^][a-zA-Z0-9]\|[ 	]+\)],[_])]))])dnl
dnl concat all args to a single long line with __ seperating the former args
AC_DEFUN([ACJF_M4_UNDERLINECONCAT], [ACJF_M4_FOREACH([$@],
  [[§1]m4_if( §#, 1, [], [__])])])dnl
dnl Add postfix $2 to all the elements in the list in $1
AC_DEFUN([ACJF_M4_ADDPOSTFIX], [ACJF_M4_MAP([$1],
  [[§1$2]])])dnl
dnl erase leading and trailing spaces from args
dnl replace spaces between the words with a single '_'
AC_DEFUN([ACJF_M4_CANON_CV],
  [ACJF_M4_CANON(ACJF_M4_STRIPSPACE([$*]))])dnl
dnl erase leading and trailing spaces from args
dnl replace spaces between the words with a single '_'
dnl than upcase the stuff
AC_DEFUN([ACJF_M4_CANON_DN],
  [m4_translit(ACJF_M4_CANON_CV([$*]),[a-z],[A-Z])])dnl
dnl ACJF_M4_ONCECODE( <protection m4_define>, <code> )
AC_DEFUN([ACJF_M4_ONCECODE],
[m4_ifdef([__oncecode__$1],
  [],
  [m4_define([__oncecode__$1], [Yes])$2])])dnl
