#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#include "board.h"

static void clearBoard(int lines, int collumns, int board[][64]);
static int randomInteger(int low, int high);
static void insertBomb(int line, int collumn, int board[][64]);
static void increaseTile(int line, int collumn, int board[][64]);

/* Here I use a [lines+2][collumns+2] board with valid entries [1..lines][1..collumns].
 * This makes it easier to use functions such as insertBomb without corner verifications. */

void generateBoard(int lines, int collumns, int mines, int board[][64]) {
	int m;
	int lin, col;
	
	clearBoard(lines, collumns, board);
	
	srand(time(NULL));
	
	for (m = 0; m < mines; m++) {
		do {
			lin = randomInteger(1, lines);
			col = randomInteger(1, collumns);
		} while (board[lin][col] == -1);
		insertBomb(lin, col, board);
	}
}

static void clearBoard(int lines, int collumns, int board[][64]) {
	int i, j;
	for (i = 0; i <= lines + 1; i++)
		for (j = 0; j <= collumns + 1; j++)
			board[i][j] = 0;
}

/* randomInteger copied from Paulo Feofiloff, who copied himself from Eric Roberts */
static int randomInteger(int low, int high) {
    int k;
    double d;
    d = (double) rand( ) / ((double) RAND_MAX + 1);
    k = d * (high - low + 1);
    return low + k;
}

static void insertBomb(int line, int collumn, int board[][64]) {
	board[line][collumn] = -1;
	increaseTile(line-1, collumn-1, board);
	increaseTile(line-1, collumn,   board);
	increaseTile(line-1, collumn+1, board);
	increaseTile(line,   collumn-1, board);
	increaseTile(line,   collumn+1, board);
	increaseTile(line+1, collumn-1, board);
	increaseTile(line+1, collumn,   board);
	increaseTile(line+1, collumn+1, board);
}

static void increaseTile(int line, int collumn, int board[][64]) {
	if (board[line][collumn] == -1) return;
	board[line][collumn] += 1;
}
