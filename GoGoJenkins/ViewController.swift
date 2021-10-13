//
//  ViewController.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func start(_ sender: Any) {
        
        let wc : WindowController = self.view.window?.windowController as! WindowController
        let pr = PRInstance(serviceName: "reservations-service", prNumber: "202", status: "FAILED", buildURL: "www.jenkins.com")
        wc.updateStatus(pRBuild: pr)
    }
    
}

