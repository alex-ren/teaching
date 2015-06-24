
#
# PATSHOME is already available
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

CFLAGS :=
CFLAGS += -D_GNU_SOURCE
CFLAGS += -DATS_MEMALLOC_LIBC

######

all:: brauntree
brauntree: brauntree.dats; \
$(PATSCC) $(CFLAGS) -o $@ $<
regress:: brauntree; ./brauntree
cleanall:: ; rm -f brauntree

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
