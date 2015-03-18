//
//  Generator.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 17/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

class Generator {
    
    private var lines: Int = 0 { didSet { maxMines = lines * collumns - 1 } }

    private var collumns: Int = 0 { didSet { maxMines = lines * collumns - 1 } }
    
    private var mines = 0
    
    private var maxMines: Int = 0 { didSet { mines = min(mines, maxMines) } }
    
    private var saveLocation: NSURL = NSURL(string: "file://" + NSHomeDirectory() + "/My%20Games/Tabletop%20Simulator/Saves/")!
    
    func updateValuesOf(#lines: Int, collumns: Int, mines: Int) -> (lines: Int, collumns: Int, mines: Int, maxMines: Int){
        self.lines = lines
        self.collumns = collumns
        self.mines = mines
        return (self.lines, self.collumns, self.mines, self.maxMines)
    }
    
    func updateSaveLocation(url: NSURL) -> NSURL? {
        saveLocation = url
        return saveLocation
    }
    
    func updateSaveLocation(path: String) -> NSURL? {
        if let location = NSURL(string: path){
            self.saveLocation = location
            return self.saveLocation
        }
        return nil
    }
    
    func getSaveLocation() -> NSURL {
        return self.saveLocation
    }
    
    func generate () -> (Bool, Int) {
        var board = Board.generateBoard(lines, collumns: collumns, mines: mines)
        return  json.createFile(lines, collumns: collumns, mines: mines, board: board, basePath: saveLocation)
    }
}