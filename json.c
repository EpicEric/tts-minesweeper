#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "json.h"

static void chooseName(char filename[128]);
static void addCard(int line, int collumn, int board[][64], double posX, double posZ, FILE *file);

void createFile(int lines, int collumns, int mines, int board[][64]) {
	char filename[128];
	FILE *file;
	int i, j;
	double posX, posZ; /* (Relevant) positions of the first card */
	
	chooseName(filename);
	
	file = fopen(filename,"w");
	if (file == NULL) {
		printf("ERROR: Could not create file \"%s\". Exiting program...", filename);
		exit(-1);
	}
	
	/* Centralizes cards by discovering the position of the top-left card */
	posX = (double) ((-collumns) + !(collumns%2));
	posZ = (double) (lines - !(lines%2));
	
	/* Here comes the fun part... */
	fprintf(file, "{\n"
	              "  \"SaveName\": \"Minesweeper_%dx%d_%d\",\n" /* 1 */
				  "  \"GameMode\": \"Minesweeper\",\n"
				  "  \"Date\": \"3/7/2015 21:15:57 PM\",\n"
				  "  \"Table\": \"Table_RPG\",\n"
				  "  \"Sky\": \"Sky_Field\",\n"
				  "  \"Note\": \"MINESWEEPER\\n\\n%d lines\\n%d collumns\\n%d mines (%d%%)\",\n" /* 2 */
				  "  \"Rules\": \"\",\n"
				  "  \"PlayerTurn\": \"\",\n"
	              "  \"Grid\": {\n"
	              "    \"Type\": 0,\n"
	              "    \"Lines\": false,\n"
	              "    \"Snapping\": true,\n"
	              "    \"Offset\": true,\n"
	              "    \"xSize\": 2.0,\n"
	              "    \"ySize\": 2.0\n"
	              "  },\n"
	, /* 1 */ lines, collumns, mines, /* 2 */ lines, collumns, mines, (100*mines)/(lines*collumns));
	fprintf(file, "  \"DrawImage\": \"iVBORw0KGgoAAAANSUhEUgAAAWAAAADQCAYAAAA53LuNAAAFFElEQVR4Ae3QgQAAAADDoPlTH+SFUGHAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw");
	fprintf(file, "YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw");
	fprintf(file, "YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw");
	fprintf(file, "YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgy8DQx5DAABHyNK3wAAAABJRU5ErkJggg==\",\n");
	fprintf(file, "  \"ObjectStates\": [\n"
	              "    {\n"
	              "      \"Name\": \"Deck\",\n" /* Flag deck */
	              "      \"Transform\": {\n"
	              "        \"posX\": 10.9998751,\n"
	              "        \"posY\": 4.29042053,\n"
	              "        \"posZ\": -18.99992,\n"
	              "        \"rotX\": -4.097558E-05,\n"
	              "        \"rotY\": 180.013916,\n"
	              "        \"rotZ\": 180.000015,\n"
	              "        \"scaleX\": 0.625,\n"
	              "        \"scaleY\": 0.625,\n"
	              "        \"scaleZ\": 0.625\n"
	              "      },\n"
	);
	fprintf(file, "      \"Nickname\": \"\",\n"
	              "      \"Description\": \"\",\n"
	              "      \"ColorDiffuse\": {\n"
	              "        \"r\": 0.7132509,\n"
	              "        \"g\": 0.7132509,\n"
	              "        \"b\": 0.7132509\n"
	              "      },\n"
	              "      \"Grid\": true,\n"
	              "      \"Locked\": false,\n"
	              "      \"SidewaysCard\": false,\n"
	              "      \"DeckIDs\": [\n"
	);
	for (i = 0; i < mines-1; i++)
		fprintf(file, "        110,\n");
	fprintf(file, "        110\n"
	              "      ],\n"
	              "      \"CustomDeck\": {\n"
	              "        \"1\": {\n"
	              "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
	              "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
	              "        }\n"
	              "      }\n"
	              "    },\n"
	              "    {\n"
	              "      \"Name\": \"Deck\",\n" /* Interrogation mark deck */
	              "      \"Transform\": {\n"
	              "        \"posX\": 16.9999142,\n"
	              "        \"posY\": 3.957331,\n"
	              "        \"posZ\": -18.99974,\n"
	              "        \"rotX\": -4.73033E-06,\n"
	              "        \"rotY\": 180.010223,\n"
	              "        \"rotZ\": 180.000061,\n"
	              "        \"scaleX\": 0.625,\n"
	              "        \"scaleY\": 0.625,\n"
	              "        \"scaleZ\": 0.625\n"
	              "      },\n"
	);
	fprintf(file, "      \"Nickname\": \"\",\n"
	              "      \"Description\": \"\",\n"
	              "      \"ColorDiffuse\": {\n"
	              "        \"r\": 0.7132586,\n"
	              "        \"g\": 0.7132586,\n"
	              "        \"b\": 0.7132586\n"
	              "      },\n"
	              "      \"Grid\": true,\n"
	              "      \"Locked\": false,\n"
	              "      \"SidewaysCard\": false,\n"
	              "      \"DeckIDs\": [\n"
	);
	for (i = 0; i < mines-1; i++)
		fprintf(file, "        111,\n");
	fprintf(file, "        111\n"
	              "      ],\n"
	              "      \"CustomDeck\": {\n"
	              "        \"1\": {\n"
	              "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
	              "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
	              "        }\n"
	              "      }\n"
	              "    },\n");
	for (i = 1; i <= lines; i++) /* Regular game cards */
		for (j = 1; j <= collumns; j++) {
			addCard(i, j, board, posX, posZ, file);
			if (i < lines || j < collumns) fprintf(file, ",\n");
		}
	fprintf(file, "\n  ]\n"
	              "}");
	
	fclose(file);
	printf("> .JSON file \"%s\" successfully created!\n", filename);
}

static void chooseName(char filename[128]) {
	FILE *file;
	int number = 1;
	
	do
		sprintf(filename, "TS_Save_%d.json", number++);
	while ((file = fopen(filename, "r")) != NULL);
}

static void addCard(int line, int collumn, int board[][64], double posX, double posZ, FILE *file) {
	fprintf(file, "    {\n"
	              "      \"Name\": \"Card\",\n"
	              "      \"Transform\": {\n"
	              "        \"posX\": %.8f,\n" /* 1 */
	              "        \"posY\": 1.00005647,\n"
	              "        \"posZ\": %.8f,\n" /* 2 */
	              "        \"rotX\": 1.06699508E-06,\n"
	              "        \"rotY\": 180.000015,\n"
	              "        \"rotZ\": 180.000015,\n"
	              "        \"scaleX\": 0.625,\n"
	              "        \"scaleY\": 0.625,\n"
	              "        \"scaleZ\": 0.625\n"
	              "      },\n"
	, /* 1 */ posX + 2.0*(collumn-1), /* 2 */ posZ - 2.0*(line-1));
	fprintf(file, "      \"Nickname\": \"\",\n"
	              "      \"Description\": \"\",\n"
	              "      \"ColorDiffuse\": {\n"
	              "        \"r\": 0.713246942,\n"
	              "        \"g\": 0.713246942,\n"
	              "        \"b\": 0.713246942\n"
	              "      },\n"
	              "      \"Grid\": true,\n"
	              "      \"Locked\": false,\n"
	              "      \"CardID\": 10%d,\n" /* 3 */
	              "      \"SidewaysCard\": false,\n"
	              "      \"CustomDeck\": {\n"
	              "        \"1\": {\n"
	              "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
	              "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
	              "        }\n"
	              "      }\n"
	              "    }"
	, /* 3 */ (board[line][collumn] == -1) ? 9 : board[line][collumn]); /* Cards 0 to 8 use IDs 100 to 108 respectively; mine cards use ID 109 */
}
