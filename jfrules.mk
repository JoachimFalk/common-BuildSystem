# vim: set noet sw=2 sts=0 ts=8:

pkgincludebacktrack=$(shell echo "$(pkgincludeprefix)" | sed -e 's@[^/][^/]*\(/\|$$\)@../@g')
pkgincludedir=$(includedir)/$(pkgincludeprefix)

include: $(pkginclude_HEADERS)
	@set -e; mkdir -p include/$(pkgincludeprefix); \
	for i in $^; do \
	  ln -sf `case $$i in /*) echo $$i; ;; *) echo '../$(pkgincludebacktrack)/'"$$i"; ;; esac` include/$(pkgincludeprefix); \
	done

.PHONY: clean-pkginclude

clean-pkginclude:
	rm -rf include

clean-am: clean-pkginclude

compileheader.mk: $(HEADERS)
	@if test -n "$?"; then					\
		$(ac_abs_aux_dir)/mkcompileheaderobj.sh $?;	\
	fi

-include compileheader.mk

%.sh:%-sh
	cp -f $< $@; chmod 0755 $@
