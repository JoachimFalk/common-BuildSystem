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
m4_dnl
m4_changequote([,])m4_dnl
m4_define([m4_if],m4_defn([m4_ifelse]))dnl
m4_define([m4_bregexp],m4_defn([m4_regexp]))dnl
m4_define([m4_bpatsubst],m4_defn([m4_patsubst]))dnl
m4_define([AC_DEFUN],m4_defn([m4_define]))dnl
m4_define([m4_pattern_forbid],[])dnl
dnl
m4_define([a],[[unquoted_a, yes unquoted a!]])dnl
m4_define([b],[[unquoted_b, yes unquoted b!]])dnl
m4_define([c],[[unquoted_c, yes unquoted c!]])dnl
m4_define([d],[[unquoted_d, yes unquoted d!]])dnl
m4_define([e],[[unquoted_e, yes unquoted e!]])dnl
m4_define([f],[[unquoted_f, yes unquoted f!]])dnl
m4_define([g],[[unquoted_g, yes unquoted g!]])dnl
m4_define([h],[[unquoted_h, yes unquoted h!]])dnl
m4_define([i],[[unquoted_i, yes unquoted i!]])dnl
m4_define([j],[[unquoted_j, yes unquoted j!]])dnl
m4_define([k],[[unquoted_k, yes unquoted k!]])dnl
m4_define([l],[[unquoted_l, yes unquoted l!]])dnl
m4_define([m],[[unquoted_m, yes unquoted m!]])dnl
m4_define([n],[[unquoted_n, yes unquoted n!]])dnl
m4_define([o],[[unquoted_o, yes unquoted o!]])dnl
m4_define([p],[[unquoted_p, yes unquoted p!]])dnl
m4_define([q],[[unquoted_q, yes unquoted q!]])dnl
m4_define([r],[[unquoted_r, yes unquoted r!]])dnl
m4_define([s],[[unquoted_s, yes unquoted s!]])dnl
m4_define([t],[[unquoted_t, yes unquoted t!]])dnl
m4_define([u],[[unquoted_u, yes unquoted u!]])dnl
m4_define([v],[[unquoted_v, yes unquoted v!]])dnl
m4_define([w],[[unquoted_w, yes unquoted w!]])dnl
m4_define([x],[[unquoted_x, yes unquoted x!]])dnl
m4_define([y],[[unquoted_y, yes unquoted y!]])dnl
m4_define([z],[[unquoted_z, yes unquoted z!]])dnl
dnl
m4_define([new],         [[unquoted_new]])dnl
m4_define([unquoted_new],[[ununquoted_new]])dnl
m4_define([old],         [[unquoted_old]])dnl
m4_define([unquoted_old],[[ununquoted_old]])dnl
m4_define([NEW],         [[unquoted_NEW]])dnl
m4_define([unquoted_NEW],[[ununquoted_NEW]])dnl
m4_define([OLD],         [[unquoted_OLD]])dnl
m4_define([unquoted_OLD],[[ununquoted_OLD]])dnl
m4_define([yes],         [[unquoted_yes]])dnl
m4_define([unquoted_yes],[[ununquoted_yes]])dnl
m4_define([no],          [[unquoted_no]])dnl
m4_define([unquoted_no], [[ununquoted_no]])dnl
m4_define([YES],         [[unquoted_YES]])dnl
m4_define([unquoted_YES],[[ununquoted_YES]])dnl
m4_define([NO],          [[unquoted_NO]])dnl
m4_define([unquoted_NO], [[ununquoted_NO]])dnl
m4_define([foo],         [[unquoted_foo]])dnl
m4_define([unquoted_foo],[[ununquoted_foo]])dnl
m4_define([bar],         [[unquoted_bar]])dnl
m4_define([unquoted_bar],[[ununquoted_bar]])dnl
m4_define([FOO],         [[unquoted_FOO]])dnl
m4_define([unquoted_FOO],[[ununquoted_FOO]])dnl
m4_define([BAR],         [[unquoted_BAR]])dnl
m4_define([unquoted_BAR],[[ununquoted_BAR]])dnl
m4_define([Foo],         [[unquoted_Foo]])dnl
m4_define([unquoted_Foo],[[ununquoted_Foo]])dnl
m4_define([Bar],         [[unquoted_Bar]])dnl
m4_define([unquoted_Bar],[[ununquoted_Bar]])dnl
dnl
m4_include([jfsugar.m4])dnl
