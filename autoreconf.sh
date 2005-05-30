#! /bin/sh

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
