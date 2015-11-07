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
    
    debugger;
    
    // DEBUG
    //alert(JSON.stringify(board))
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
    i, max;
    
    // Put all mines in the beginning
    for (i = 0, max = lines*collumns; i < max; i++) {
        if (i < mines) {
            array[i] = 1;
        }
        else {
            array[i] = 0;
		}
    }

    fisherYates(array);
        
    makeBoard(array);
}

// Shuffle array, so it's like pulling out of a "hat"
// Credit: http://sedition.com/perl/javascript-fy.html
function fisherYates (myArray) {
    var x = myArray.length, y, tempx, tempy;
    if (x === 0) {
        return;
    }
    while (--x) {
        y = Math.floor(Math.random() * (x + 1));
        tempx = myArray[x];
        tempy = myArray[y];
        myArray[x] = tempx;
        myArray[y] = tempy;
    }
}

// Place the array in the board
// Here I use a [lines+2][collumns+2] board with valid entries [1..lines][1..collumns].
// This makes it easier to use functions such as insertBomb without corner verifications.
function makeBoard(myArray) {
    var l = 0, c = 0, count;
    
    // Empty board
    board = [];
    debugger;
    for (; l < lines+2; l++) {
        debugger;
        board[l] = [];
        for (; c < collumns+2; c++) {
            board[l][c] = 0;
        }
    }
    
    debugger;
    
    // Place mines in board (only valid positions)
    count = 0;
    l = 1;
    c = 1;
    for (; l <= lines; l++) {
        for (; c <= collumns; c++) {
            if (myArray[count++] === 1) {
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
        }
    }
}

// Increases count on cell if it doesn't hold a bomb
function increaseTile(x, y) {
    if (board[x][y] === -1) return;
    board[x][y] += 1;
}

/***************************************************************/
/*                                                             */
/* PART 3: FILE CREATION                                       */
/*                                                             */
/***************************************************************/