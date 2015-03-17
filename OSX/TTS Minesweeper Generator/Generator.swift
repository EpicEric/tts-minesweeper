//
//  Generator.swift
//  TTS Minesweeper Generator
//
//  Created by Bernardo Lopes Leão Silva on 17/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

class Generator {
    
    private var lin = 0
    private var col = 0
    var mines = 0
    private var maxMin = 0
    
    let typeLines = 0, typeCollumns = 1, typeMines = 2
    
    var lines: Int {
        get {
            return lin
        }
        set {
            lin = newValue
            maxMines = lin * col - 1
        }
    }
    
    var collumns: Int {
        get {
            return col
        }
        set {
            col = newValue
            maxMines = lin * col - 1
        }
    }
    
    var maxMines: Int {
        get {
            return maxMin
        }
        set {
            maxMin = lin * col - 1
            if (mines > maxMines){
                mines = maxMines
            }
        }
    }
    
    var saveLocation: NSURL
    
    init(lines: Int = 10, collumns: Int = 15, mines: Int = 75, saveLocation: NSURL = NSURL(string: "file://" + NSHomeDirectory() + "/My%20Games/Tabletop%20Simulator/Saves/")!){
        self.saveLocation = saveLocation
        self.lines = lines
        self.collumns = collumns
        self.mines = mines
    }
    
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