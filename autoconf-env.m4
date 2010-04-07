m4_dnl Copyright (C) 2001 - 2006 Joachim Falk <joachim.falk@gmx.de>
m4_dnl 
m4_dnl This file is part of the BuildSystem distribution of Joachim Falk;
m4_dnl you can redistribute it and/or modify it under the terms of the
m4_dnl GNU General Public License as published by the Free Software Foundation;
m4_dnl either version 2 of the License, or (at your option) any later version.
m4_dnl 
m4_dnl The BuildSystem is distributed in the hope that it will be useful,
m4_dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
m4_dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
m4_dnl General Public License for more details.
m4_dnl 
m4_dnl You should have received a copy of the GNU General Public
m4_dnl License along with this program; If not, write to
m4_dnl the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
m4_dnl Boston, MA 02111-1307, USA.
m4_dnl
m4_changequote([,])m4_dnl
m4_define([dnl],m4_defn([m4_dnl]))dnl
m4_define([m4_if],m4_defn([m4_ifelse]))dnl
m4_define([m4_bregexp],m4_defn([m4_regexp]))dnl
m4_define([m4_bpatsubst],m4_defn([m4_patsubst]))dnl
m4_define([AC_DEFUN],m4_defn([m4_define]))dnl
m4_define([m4_pattern_forbid],[])dnl
dnl
m4_include([jfsugar.m4])dnl
