var lines = 10;
var collumns = 10;
var mines = 20;
var maxMines = 99;

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
    
    //TO-DO: Call PHP script
}