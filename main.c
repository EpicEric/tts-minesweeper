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
	while(lines < 2 || lines > 18){
		printf("ERROR: Invalid number. Please choose a number from 2 to 18: ");
		scanf("%d", &lines);
	}
	
	printf("Collumns (2 to 28): ");
	scanf("%d", &collumns);
	while(collumns < 2 || collumns > 28){
		printf("ERROR: Invalid number. Please choose a number from 2 to 28: ");
		scanf("%d", &collumns);
	}
	
	printf("Mines (1 to %d): ", lines*collumns);
	scanf("%d", &mines);
	while(mines < 1 || mines > lines*collumns){
		printf("ERROR: Invalid number. Please choose a number from 1 to %d: ", lines*collumns);
		scanf("%d", &mines);
	}
	
	printf("\n--------------------------------\n\n");
	
	generateBoard(lines, collumns, mines, board);
	
	createFile(lines, collumns, mines, board);
	
	return 0;
}
