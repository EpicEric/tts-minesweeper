<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Minesweeper</title>
        <?php include_once("../../analyticstracking.php") ?>

        <script src="minesweeper.js" type="text/javascript"></script>
    </head>
    <body>
        <main>
            <h1>Minesweeper Generator - Tabletop Simulator</h1>
            <h2>Version 1.0</h2>
            <div id="fields">
                <input type="range" min="2" max="18" value="10" step="1" oninput="setL(this.value)" />
                <br>Lines (2 to 18) = <span id="valueL">10</span><br><br>
                <input type="range" min="2" max="28" value="10" step="1" oninput="setC(this.value)" />
                <br>Collumns (2 to 28) = <span id="valueC">10</span><br><br>
                <input id="mineSlider" type="range" min="1" max="99" value="20" step="1" oninput="setM(this.value)" />
                <br>Mines (1 to <span id="valueMax">99</span>) = <span id="valueM">20</span><br><br>
            </div>
            <br>
            <div id="generation">
                <input type="button" value="Generate and Save" onclick="generate()" />
            </div>
        </main>
    </body>
</html>

<?php

  $board = array();
  $lines;
  $columns;
  $mines;

  function generateBoard($l, $c, $m) {
    $array = array();
    $lines = $l;
    $columns = $c;
    $mines = $m;
    $max = $lines*$columns;
    for ($i = 0, $i < $max, $i++){
      if ($i < $mines){
        array[$i] = 1;
      }
      else {
        array[$i] = 0;
      }
    }

    fisherYates($array);

    return makeBoard(array);
  }

  function fisherYates($array) {
    $i = count($array);
    if ($i == 0) {
        return;
    }
    $tempi, $tempj;
    while (--$i) {
        $j = Math.floor(Math.random() * ($i + 1));
        $tempi = myArray[$i];
        $tempj = myArray[$j];
        myArray[$i] = $tempj;
        myArray[$j] = $tempi;
    }
  }

  function makeBoard($myArray) {
      $l, $c, $count;

      // Empty board
      $board = array();
      for ($l = 0; $$l < ($lines+2); $l++) {
          $board[$l] = array();
          for ($c = 0; $c < ($columns+2); $c++) {
              $board[$l][$c] = 0;
          }
      }

      // Place mines in board (only valid positions)
      $count = 0;
      for ($l = 1; $l <= $lines; $l++) {
          for ($c = 1; $c <= $columns; $c++) {
              if ($myArray[$count] == 1) {
              	// Places bomb (-1) in given position, and increases count on neighboring cells
              	$board[$l][$c] = -1;
              	increaseTile($l-1, $c-1);
              	increaseTile($l-1, $c  );
              	increaseTile($l-1, $c+1);
              	increaseTile($l,   $c-1);
              	increaseTile($l,   $c+1);
              	increaseTile($l+1, $c-1);
              	increaseTile($l+1, $c  );
              	increaseTile($l+1, $c+1);
              }
              $count++;
          }
      }
      file_put_contents('filename.txt', print_r($board, true));
      $file = 'filename.txt';
      if (file_exists($file)) {
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="'.basename($file).'"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($file));
        readfile($file);
        exit;
      }

  }


  function increaseTile($x, $y) {
      if ($board[$x][$y] == -1) return;
      $board[$x][$y] += 1;
  }



  }
