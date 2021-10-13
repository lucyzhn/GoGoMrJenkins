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
        
        self.image = NSImage(named: "Pickaxe@2x.png")
    }
    
}
