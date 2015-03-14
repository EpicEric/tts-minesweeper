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
    @IBOutlet weak var maxMinesLabel: NSTextField!
    
    @IBOutlet weak var linesSlider: NSSlider!
    @IBOutlet weak var collumnsSlider: NSSlider!
    @IBOutlet weak var minesSlider: NSSlider!
    
    @IBOutlet weak var generateButton: NSButton!
    @IBOutlet weak var changeFolderButton: NSButton!
    
    @IBOutlet weak var saveFolderLabel: NSTextField!
    
    var lines = 10, collumns = 15, mines = 75, maxMines = 149
    
    
    var saveLocation = NSURL(string: "file://" + NSHomeDirectory() + "/My%20Games/Tabletop%20Simulator/Saves/")!
    
    @IBAction func linesSliderChanged(sender: NSSlider) {
        lines = linesSlider.integerValue
        maxMines = lines*collumns - 1
        minesSlider.maxValue = Double(maxMines)
        if (mines > maxMines){
            minesSlider.integerValue = maxMines
        }
        mines = minesSlider.integerValue
        linesLabel.stringValue = "\(lines) lines"
        minesLabel.stringValue = "\(mines) mines (\((100*mines)/(lines*collumns))%)"
        maxMinesLabel.stringValue = "\(maxMines)"
    }
    
    @IBAction func collumnsSliderChanged(sender: NSSlider) {
        collumns = collumnsSlider.integerValue
        maxMines = lines*collumns - 1
        minesSlider.maxValue = Double(maxMines)
        if (mines > maxMines){
            minesSlider.integerValue = maxMines
        }
        mines = minesSlider.integerValue
        collumnsLabel.stringValue = "\(collumns) collumns"
        minesLabel.stringValue = "\(mines) mines (\((100*mines)/(lines*collumns))%)"
        maxMinesLabel.stringValue = "\(maxMines)"
    }
    
    @IBAction func minesSliderChanged(sender: NSSlider) {
        mines = minesSlider.integerValue
        minesLabel.stringValue = "\(mines) mines (\((100*mines)/(lines*collumns))%)"
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
        saveFolderLabel.stringValue = "Save folder:\n" + NSHomeDirectory() + "/My Games/Tabletop Simulator/Saves/"
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

