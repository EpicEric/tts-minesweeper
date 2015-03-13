//
//  file.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 09/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

class File {
    
    var buffer:String = ""
    var path:NSURL
    var encoding = NSUTF8StringEncoding
    
    init(path: NSURL){
        self.path = path
    }
    
    class func exists (path: NSURL) -> Bool {
        return NSFileManager().fileExistsAtPath(path.path!)
    }
    
    func write (content: String) {
        buffer = buffer + content
    }
    
    func save () -> Bool {
        return buffer.writeToURL(path, atomically: true, encoding: encoding, error: nil)
    }
}