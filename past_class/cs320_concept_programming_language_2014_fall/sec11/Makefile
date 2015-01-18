
TARGET = eightqueens
RM = rm -rf

all: $(TARGET)

$(TARGET): eightqueens.hs
	ghc --make -main-is EightQueen $<

clean:
	$(RM) $(TARGET)
	$(RM) *.o
	$(RM) *.hi
	
