
#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
include $(PATSHOME)/share/atsmake-post.mk
#
all:: \
matrix
matrix: \
matrix.dats ; \
$(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: matrix; ./$<
cleanall:: ; $(RMF) matrix
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

