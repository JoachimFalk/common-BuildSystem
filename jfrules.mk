# vim: set noet sw=2 sts=0 ts=8:
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

ifdef pkgincludeprefix
pkgincludebacktrack=$(shell echo "$(pkgincludeprefix)" | sed -e 's@[^/][^/]*\(/\|$$\)@../@g')
pkgincludedir=$(includedir)/$(pkgincludeprefix)

include: Makefile $(pkginclude_HEADERS) 
	@set -e; rm -rf include/$(pkgincludeprefix); mkdir -p include/$(pkgincludeprefix); \
	set $^; shift; \
	for i in $${1+"$$@"}; do \
	  ln -sf `case $$i in /*) echo $$i; ;; *) echo '../$(pkgincludebacktrack)/'"$$i"; ;; esac` include/$(pkgincludeprefix); \
	done

clean-am: clean-pkginclude

clean-pkginclude:
	rm -rf include
endif

clean-am: clean-re2c-scripts

clean-re2c-scripts:
	@find $(srcdir) -maxdepth 1 -name "*.re2c*" -o -name "*-sh" |	\
	  while read file; do						\
	    case $$file in						\
	      *.re2c)   rm -f `basename $${file%%.re2c}.c` ;;		\
	      *.re2cpp) rm -f `basename $${file%%.re2cpp}.cpp` ;;	\
	      *-sh)     rm -f `basename $${file%%-sh}.sh` ;;		\
	    esac;							\
	  done

-include compileheader.mk

compileheader.mk: $(HEADERS)
	@if test -n "$?"; then						\
		$(auxdir)/mkcompileheaderobj.sh $?;			\
	fi

%.sh: %-sh
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  cp -f $< $@ && chmod 0755 $@

%: %.m4
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  m4 --fatal-warnings -P -I $(dir $<) -I $(auxdir)/m4 $(auxdir)/autoconf-env.m4 $< > $@

%.c: %.re2c
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  re2c -b -o $@ $< || \
	{ rm -f $@; false; }

%.cpp: %.re2cpp
	{ [ -d $(dir $@) ] || mkdir -p $(dir $@); } && \
	  re2c -b -o $@ $< || \
	{ rm -f $@; false; }

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
