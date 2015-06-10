
#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
include $(PATSHOME)/share/atsmake-post.mk
#
all:: \
unification
unification: \
unification.dats ; \
$(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: unification; ./$<
cleanall:: ; $(RMF) unification
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

