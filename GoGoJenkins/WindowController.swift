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
    @IBOutlet weak var statusIcon1: MyImageView!
    @IBOutlet weak var prInfo2: NSTextField!
    @IBOutlet weak var statusIcon2: NSImageView!
    
    var buildUp = false
    var loadRotate = false
    
    override func windowDidLoad() {
        super.windowDidLoad()
        mainIcon.image = NSImage(named: "JenkinsIcon@2x.png")
    }
    
    func updateStatus(pRBuild: PRInstance, side: String) {
        let prInfo = side == "LEFT" ? prInfo1 : prInfo2
        let statusIcon = side == "LEFT" ? statusIcon1 : statusIcon2
        prInfo?.font = .systemFont(ofSize: 12)
        prInfo?.stringValue = pRBuild.serviceName + "\nPR#" + pRBuild.prNumber
        if (pRBuild.status == "null"){
            if(loadRotate){statusIcon?.image = NSImage(named: "Loading1.png")}
            else{statusIcon?.image = NSImage(named: "Loading2.png")}
            loadRotate = (!loadRotate)
        }
        else if (pRBuild.status == "PENDING") {
            if (buildUp){ statusIcon?.image = NSImage(named: "BuildJenkinsUp.png") }
            else{ statusIcon?.image = NSImage(named: "BuildJenkinsDown.png")}
            buildUp = (!buildUp)
        }
        else if (pRBuild.status == "SUCCESS") {
            statusIcon?.image = NSImage(named: "SuccessJenkins@2x.png")
        }
        else if (pRBuild.status == "FAILURE") {
            statusIcon?.image = NSImage(named: "FailedJenkins@2x.png")
        }
        
    }
}
class MyImageView: NSImageView {

    override func touchesBegan(with event: NSEvent) {
        print("Touched!")
    }

}
