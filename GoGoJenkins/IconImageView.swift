//
//  IconImageView.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/13/21.
//

import Cocoa

class IconImageView: NSImageView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.image = NSImage(named: "JenkinsIcon@2x.png")
    }
    
}
