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
    
    // DEBUG
    alert(JSON.stringify(board));
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

// Increases count in cell if it doesn't hold a bomb
function increaseTile(x, y) {
    if (board[x][y] === -1) return;
    board[x][y] += 1;
}

/***************************************************************/
/*                                                             */
/* PART 3: FILE CREATION                                       */
/*                                                             */
/***************************************************************/

// TODO: Implement TTS JSON file