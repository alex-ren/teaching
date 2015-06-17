
#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
include $(PATSHOME)/share/atsmake-post.mk
#
all:: \
quicksort \
quicksort_generic

quicksort: \
quicksort.dats ; \
$(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<

quicksort_generic: \
quicksort_generic.dats ; \
$(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<

regress:: quicksort; ./$<
cleanall:: ; $(RMF) quicksort

regress:: quicksort_generic; ./$<
cleanall:: ; $(RMF) quicksort_generic
#
testall:: regress
testall:: cleanall
#
cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) *_?ats.c
#
cleanall:: cleanats
#
###### end of [Makefile] ######

