//
//  ViewController.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

    override func viewWillAppear() {
        DispatchQueue.global(qos: .userInitiated).async {
            let buildStatus = self.getBuildStatus()
            print(buildStatus)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    @IBAction func start(_ sender: Any) {
        
        let wc : WindowController = self.view.window?.windowController as! WindowController
        
        let listOfPRInstances = [
            PRInstance(serviceName: "reservations-service", prNumber: "202", status: "SUCCESS", buildURL: "www.jenkins.com"),
            PRInstance(serviceName: "inventory-service", prNumber: "105", status: "FAILED", buildURL: "www.jenkins.com"),
            PRInstance(serviceName: "bespoke-proxy-service", prNumber: "928", status: "PENDING", buildURL: "www.jenkins.com")
        ]
        var side = "LEFT"
        DispatchQueue.global(qos: .default).async{
            for prInstance in listOfPRInstances {
                DispatchQueue.main.async {
                    wc.updateStatus(pRBuild: prInstance, side: side)
                   side = side == "LEFT" ? "RIGHT" : "LEFT"
                 }
                sleep(10)
            }
        }
    }
    
//    func getGitApiToken(){
//        runCommand(cmd:"/usr/bin/env", args: ["zsh", "-c", "-i","-l","/usr/bin/env"])
//    }
//
    
    func getBuildStatus(){
        let bundle = Bundle.main
        let path = bundle.path(forResource: "GoGoMrJenkins-1.0", ofType: "jar")!
        runCommand(cmd: "/usr/bin/java", args: ["-jar", path, "", "check-build"])
    }
    
    func runCommand(cmd:String, args:[String])-> [String] {
        
        var output : [String] = []
        var error : [String] = []
        let task = Process()
        
        task.launchPath = cmd
        task.arguments = args
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe
        
        task.launch()

        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: outdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            output = string.components(separatedBy: "\n")
        }
        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: errdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            error = string.components(separatedBy: "\n")
        }


        task.waitUntilExit()
        let status = task.terminationStatus
//        print(output, error, status)
        return output
    }
    
    
}

