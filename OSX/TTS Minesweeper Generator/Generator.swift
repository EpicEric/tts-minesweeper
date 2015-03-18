//
//  Generator.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 17/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

class Generator {
    
    var lines: Int = 0 { didSet { maxMines = lines * collumns - 1 } }

    var collumns: Int = 0 { didSet { maxMines = lines * collumns - 1 } }
    
    var mines = 0
    
    var maxMines: Int = 0 { didSet { mines = min(mines, maxMines) } }
    
    var saveLocation: NSURL = NSURL(string: "file://" + NSHomeDirectory() + "/My%20Games/Tabletop%20Simulator/Saves/")!
    
    let typeLines = 0, typeCollumns = 1, typeMines = 2
    
    
    func updateValue(type: Int, value: Int) -> Int{
        switch type {
        case typeLines:
            lines = value
            return maxMines
        case typeCollumns:
            collumns = value
            return maxMines
        case typeMines:
            mines = value
            return maxMines
        default: return maxMines
        }
    }
    
    func updateSaveLocation(url: NSURL) -> String {
        saveLocation = url
        return saveLocation.path!
    }
    
    func generate () -> (Bool, Int) {
        var board = Board.generateBoard(lines, collumns: collumns, mines: mines)
        return  json.createFile(lines, collumns: collumns, mines: mines, board: board, basePath: saveLocation)
    }
}