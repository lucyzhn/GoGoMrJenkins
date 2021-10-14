//
//  WindowController.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet weak var mainIcon: NSImageView!
    @IBOutlet weak var prInfo1: NSTextField!
    @IBOutlet weak var statusIcon1: NSImageView!
    @IBOutlet weak var prInfo2: NSTextField!
    @IBOutlet weak var statusIcon2: NSImageView!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        mainIcon.image = NSImage(named: "JenkinsIcon@2x.png")
    }
    
    func updateStatus(pRBuild: PRInstance, side: String) {
        let prInfo = side == "LEFT" ? prInfo1 : prInfo2
        let statusIcon = side == "LEFT" ? statusIcon1 : statusIcon2
        prInfo?.font = .systemFont(ofSize: 12)
        prInfo?.stringValue = pRBuild.serviceName + "\nPR#" + pRBuild.prNumber
        if (pRBuild.status == "PENDING") {
            statusIcon?.image = NSImage(named: "BuildJenkins@2x.png")
        }
        else if (pRBuild.status == "SUCCESS") {
            statusIcon?.image = NSImage(named: "SuccessJenkins@2x.png")
        }
        else if (pRBuild.status == "FAILED") {
            statusIcon?.image = NSImage(named: "FailedJenkins@2x.png")
        }
    }
}
