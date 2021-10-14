//
//  ViewController.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/12/21.
//

import Cocoa
import Foundation

class ViewController: NSViewController {
    var listOfPRInstances = [] as [PRInstance]

    override func viewWillAppear() {
        DispatchQueue.global(qos: .userInitiated).async {
            while(true){
                self.getBuildStatus()
                sleep(30)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            while(true){
                self.reRenderPrIcons()
                sleep(1)
            }
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
        print("hello world")
    }
    
    func reRenderPrIcons(){
        var side = "LEFT"
        for prInstance in self.listOfPRInstances {
            DispatchQueue.main.async {
                let wc : WindowController = self.view.window?.windowController as! WindowController
                wc.updateStatus(pRBuild: prInstance, side: side)
                side = side == "LEFT" ? "RIGHT" : "LEFT"
             }
        }
        print("ReRendering...")
    }
    
//    func getGitApiToken(){
//        runCommand(cmd:"/usr/bin/env", args: ["zsh", "-c", "-i","-l","/usr/bin/env"])
//    }
//
    
    func getBuildStatus(){
        let bundle = Bundle.main
        let path = bundle.path(forResource: "GoGoMrJenkins-1.0", ofType: "jar")!
        let builds = runCommand(cmd: "/usr/bin/java", args: ["-jar", path, "", "check-build"])
        
        var newPRList = [] as [PRInstance]
        for build in builds{
            let pr = build.split(separator: "|")
            print(pr)
            if(pr.count<=3) {continue}
            let prInstance = PRInstance(serviceName: String(pr[0]), prNumber: String(pr[1]), status: String(pr[2]), buildURL: String(pr[3]))
            newPRList.append(prInstance)
        }
        self.listOfPRInstances = newPRList
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

