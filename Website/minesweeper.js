var lines = 10;
var collumns = 10;
var mines = 20;
var maxMines = 99;
var board = [];

/***************************************************************/
/*                                                             */
/* PART 1: INTERFACE                                           */
/*                                                             */
/***************************************************************/

// Grabs and sets number of lines from slider
function setL(value) {
    document.getElementById('valueL').innerHTML = value;
    lines = parseInt(value);
    adjustMines();
}
    
// Grabs and sets number of collumns from slider
function setC(value) {
    document.getElementById('valueC').innerHTML = value;
    collumns = parseInt(value);
    adjustMines();
}

// Grabs and sets number of mines from slider
function setM(value) {
    document.getElementById('valueM').innerHTML = value;
    mines = parseInt(value);
}

// Adjusts number of mines (max and current) according to lines and collumns
function adjustMines() {
    maxMines = (lines*collumns) - 1;
    
    document.getElementById('mineSlider').setAttribute("max", maxMines);
    document.getElementById('valueMax').innerHTML = maxMines;
    
    if (mines > maxMines) {
        document.getElementById('valueM').innerHTML = maxMines;
        mines = parseInt(maxMines);
    }
}

// Function called by button press at the end of the page
function generate() {
    // Last time validation, in case user ends up messing with vars
    adjustMines();
    
    generateBoard();
    
    generateJSON();
    
    board = [];
}

/***************************************************************/
/*                                                             */
/* PART 2: BOARD GENERATION                                    */
/*                                                             */
/***************************************************************/


// Generate a Minesweeper array and place it in a board
// Credits to Michael Butler @ https://github.com/michaelbutler/minesweeper
function generateBoard() {
    var array = [], // 1-d array, with LxC, which will be ported to the main board at the end
    i, max = lines*collumns;
    
    // Put all mines in the beginning
    for (i = 0; i < max; i++) {
        if (i < mines) {
            array[i] = 1;
        }
        else {
            array[i] = 0;
		}
    }
    
    fisherYates(array); // Randomizes mine position
    
    makeBoard(array); // Passes 1-d array to 2-d board
}

// Shuffle array, so it's like pulling out of a "hat"
// Credit: http://sedition.com/perl/javascript-fy.html
function fisherYates (myArray) {
    var i = myArray.length, j, tempi, tempj;
    if (i === 0) {
        return;
    }
    while (--i) {
        j = Math.floor(Math.random() * (i + 1));
        tempi = myArray[i];
        tempj = myArray[j];
        myArray[i] = tempj;
        myArray[j] = tempi;
    }
}

// Add array's data to the board
// Here I use a (lines+2)x(collumns+2) board with valid entries [1..lines][1..collumns].
// This makes it easier to use tile-based functions without corner verifications.
function makeBoard(myArray) {
    var l, c, count;
    
    // Empty board
    board = [];
    for (l = 0; l < lines+2; l++) {
        board[l] = [];
        for (c = 0; c < collumns+2; c++) {
            board[l][c] = 0;
        }
    }
    
    // Place mines in board (only valid positions)
    count = 0;
    for (l = 1; l <= lines; l++) {
        for (c = 1; c <= collumns; c++) {
            if (myArray[count] === 1) {
            	// Places bomb (-1) in given position, and increases count on neighboring cells
            	board[l][c] = -1;
            	increaseTile(l-1, c-1);
            	increaseTile(l-1, c  );
            	increaseTile(l-1, c+1);
            	increaseTile(l,   c-1);
            	increaseTile(l,   c+1);
            	increaseTile(l+1, c-1);
            	increaseTile(l+1, c  );
            	increaseTile(l+1, c+1);
            }
            count++;
        }
    }
}

// Increase count in cell if it doesn't hold a bomb
function increaseTile(x, y) {
    if (board[x][y] === -1) return;
    board[x][y] += 1;
}

/***************************************************************/
/*                                                             */
/* PART 3: FILE CREATION                                       */
/*                                                             */
/***************************************************************/

function generateJSON() {
    var saveFile = new Object(),
        /* Centralizes cards by discovering the position of the top-left card */
        posX = ((-collumns) + !(collumns%2)),
        posZ = (lines - !(lines%2));
    
    /* Start save-file object */
    saveFile.SaveName = "Minesweeper " + lines + "x" + collumns + " (" + mines + ")";
    saveFile.GameMode = "Minesweeper";
    saveFile.Date = "11/7/2015 7:16:23 PM";
    saveFile.Table = "Table_RPG";
    saveFile.Sky = "Sky_Field";
    saveFile.Note = "MINESWEEPER\n\n" + lines + " lines\n" + collumns + " collumns\n" + mines + " mines (" + Math.floor(100*mines/(lines*collumns)) + "%)";
    saveFile.Rules = "";
    saveFile.PlayerTurn = "";
    saveFile.Grid = new Object();
        saveFile.Grid.Type = 0;
        saveFile.Grid.Lines = false;
        saveFile.Grid.Snapping = false;
        saveFile.Grid.Offset = true;
        saveFile.Grid.BothSnapping = false;
        saveFile.Grid.xSize = 2.0;
        saveFile.Grid.ySize = 2.0;
        saveFile.Grid.PosOffset = new Object();
            saveFile.Grid.PosOffset.x = 0.0
            saveFile.Grid.PosOffset.y = 1.0
            saveFile.Grid.PosOffset.z = 0.0
    saveFile.Hands = new Object();
        saveFile.Hands.Enable = false;
        saveFile.Hands. DisableUnused = false;
        saveFile.Hands.Hidding = 0;
    saveFile.DrawImage = "iVBORw0KGgoAAAANSUhEUgAAAWAAAADQCAYAAAA53LuNAAAFFElEQVR4Ae3QgQAAAADDoPlTH+SFUGHAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgy8DQx5DAABHyNK3wAAAABJRU5ErkJggg=="
    saveFile.VectorLines = [];
    saveFile.ObjectStates = [];
    
    /* Flags deck */
    var flagsDeck = new Object();
    flagsDeck.Name = "Deck";
    flagsDeck.Transform = new Object();
        flagsDeck.Transform.posX = 10.9998751;
        flagsDeck.Transform.posY = 3.76623344;
        flagsDeck.Transform.posZ = -18.99992;
        flagsDeck.Transform.rotX = 0;
        flagsDeck.Transform.rotY = 180.013916;
        flagsDeck.Transform.rotZ = 180.000015;
        flagsDeck.Transform.scaleX = 0.625;
        flagsDeck.Transform.scaleY = 0.625;
        flagsDeck.Transform.scaleZ = 0.625;
    flagsDeck.Nickname = "";
    flagsDeck.Description = "";
    flagsDeck.ColorDiffuse = new Object();
        flagsDeck.ColorDiffuse.r = 0.713266432;
        flagsDeck.ColorDiffuse.g = 0.713266432;
        flagsDeck.ColorDiffuse.b = 0.713266432;
    flagsDeck.Locked = false;
    flagsDeck.Grid = true;
    flagsDeck.Snap = true;
    flagsDeck.Autoraise = true;
    flagsDeck.Sticky = true;
    flagsDeck.SidewaysCard = false;
    flagsDeck.DeckIDs = [];
    for (var i = 0; i < mines; i++) { /* Adds one flag for each mine */
        flagsDeck.DeckIDs.push(110);
    }
    flagsDeck.CustomDeck = {
        1: {
            FaceURL: "http://i.imgur.com/aHiVv66.jpg",
            BackURL: "http://i.imgur.com/xL8AXmY.jpg{Unique}"
        }
    }
    saveFile.ObjectStates.push(flagsDeck);
    
    /* Interrogation mark deck */
    var interrogationDeck = new Object();
    interrogationDeck.Name = "Deck";
    interrogationDeck.Transform = new Object();
        interrogationDeck.Transform.posX = 16.9999142;
        interrogationDeck.Transform.posY = 3.76623344;
        interrogationDeck.Transform.posZ = -18.99992;
        interrogationDeck.Transform.rotX = 0;
        interrogationDeck.Transform.rotY = 180.013916;
        interrogationDeck.Transform.rotZ = 180.000015;
        interrogationDeck.Transform.scaleX = 0.625;
        interrogationDeck.Transform.scaleY = 0.625;
        interrogationDeck.Transform.scaleZ = 0.625;
    interrogationDeck.Nickname = "";
    interrogationDeck.Description = "";
    interrogationDeck.ColorDiffuse = new Object();
        interrogationDeck.ColorDiffuse.r = 0.713266432;
        interrogationDeck.ColorDiffuse.g = 0.713266432;
        interrogationDeck.ColorDiffuse.b = 0.713266432;
    interrogationDeck.Locked = false;
    interrogationDeck.Grid = true;
    interrogationDeck.Snap = true;
    interrogationDeck.Autoraise = true;
    interrogationDeck.Sticky = true;
    interrogationDeck.SidewaysCard = false;
    interrogationDeck.DeckIDs = [];
    for (var i = 0; i < mines; i++) { /* Adds one ? for each mine */
        interrogationDeck.DeckIDs.push(111);
    }
    interrogationDeck.CustomDeck = {
        1: {
            FaceURL: "http://i.imgur.com/aHiVv66.jpg",
            BackURL: "http://i.imgur.com/xL8AXmY.jpg{Unique}"
        }
    }
    saveFile.ObjectStates.push(interrogationDeck);
    
    /* Regular game cards */
    for (var i = 1; i <= lines; i++) {
        for (var j = 1; j <= collumns; j++) {
            var card = addCard(i, j, posX, posZ)
            saveFile.ObjectStates.push(card);
        }
    }
    /* End save-file object */
    
    var json = JSON.stringify(saveFile, null, '\t');
    saveTextAs(json, "TS_Save_10.json"); // FileSaver.js by Eli Grey, modified by Brian Chen
}

/* Add each card on the board */
function addCard(line, collumn, posX, posZ) {
    var card = new Object();
    
    // For each card, modify posX [1], posZ [2] and ID [3]
    card.Name = "Card";
    card.Transform = new Object();
        card.Transform.posX = (posX + 2.0*(collumn-1)); /* [1] */
        card.Transform.posY = 3.76623344;
        card.Transform.posZ = (posZ - 2.0*(line-1)); /* [2] */
        card.Transform.rotX = 0;
        card.Transform.rotY = 180.013916;
        card.Transform.rotZ = 180.000015;
        card.Transform.scaleX = 0.625;
        card.Transform.scaleY = 0.625;
        card.Transform.scaleZ = 0.625;
    card.Nickname = "";
    card.Description = "";
    card.ColorDiffuse = new Object();
        card.ColorDiffuse.r = 0.713266432;
        card.ColorDiffuse.g = 0.713266432;
        card.ColorDiffuse.b = 0.713266432;
    card.Locked = false;
    card.Grid = true;
    card.Snap = true;
    card.Autoraise = true;
    card.Sticky = true;
    card.SidewaysCard = false;
    if (board[line][collumn] == -1) { /* [3] */
        card.CardID = 109; // Mine cards
    } else {
        card.CardID = 100 + board[line][collumn]; // Cards 0 to 8 use IDs 100 to 108 respectively
    }
    card.CustomDeck = {
        1: {
            FaceURL: "http://i.imgur.com/aHiVv66.jpg",
            BackURL: "http://i.imgur.com/xL8AXmY.jpg{Unique}"
        }
    }
    
    return card;
}
