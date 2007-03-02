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
  header_prefix=`echo "${header}_CH_" | tr '.' '_'`
  rm -f ${header_prefix}*
  case $header in
    *.h)
      SRCEXT="c"
      ;;
    *.hpp)
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
      cat <<EOF > ${header_prefix}$line.$SRCEXT
#define _COMPILEHEADER_
#define _COMPILEHEADER_$line
#include "$header_file"
EOF
      SRCS="$SRCS ${header_prefix}$line.$SRCEXT"
      OBJS="$OBJS ${header_prefix}$line.o"
      LTOBJS="$LTOBJS ${header_prefix}$line.lo"
      DEPS="$DEPS .deps/${header_prefix}$line.P"
    done
    if [ "x$DEPS" != "x" ]; then
      cat <<EOF > ${header_prefix}.mk
${header_prefix}SRCS=$SRCS
${header_prefix}OBJS=$OBJS
${header_prefix}LTOBJS=$LTOBJS

-include $DEPS
EOF
    fi
  }
done

{
  cat <<EOF
.PHONY: clean-compileheader

clean-am: clean-compileheader

clean-compileheader:
	@\$(RM) compileheader.mk compileheader*.stamp

EOF
  for i in *_CH_.mk; do
    if [ -f $i ]; then
      cat <<EOF
include $i
clean-compileheader: clean-compileheader-${i%%.mk}
clean-compileheader-${i%%.mk}:
	@\$(RM) $i \$(${i%%.mk}OBJS) \$(${i%%.mk}LTOBJS) \$(${i%%.mk}SRCS)

EOF
    fi
  done
} > compileheader.mk
