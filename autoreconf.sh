#! /bin/sh

export ACLOCAL="aclocal"
export LIBTOOLIZE="libtoolize"
export AUTOMAKE="automake --foreign"

# $LIBTOOLIZE --force
# $ACLOCAL    -I BuildSystem/m4
# $AUTOMAKE   --add-missing

autoreconf --install --symlink --force --verbose
