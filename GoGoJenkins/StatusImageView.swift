//
//  StatusImageView.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa

class StatusImageView: NSImageView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // PENDING
//        self.image = NSImage(named: "BuildJenkins@2x.png)
        
        // SUCCESS
//        self.image = NSImage(named: "SuccessJenkins@2x.png")
        
        // FAIL
//        self.image = NSImage(named: "FailedJenkins@2x.png")
    }
    
}
