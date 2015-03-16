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
    
    @IBAction func sliderChanged(sender: NSSlider) {
        lines = linesSlider.integerValue
        collumns = collumnsSlider.integerValue
        maxMines = lines*collumns - 1
        minesSlider.maxValue = Double(maxMines)
        if (mines > maxMines){
            minesSlider.integerValue = maxMines
        }
        mines = minesSlider.integerValue
        linesLabel.stringValue = String(format: NSLocalizedString("NumberOfLines", comment: "Number of lines"), lines)
        collumnsLabel.stringValue = String(format: NSLocalizedString("NumberOfCollumns", comment: "Number of collumns"), collumns)
        minesLabel.stringValue = String(format: NSLocalizedString("NumberOfMines", comment: "Shows the current number of mines."), mines) + " (\((100*mines)/(lines*collumns))%)"
        maxMinesLabel.stringValue = "\(maxMines)"
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
        updateSaveFolderLabel()
    }
    @IBAction func generateButtonPressed(sender: NSButton) {
        var board = Board.generateBoard(lines, collumns: collumns, mines: mines)
        let (created, identifier) = json.createFile(lines, collumns: collumns, mines: mines, board: board, basePath: saveLocation)
        let alert = NSAlert()
        if (created){
            alert.messageText = NSLocalizedString("FileCreatedTitle", comment: "Title of the successful file creation alert")
            alert.informativeText = String(format: NSLocalizedString("FileCreatedDesc", comment: "Description of the successful file creation alert"), identifier)
            alert.addButtonWithTitle(NSLocalizedString("CloseButton", comment: "Button to close the alert."))
            alert.addButtonWithTitle(NSLocalizedString("OpenTTSButton", comment: "Button to open the game."))
            alert.beginSheetModalForWindow(view.window!, completionHandler: receiveButton)
        } else {
            alert.messageText = NSLocalizedString("FileErrorTitle", comment: "Title of the unsuccessful file creation alert")
            alert.informativeText = NSLocalizedString("FileErrorDesc", comment: "Description of the unsuccessful file creation alert")
            alert.beginSheetModalForWindow(view.window!, completionHandler: receiveButton)
        }
    }
    

    
    func receiveButton(button: NSModalResponse) {
        if (button == NSAlertSecondButtonReturn){
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "steam://run/286160")!)
        }
    }
    
    func updateSaveFolderLabel (){
        saveFolderLabel.stringValue = NSLocalizedString("FolderLocationTitle", comment: "The folder where the resultant file will be saved.") + saveLocation.path!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveFolderLabel()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

