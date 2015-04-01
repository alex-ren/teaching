

TARGET = quiz answer
RM = rm -rf

all: $(TARGET)

quiz: quiz.hs
	ghc --make -main-is Quiz $< -o $@

answer: answer.hs
	ghc --make -main-is Answer $< -o $@

clean:
	$(RM) $(TARGET)
	$(RM) *.o
	$(RM) *.hi
	


