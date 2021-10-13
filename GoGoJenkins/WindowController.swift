//
//  WindowController.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet weak var mainIcon: NSImageView!
    @IBOutlet weak var prInfo: NSTextField!
    @IBOutlet weak var statusIcon: NSImageView!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        mainIcon.image = NSImage(named: "JenkinsIcon@2x.png")
    }
    
    func updateStatus(pRBuild: PRInstance) {
        prInfo.font = .systemFont(ofSize: 12)
        prInfo.stringValue = pRBuild.serviceName + "\nPR#" + pRBuild.prNumber
        if (pRBuild.status == "PENDING") {
            statusIcon.image = NSImage(named: "BuildJenkins@2x.png")
        }
        else if (pRBuild.status == "SUCCESS") {
            statusIcon.image = NSImage(named: "SuccessJenkins@2x.png")
        }
        else if (pRBuild.status == "FAILED") {
            statusIcon.image = NSImage(named: "FailedJenkins@2x.png")
        }
    }
}
