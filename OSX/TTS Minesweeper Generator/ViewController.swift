//
//  ViewController.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 08/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var linesField: NSTextField!
    @IBOutlet weak var collumnsField: NSTextField!
    @IBOutlet weak var minesField: NSTextField!
    
    @IBOutlet weak var linesStepper: NSStepper!
    @IBOutlet weak var collumnsStepper: NSStepper!
    @IBOutlet weak var minesStepper: NSStepper!
    
    @IBOutlet weak var generateButton: NSButton!
    @IBOutlet weak var changeFolderButton: NSButton!
    
    @IBOutlet weak var saveFolderLabel: NSTextField!
    @IBOutlet weak var minesPercLabel: NSTextField!
    @IBOutlet weak var maxMinesLabel: NSTextField!
    
    var lines = 10, collumns = 15, mines = 75, maxMines = 149
    
    
    var saveLocation = NSURL(string: "file://" + NSHomeDirectory() + "/My%20Games/Tabletop%20Simulator/Saves/")!
    
    @IBAction func linesStepperPressed(sender: NSStepper) {
        lines = linesStepper.integerValue
        linesField.integerValue = lines
        minesStepper.maxValue = Double(lines*collumns) - 1
        maxMines = lines*collumns - 1
        if (mines > maxMines){
            minesStepper.integerValue = maxMines
        }
        mines = minesStepper.integerValue
        minesField.integerValue = mines
        minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
        maxMinesLabel.stringValue = "(1 to \(maxMines))"
    }
    
    @IBAction func linesFieldEdited(sender: NSTextField) {
        if (linesField.stringValue.toInt() == nil){
          linesField.integerValue = lines
        } else if (linesField.integerValue > 18){
            linesField.integerValue = 18
        } else if (linesField.integerValue < 2){
            linesField.integerValue = 2
        } else {
            lines = linesField.integerValue
            linesStepper.integerValue = lines
            minesStepper.maxValue = Double(lines*collumns) - 1
            maxMines = lines*collumns - 1
            if (mines > maxMines){
                minesStepper.integerValue = maxMines
            }
            mines = minesStepper.integerValue
            minesField.integerValue = mines
            minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
            maxMinesLabel.stringValue = "(1 to \(maxMines))"
        }
    }
    
    @IBAction func collumnsStepperPressed(sender: NSStepper) {
        collumns = collumnsStepper.integerValue
        collumnsField.integerValue = collumns
        minesStepper.maxValue = Double(lines*collumns) - 1
        maxMines = lines*collumns - 1
        if (mines > maxMines){
            minesStepper.integerValue = maxMines
        }
        mines = minesStepper.integerValue
        minesField.integerValue = mines
        minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
        maxMinesLabel.stringValue = "(1 to \(maxMines))"
    }
    
    @IBAction func collumnsFieldEdited(sender: NSTextField) {
        if (collumnsField.stringValue.toInt() == nil){
            collumnsField.integerValue = collumns
        } else if (collumnsField.integerValue > 28){
            collumnsField.integerValue = 28
        } else if (collumnsField.integerValue < 2){
            collumnsField.integerValue = 2
        } else {
            collumns = collumnsField.integerValue
            collumnsStepper.integerValue = collumns
            minesStepper.maxValue = Double(lines*collumns) - 1
            maxMines = lines*collumns - 1
            if (mines > maxMines){
                minesStepper.integerValue = maxMines
            }
            mines = minesStepper.integerValue
            minesField.integerValue = mines
            minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
            maxMinesLabel.stringValue = "(1 to \(maxMines))"
        }

    }
    
    @IBAction func minesStepperPressed(sender: NSStepper) {
        mines = minesStepper.integerValue
        minesField.integerValue = mines
        minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
        maxMinesLabel.stringValue = "(1 to \(maxMines))"
    }
    
    @IBAction func minesFieldEdited(sender: NSTextField) {
        if (minesField.stringValue.toInt() == nil){
            minesField.integerValue = mines
        } else if (minesField.integerValue > maxMines){
            minesField.integerValue = maxMines
        } else if (minesField.integerValue < 1){
            minesField.integerValue = 1
        } else {
            mines = minesField.integerValue
            minesStepper.integerValue = mines
            minesPercLabel.stringValue = "\((100*mines)/(lines*collumns))%"
            maxMinesLabel.stringValue = "(1 to \(maxMines))"
        }
    }
    
    @IBAction func changeFolderButtonPressed(sender: NSButton) {
        let directoryPicker = NSOpenPanel()
        directoryPicker.canChooseDirectories = true
        directoryPicker.canChooseFiles = false
        directoryPicker.allowsMultipleSelection = false
        directoryPicker.directoryURL = saveLocation
        directoryPicker.beginSheetModalForWindow(view.window!, completionHandler: {(result) -> Void in
            if (result == NSFileHandlingPanelOKButton && directoryPicker.URL != nil){
                self.saveLocation = directoryPicker.URL!
            }})
        saveFolderLabel.stringValue = "Save folder:\n" + saveLocation.path!
        }
    @IBAction func generateButtonPressed(sender: NSButton) {
        var board = Board.generateBoard(lines, collumns: collumns, mines: mines)
        let (created, identifier) = json.createFile(lines, collumns: collumns, mines: mines, board: board, basePath: saveLocation)
        let alert = NSAlert()
        if (created){
            alert.messageText = "File created successfully!"
            alert.informativeText = "Open Tabletop Simulator, start a new Single or Multiplayer game, select \"Menu\" -> \"Load Game\" and Load Slot \(identifier) to start sweeping mines!"
            alert.addButtonWithTitle("Close")
            alert.addButtonWithTitle("Open Tabletop Simulator")
            alert.beginSheetModalForWindow(view.window!, completionHandler: receiveButton)
        } else {
            alert.messageText = "Could not create file!"
            alert.informativeText = "Please check if you chose the right folder. Try to uncheck \"Choose save location\" and try again."
            alert.beginSheetModalForWindow(view.window!, completionHandler: receiveButton)
        }
    }
    

    
    func receiveButton(button: NSModalResponse) {
        if (button == NSAlertSecondButtonReturn){
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "steam://run/286160")!)
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

