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
	@$(ac_aux_dir)/mkcompileheaderobj.sh $?

-include compileheader.mk

%.sh:%-sh
	cp -f $< $@; chmod 0755 $@
