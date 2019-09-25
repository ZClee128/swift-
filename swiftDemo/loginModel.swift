//
//  loginModel.swift
//  swiftDemo
//
//  Created by lee on 2019/9/25.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import ObjectMapper

class loginModel: Mappable {
    var appVersion: String?
    var fileUrl: String?
    var renewDesc: String?
    var appSysType: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        appSysType <- map["appSysType"]
        appVersion <- map["appVersion"]
        renewDesc <- map["renewDesc"]
        fileUrl <- map["fileUrl"]
    }
}
