TARGET     = ofaces
CC         = gcc
CXX        = g++
CFLAGS     = `pkg-config --cflags opencv`
PREFIX     = /usr/local
SRCS       = faces/faces.c
OBJS       = faces.o
INCLUDES   = -I. -I$(PREFIX)/include
LIBS       = -L. -L$(PREFIX)/lib -L`pkg-config --libs opencv | cut -d' ' -f1 | xargs dirname` \
						 -lstdc++ -lopencv_core -lopencv_objdetect -lopencv_imgproc -lopencv_highgui
CLIBS      = `pkg-config --libs opencv`
PROGFILE   = ofaces.ml
INTERFACE  = ofacesutil.i
INTERFACEDIR  =
INTERFACEPATH = $(INTERFACEDIR)$(INTERFACE)
SWIGOPT    = -cpperraswarn
SWIG       = swig
IWRAP      = $(INTERFACE:.i=_wrap.i)
ISRCS      = $(IWRAP:.i=.c)
ICXXSRCS   = $(IWRAP:.i=.cxx)
IOBJS      = $(IWRAP:.i=.o)
UNAME 		 = $(shell uname)

##################################################################
#####                          Ocaml                         #####
##################################################################

OCC=ocamlc
OCAMLOPT=ocamlopt
OCAMLMKLIB=ocamlmklib
NOLINK ?= false
OCAMLPP= -pp "camlp4o ./swigp4.cmo"
OCAMLP4WHERE=`$(COMPILETOOL) camlp4 -where`
OCAMLCORE=\
	rm -rf swig.mli swig.ml swigp4.ml && \
	$(SWIG) -ocaml -co swig.mli 2>/dev/null && \
	$(SWIG) -ocaml -co swig.ml 2>/dev/null && \
	$(SWIG) -ocaml -co swigp4.ml 2>/dev/null && \
	$(OCC) -g -c swig.mli swig.ml && \
	$(OCC) -I $(OCAMLP4WHERE) -pp "camlp4o pa_extend.cmo q_MLast.cmo" \
		-c swigp4.ml

all:
	$(OCAMLCORE)
	$(SWIG) -ocaml -c++ $(SWIGOPT) $(INTERFACEPATH)
	cp $(ICXXSRCS) $(ICXXSRCS:%.cxx=%.c)
ifeq ($(UNAME),Darwin)
		sed -i '' 's:SWIGSTATIC int caml_array_length:CAMLextern mlsize_t caml_array_length:g' $(ISRCS)
else
		sed -i.bak 's:SWIGSTATIC int caml_array_length:CAMLextern mlsize_t caml_array_length:g' $(ISRCS)
endif
	$(OCC) -cc '$(CXX) -Wno-write-strings $(CFLAGS)' -g -c -ccopt -g -ccopt -fPIC \
		-ccopt "-xc++ $(INCLUDES)" \
		$(ICXXSRCS:%.cxx=%.c) $(SRCS) $(CXXSRCS)
	$(OCC) -g -c $(INTERFACE:%.i=%.mli) $(INTERFACE:%.i=%.ml)
	test -z "$(PROGFILE:%.ml=%.mli)" || test -f "$(PROGFILE:%.ml=%.mli)" && \
		$(OCC) $(OCAMLPP) -c $(PROGFILE:%.ml=%.mli)
	test -z "$(PROGFILE)" || test -f "$(PROGFILE)" && \
		$(OCC) $(OCAMLPP) -c $(PROGFILE)
	$(NOLINK) || $(OCAMLMKLIB) -verbose -ccopt -g -cclib -g -o $(TARGET) $(LIBS) \
		swig.cmo $(INTERFACE:%.i=%.cmo) $(PROGFILE:%.ml=%.cmo) $(INTERFACE:%.i=%_wrap.o) $(OBJS)

opt:
	$(OCAMLOPT) -g -c swig.mli swig.ml
	$(OCAMLOPT) -g -c $(INTERFACE:%.i=%.mli) $(INTERFACE:%.i=%.ml)
	test -z "$(PROGFILE:%.ml=%.mli)" || test -f "$(PROGFILE:%.ml=%.mli)" && \
		$(OCAMLOPT) $(OCAMLPP) -c $(PROGFILE:%.ml=%.mli)
	test -z "$(PROGFILE)" || test -f "$(PROGFILE)" && \
		$(OCAMLOPT) $(OCAMLPP) -c $(PROGFILE)
	$(NOLINK) || $(OCAMLMKLIB) -verbose -ccopt -g -cclib -g -o $(TARGET) $(LIBS) \
		swig.cmx $(INTERFACE:%.i=%.cmx) $(PROGFILE:%.ml=%.cmx)
	$(OCAMLOPT) -shared -linkall -o $(TARGET).cmxs $(TARGET).cmxa

clean:
	rm -f *_wrap* *~ .~* *.cmo *.cmi *.cma *.cmx *.cmxa *.cmxs
	rm -f swig.mli swig.cmi swig.ml swig.cmo swigp4.ml swigp4.cmo
	rm -f core
	rm -f *.a *.o *.so *.bak
