CC = gcc
CFLAGS = -O2 -g

roman: src/main.c lex.yy.c roman.tab.c roman.tab.h
	$(CC) $(CFLAGS) -I. -o $@ lex.yy.c roman.tab.c src/main.c

roman.tab.c roman.tab.h: src/roman.y
	bison -d $^

lex.yy.c: src/roman.l roman.tab.h
	flex $<

.PHONY: clean
clean:
	rm roman lex.yy.c roman.tab.c roman.tab.h

