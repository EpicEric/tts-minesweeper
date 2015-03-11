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
    var path:String = ""
    var encoding = NSUTF8StringEncoding
    
    init(path: String){
        self.path = path
    }
    
    class func exists (path: String) -> Bool {
        return NSFileManager().fileExistsAtPath(path)
    }
    
    func write (content: String) {
        buffer = buffer + content
    }
    
    func save () -> Bool {
        return buffer.writeToFile(path, atomically: true, encoding: encoding, error: nil)
    }
}