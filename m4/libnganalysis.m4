dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2010 FAU -- Martin Streubuehr <martin.streubuehr@fau.de>
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

dnl ACJF_CHECK_LIB_NGANALYSIS check for libnganalysis library
dnl
dnl ACJF_CHECK_LIB_NGANALYSIS(
dnl  [<tags>,]
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>])
AC_DEFUN([ACJF_CHECK_LIB_NGANALYSIS], [ACJF_CHECK_HELPER_SET_VARS([$@], [
  AC_LANG_PUSH([C++])
  ACJF_CHECK_LIB([LibNGAnalysis], ACJF_TAGS_OVERRIDE(ACJF_VAR_TAGS,[[intern],[extern],[pkgconfig:libnganalysis]]),
   [#include <nganalysis/SDF.hpp>
   ],
   [int dummy;],
    ACJF_VAR_CODE_IF_TRUE,
    ACJF_VAR_CODE_IF_FALSE)dnl
  AC_LANG_POP
])])
