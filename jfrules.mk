# vim: set noet sw=2 sts=0 ts=8:

pkgincludebacktrack=$(shell echo "$(pkgincludeprefix)" | sed -e 's@[^/][^/]*\(/\|$$\)@../@g')
pkgincludedir=$(includedir)/$(pkgincludeprefix)

include: Makefile $(pkginclude_HEADERS) 
	@set -e; rm -rf include/$(pkgincludeprefix); mkdir -p include/$(pkgincludeprefix); \
	set $^; shift; \
	for i in $${1+"$$@"}; do \
	  ln -sf `case $$i in /*) echo $$i; ;; *) echo '../$(pkgincludebacktrack)/'"$$i"; ;; esac` include/$(pkgincludeprefix); \
	done

compileheader.mk: $(HEADERS)
	@if test -n "$?"; then					\
		$(auxdir)/mkcompileheaderobj.sh $?;		\
	fi

clean-am: clean-pkginclude  clean-re2c

clean-re2c:
	@find $(srcdir) -maxdepth 1 -name "*.re2c*" |		\
	  while read file; do					\
	    case $$file in					\
	      *.re2c)   rm -f $${file%%.re2c}.c ;;		\
	      *.re2cpp) rm -f $${file%%.re2cpp}.cpp ;;		\
	    esac;						\
	  done

clean-pkginclude:
	rm -rf include

-include compileheader.mk

%.sh:%-sh
	cp -f $< $@; chmod 0755 $@

%.c: %.re2c
	re2c -b -o $@ $<

%.cpp: %.re2cpp
	re2c -b -o $@ $<

.PHONY:  clean-pkginclude  clean-re2c
