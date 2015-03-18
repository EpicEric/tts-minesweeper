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
    
    let directoryPicker = NSOpenPanel()
    
    var gen = Generator()
    
    @IBAction func sliderChanged(sender: NSSlider) {
        let updatedValues = gen.updateValuesOf(lines: linesSlider.integerValue, collumns: collumnsSlider.integerValue, mines: minesSlider.integerValue)
        minesSlider.integerValue = updatedValues.mines
        minesSlider.maxValue = Double(updatedValues.maxMines)
        minesSlider.numberOfTickMarks = Int(minesSlider.maxValue / 10)
        linesLabel.stringValue = String(format: NSLocalizedString("NumberOfLines", comment: "Number of lines"), updatedValues.lines)
        collumnsLabel.stringValue = String(format: NSLocalizedString("NumberOfCollumns", comment: "Number of collumns"), updatedValues.collumns)
        minesLabel.stringValue = String(format: NSLocalizedString("NumberOfMines", comment: "Shows the current number of mines."), updatedValues.mines) + " (\((100*updatedValues.mines)/(updatedValues.lines*updatedValues.collumns))%)"
        maxMinesLabel.stringValue = "\(updatedValues.maxMines)"
    }
    
    @IBAction func changeFolderButtonPressed(sender: NSButton) {
        directoryPicker.beginSheetModalForWindow(view.window!, completionHandler: {(result) -> Void in
            if (result == NSFileHandlingPanelOKButton && self.directoryPicker.URL != nil){
                if let url = self.gen.updateSaveLocation(self.directoryPicker.URL!) {
                    self.updateSaveFolderLabel(url.path!)
                }
            }})
    }
    
    
    @IBAction func generateButtonPressed(sender: NSButton) {
        let alert = NSAlert()
        let (created, identifier) = gen.generate()
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
    
    func updateSaveFolderLabel (path: String){
        saveFolderLabel.stringValue = NSLocalizedString("FolderLocationTitle", comment: "The folder where the resultant file will be saved.") + path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directoryPicker.canChooseDirectories = true
        directoryPicker.canChooseFiles = false
        directoryPicker.allowsMultipleSelection = false
        updateSaveFolderLabel(gen.getSaveLocation().path!)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

