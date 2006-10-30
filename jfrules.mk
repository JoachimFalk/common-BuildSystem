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

doxygen-doc: doxygen-doc-recursive

doxygen-doc-recursive:
	@failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    dot_seen=yes; \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  (cd $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done; \
	if test "$$dot_seen" = "no"; then \
	  $(MAKE) $(AM_MAKEFLAGS) "$$target-am" || exit 1; \
	fi; test -z "$$fail"

doxygen-doc-am: $(DX_RUN_GOAL) $(DX_PS_GOAL) $(DX_PDF_GOAL)

.PHONY:  clean-pkginclude  clean-re2c doxygen-doc-am
