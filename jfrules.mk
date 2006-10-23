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
	@if test -n "$?"; then						\
		$(auxdir)/mkcompileheaderobj.sh $?;			\
	fi

clean-am: clean-pkginclude  clean-re2c-scripts

clean-re2c-scripts:
	@find $(srcdir) -maxdepth 1 -name "*.re2c*" -o -name "*-sh" |	\
	  while read file; do						\
	    case $$file in						\
	      *.re2c)   rm -f `basename $${file%%.re2c}.c` ;;		\
	      *.re2cpp) rm -f `basename $${file%%.re2cpp}.cpp` ;;	\
	      *-sh)     rm -f `basename $${file%%-sh}.sh` ;;		\
	    esac;							\
	  done

clean-pkginclude:
	rm -rf include

-include compileheader.mk

%.sh: %-sh
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  cp -f $< $@ && chmod 0755 $@

%: %.m4
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  m4 --fatal-warnings -P -I $(dir $<) -I $(auxdir)/m4 $(auxdir)/autoconf-env.m4 $< > $@

%.c: %.re2c
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  re2c -b -o $@ $<

%.cpp: %.re2cpp
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  re2c -b -o $@ $<

.PHONY:  clean-pkginclude  clean-re2c
