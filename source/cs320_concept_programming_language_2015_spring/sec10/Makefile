
TARGET = eightqueens syntax regexp
RM = rm -rf

all: $(TARGET)

eightqueens: eightqueens.hs
	ghc --make -main-is EightQueen $<

syntax: syntax.hs
	ghc --make $<

regexp: regexp.hs
	ghc --make -main-is RegExp $<

clean:
	$(RM) $(TARGET)
	$(RM) *.o
	$(RM) *.hi
	
