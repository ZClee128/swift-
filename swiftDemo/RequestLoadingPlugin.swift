//
//  RequestLoadingPlugin.swift
//  swiftDemo
//
//  Created by lee on 2019/9/24.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import Moya
import Result
import ObjectMapper
import Foundation
import RxSwift
/// 数据 转 模型
//extension ObservableType where E == Response {
//    public func mapModel<T: HandyJSON>(type: T.Type)->Observable<T> {
//        return flatMap { response -> Observable<T> in
//            return Observable.just(response.mapModel(T.self))
//        }
//    }
//}
///// 数据 转 模型
//extension Response {
//    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
//        let json = JSON(data)["result"].dictionaryObject
//        return JSONDeserializer<T>.deserializeFrom(dict: json)!
//    }
//}


class RequestLoadingPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mRequest = request
        mRequest.timeoutInterval = 20
        return mRequest
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("开始请求-------\(request)")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("结束请求--------\(target)")
        switch result {
        case .success(let response):
            print(String(data: response.data, encoding: .utf8)!)
            break
        case .failure(_):
            break
        }
    }
}


extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            if let error = self.parseError(response: dict) {
                throw error
            }
   
             
            return Mapper<T>().map(JSON: dict["data"] as! [String : Any])!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
    
    func parseServerError() -> Observable {
        return self.map { (response) in
            let name = type(of: response)
            print(name)
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            return self as! Element
        }
    }
    
    fileprivate func parseError(response: [String: Any]?) -> NSError? {
        var error: NSError?
        if let value = response {
            var code:Int?
            var msg:String?
            if let errorDic = value["error"] as? [String:Any]{
                code = errorDic["code"] as? Int
                msg = errorDic["msg"] as? String
                error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey: msg ?? ""])
            }
        }
        return error
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}
extension RxSwiftMoyaError: Swift.Error {}
