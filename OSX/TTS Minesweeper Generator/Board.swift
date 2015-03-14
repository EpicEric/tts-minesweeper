//
//  Board.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 09/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

public  class Board{

    class func newBoard(lines: Int, collumns: Int) -> Support.Matrix{
        var i:Int, j:Int, board = Support.Matrix(rows: lines + 2, columns: collumns + 2);
        for (i = 1; i < lines; i++){
            for (j = 1; j < collumns; j++){
                board[i, j] = 0
            }
        }
        return board
    }
    
    public class func generateBoard(lines: Int, collumns: Int, mines: Int) -> Support.Matrix{
        var m = 0, lin = 0, col = 0
        
        var board = newBoard(lines, collumns: collumns)
        
        for (m = 0; m < mines; m++){
            do {
                lin = Int(arc4random_uniform(UInt32(lines))) + 1
                col = Int(arc4random_uniform(UInt32(collumns))) + 1
            } while (board[lin, col] == -1)
            board = insertBomb(lin, collumn: col, board: board)
        }
        return board
    }
    
    class func insertBomb(line: Int, collumn: Int, board: Support.Matrix) -> Support.Matrix{
        var newBoard = board
        newBoard[line, collumn] = -1
        for (var i = line - 1 ; i <= line + 1; i++){
            for (var j = collumn - 1; j <= collumn + 1; j++){
                newBoard = increaseTile(i, collumn: j, board: newBoard)
            }
        }
        return newBoard
    }
    
    class func increaseTile (line: Int, collumn: Int, board: Support.Matrix) -> Support.Matrix {
        if (board[line, collumn] == -1){
            return board
        }
        var newBoard = board
        newBoard[line, collumn] = newBoard[line, collumn] + 1
        return newBoard
    }

}