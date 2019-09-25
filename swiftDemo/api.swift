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
    case login
}

extension XQCApi:TargetType {
    public var baseURL: URL {
        return URL.init(string: "http://172.16.4.4/api")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/api-app/setting/getAppVersion"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        return .requestData(jsonToData(jsonDic: ["appVersion": "1.1.0" , "appSysType": "2"], targetType: .login)!)
    }
    
    public var headers: [String : String]? {
        let header = ["Content-Type" : "application/json; charset=utf-8;text/json;text/javascript;text/html;text/plain;text/html;"]
        return header
    }
    
}


//------------------------
//字典转Data
private func jsonToData(jsonDic:Dictionary<String, Any>,targetType: XQCApi) -> Data? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        print("is not a valid json object")
        return nil
    }
    //利用自带的json库转换成Data
    //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    //Data转换成String打印输出
    let str = String(data:data!, encoding: String.Encoding.utf8)
    //输出json字符串
    print("\(targetType)->Json Str:\(str!)")
    return data
}
