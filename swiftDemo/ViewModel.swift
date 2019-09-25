//
//  ViewModel.swift
//  swiftDemo
//
//  Created by lee on 2019/9/25.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import Moya
import RxSwift


class ViewModel: NSObject {
    
    func getPosts() -> Observable<loginModel> {
        return XQCProvider.rx.request(.login).filterSuccessfulStatusCodes().asObservable().mapJSON().mapObject(type: loginModel.self)
    }
    
    func uploadimag(images: Data) -> Observable<Any> {
        return XQCProvider.rx.request(.uploadImage(data: images)).filterSuccessfulStatusCodes().asObservable().mapJSON()
    }
}
