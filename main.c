#include <stdio.h>
#include <stdlib.h>

#include "board.h"
#include "json.h"

int main() {
	int lines, collumns;
	int mines;
	int board[64][64];
	
	printf("Lines (2 to 18): ");
	scanf("%d", &lines);
	printf("Collumns (2 to 28): ");
	scanf("%d", &collumns);
	printf("Mines: ");
	do
		scanf("%d", &mines);
	while (mines > lines*collumns || mines == 0);
	
	generateBoard(lines, collumns, mines, board);
	
	createFile(lines, collumns, mines, board);
	
	return 0;
}
