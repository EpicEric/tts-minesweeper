#include <stdio.h>
#include <stdlib.h>

#include "board.h"
#include "json.h"

int main() {
	int lines, collumns;
	int mines;
	int board[64][64];
	char buffer;
	
	printf("TABLETOP SIMULATOR -- MINESWEEPER BOARD GENERATOR\n  By: Epic Eric and Berna\n\n--------------------------------\n\nType ENTER to continue. ");
	do
		scanf("%c", &buffer);
	while (buffer != '\n');
	
	printf("\nLines (2 to 18): ");
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
	
	scanf("%c", &buffer);
	printf("\nType ENTER to exit. ");
	do
		scanf("%c", &buffer);
	while (buffer != '\n');
	
	return 0;
}
