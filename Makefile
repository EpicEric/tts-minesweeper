CC     = gcc
CFLAGS = -Wall -ansi -g -pedantic -Wno-unused-result
RM     = rm
OBJS   = board.o json.o main.o


minesweeper:  $(OBJS)
	$(CC)  $(OBJS)  -o minesweeper -lm

main.o: main.c board.h json.h
	$(CC)  $(CFLAGS)  -c main.c

board.o: board.c board.h
	$(CC)  $(CFLAGS)  -c board.c

json.o: json.c json.h
	$(CC)  $(CFLAGS)  -c json.c

clean:
	$(RM) *.o minesweeper
