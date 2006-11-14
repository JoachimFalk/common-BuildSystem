#! /bin/sh
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

BUILDSYSTEM=`readlink -fn $0`
BUILDSYSTEM=`dirname $BUILDSYSTEM`

cd `dirname $0`

if [ -z "$ACLOCAL" ]; then
  export ACLOCAL="aclocal"
fi
if [ -z "$LIBTOOLIZE" ]; then
  export LIBTOOLIZE="libtoolize"
fi
if [ -z "$AUTOMAKE" ]; then
  export AUTOMAKE="automake"
fi

#ACLOCAL="$ACLOCAL -I $BUILDSYSTEM/m4"
AUTOMAKE="$AUTOMAKE --foreign"

# $LIBTOOLIZE --force
# $ACLOCAL    -I BuildSystem/m4
# $AUTOMAKE   --add-missing

# cleanup
rm -rf `find -name "autom4te.cache"`  \
  $BUILDSYSTEM/config.guess           \
  $BUILDSYSTEM/config.sub             \
  $BUILDSYSTEM/depcomp                \
  $BUILDSYSTEM/install-sh             \
  $BUILDSYSTEM/ltmain.shmissing       \
  $BUILDSYSTEM/mkinstalldirs

autoreconf --install --symlink --force --verbose
