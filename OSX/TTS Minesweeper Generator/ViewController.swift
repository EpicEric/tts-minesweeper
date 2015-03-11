//
//  ViewController.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 08/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var linesLabel: NSTextField!
    @IBOutlet weak var collumnsLabel: NSTextField!
    @IBOutlet weak var minesLabel: NSTextField!
    
    var lines = 10, collumns = 15, mines = 75, maxMines = 150
    
    @IBOutlet weak var linesSlider: NSSlider!
    @IBOutlet weak var collumnsSlider: NSSlider!
    @IBOutlet weak var minesSlider: NSSlider!
    
    @IBOutlet weak var generateButton: NSButton!
    
    @IBAction func linesSliderChanged(sender: NSSlider) {
        lines = linesSlider.integerValue
        minesSlider.maxValue = Double(lines*collumns)
        maxMines = lines*collumns
        if (mines > maxMines){
            minesSlider.integerValue = maxMines
        }
        mines = minesSlider.integerValue
        linesLabel.stringValue = "Lines: \(lines)"
        minesLabel.stringValue = "Mines: \(mines) (\((100*mines)/(lines*collumns))%)"

    }
    
    @IBAction func collumnsSliderChanged(sender: NSSlider) {
        collumns = collumnsSlider.integerValue
        minesSlider.maxValue = Double(lines*collumns)
        maxMines = lines*collumns
        if (mines > maxMines){
            minesSlider.integerValue = maxMines
        }
        mines = minesSlider.integerValue
        collumnsLabel.stringValue = "Collumns: \(collumns)"
        minesLabel.stringValue = "Mines: \(mines) (\((100*mines)/(lines*collumns))%)"
    }
    
    
    @IBAction func minesSliderChanged(sender: NSSlider) {
        mines = minesSlider.integerValue
        minesLabel.stringValue = "Mines: \(mines) (\((100*mines)/(lines*collumns))%)"
    }
    
    @IBAction func generateButtonPressed(sender: NSButton) {
        var board = Board.generateBoard(lines, collumns: collumns, mines: mines)
        let (created, identifier) = json.createFile(lines, collumns: collumns, mines: mines, board: board)
        if (created){
            let alert = NSAlert()
            alert.messageText = "File created successfully!"
            alert.informativeText = "Open Tabletop Simulator, start a new Single or Multiplayer game, select \"Menu\" -> \"Load Game\" and choose to Load Slot \(identifier) to start sweeping mines!"
            alert.runModal()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

