//
//  api.swift
//  swiftDemo
//
//  Created by lee on 2019/9/24.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import Moya


let XQCProvider = MoyaProvider<XQCApi>(plugins: [RequestLoadingPlugin()])


enum XQCApi {
    case login;
    case uploadImage(data: Data);
}

extension XQCApi:TargetType {
    public var baseURL: URL {
        return URL.init(string: "http://127.0.0.1:8080")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/Login"
        case .uploadImage(_):
            return "/api-oss/oss/uploadToFolder"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        let apiTask = ApiTask()
        switch self {
        case .login:
            return apiTask.login()
        case .uploadImage(let images):
            return apiTask.uploadImage(image: images)
        }
    }
    
    public var headers: [String : String]? {
        let header = ["Content-Type" : "application/json; charset=utf-8;text/json;text/javascript;text/html;text/plain;text/html;"]
        return header
    }
    
}



