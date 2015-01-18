
TARGET = polyset
RM = rm -rf

all: $(TARGET)

$(TARGET): polyset.hs
	ghc --make -main-is PolySet $<

clean:
	$(RM) $(TARGET)
	$(RM) *.o
	$(RM) *.hi
	
