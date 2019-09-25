//
//  Task.swift
//  swiftDemo
//
//  Created by lee on 2019/9/25.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import Moya

class ApiTask: NSObject {
    func login() -> Task{
        return Moya.Task.requestData(jsonToData(jsonDic: ["appVersion": "1.1.0" , "appSysType": "2"], targetType: .login)!)
    }
    
    func uploadImage(image: Data) -> Task {
        return Moya.Task.uploadCompositeMultipart([MultipartFormData(provider: .data(image), name: "file", fileName: "xx.jpg", mimeType: "image/jpeg")], urlParameters: ["folder":"xqc/doc/image"])
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
