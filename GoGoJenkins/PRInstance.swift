//
//  PRInstance.swift
//  GoGoJenkins
//
//  Created by Lucy Zhan on 10/13/21.
//

import Cocoa

struct PRInstance {
    var serviceName: String
    var prNumber: String
    var status: String
    var buildURL: String
    
    init(serviceName: String, prNumber: String, status: String, buildURL: String) {
        self.serviceName = serviceName
        self.prNumber = prNumber
        self.status = status
        self.buildURL = buildURL
    }
}
