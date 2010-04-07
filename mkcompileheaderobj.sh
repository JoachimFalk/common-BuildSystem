#! /bin/sh
# vim: set sw=2 ts=8:
# Copyright (C) 2001 - 2006 Joachim Falk <joachim.falk@gmx.de>
# 
# This file is part of the BuildSystem distribution of Joachim Falk;
# you can redistribute it and/or modify it under the terms of the
# GNU General Public License as published by the Free Software Foundation;
# either version 2 of the License, or (at your option) any later version.
# 
# The BuildSystem is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this program; If not, write to
# the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

if [ $# -eq 0 ]; then
  echo "usage: `basename $0` headerfiles"
  exit 0
fi

for header_file in "$@"; do
  header=`basename $header_file`
  header_prefix=`echo "${header}_CH" | tr '.' '_'`
  rm -f ${header_prefix}*
  case $header in
    *.h)
      SRCEXT="c"
      ;;
    *.hh|*.hpp|*.hxx|*.tcc|*.tcpp|*.tcxx)
      SRCEXT="cpp"
      ;;
    *)
      echo "Unknown header format for header $header"
      exit 1
      ;;
  esac
  sed -e "s/^ *#.*  *_COMPILEHEADER_\(.\+\)$/\1/;t;d" $header_file | {\
    SRCS=""; OBJS=""; LTOBJS=""; DEPS=""
    while read line; do
      cat <<EOF > ${header_prefix}_${line}.${SRCEXT}
#define _COMPILEHEADER_
#define _COMPILEHEADER_$line
#include "$header_file"
EOF
      SRCS="$SRCS ${header_prefix}_${line}.${SRCEXT}"
      OBJS="$OBJS ${header_prefix}_${line}.o"
      LTOBJS="$LTOBJS ${header_prefix}_${line}.lo"
      DEPS="$DEPS .deps/${header_prefix}_${line}.Plo"
    done
    if [ "x$DEPS" != "x" ]; then
      cat <<EOF > ${header_prefix}.mk
${header_prefix}_SRCS=$SRCS
${header_prefix}_OBJS=$OBJS
${header_prefix}_LTOBJS=$LTOBJS

-include $DEPS
EOF
    fi
  }
done

{
  cat <<EOF
.PHONY: clean-compileheader

clean-am: clean-compileheader
EOF
  SRCS=""; OBJS=""; LTOBJS=""; MKFRAGS=""
  for header_file in "$@"; do
    header=`basename $header_file`
    header_prefix=`echo "${header}_CH" | tr '.' '_'`
    if test -f "${header_prefix}.mk"; then
      cat <<EOF
include ${header_prefix}.mk
EOF
      SRCS="$SRCS \$(${header_prefix}_SRCS)"
      OBJS="$OBJS \$(${header_prefix}_OBJS)"
      LTOBJS="$LTOBJS \$(${header_prefix}_LTOBJS)"
      MKFRAGS="$MKFRAGS ${header_prefix}.mk"
    fi
  done
cat <<EOF
CH_SRCS=$SRCS
CH_OBJS=$OBJS
CH_LTOBJS=$LTOBJS
CH_MKFRAGS=$MKFRAGS

clean-compileheader:
	@\$(RM) compileheader.mk compileheader*.stamp
	@\$(RM) \$(CH_SRCS) \$(CH_OBJS) \$(CH_LTOBJS) \$(CH_MKFRAGS)
EOF
} > compileheader.mk
