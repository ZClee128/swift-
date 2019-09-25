//
//  ViewController.swift
//  swiftDemo
//
//  Created by lee on 2019/9/24.
//  Copyright © 2019 lee. All rights reserved.
//

import UIKit
import RxSwift
import RxMoya


class ViewController: UIViewController {
    
    let dispose = DisposeBag()
    let myviewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        XQCProvider.rx.request(.login)
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//            .subscribe(onSuccess: { (result) in
//                print(result)
//            }) { (err) in
//                print(err)
//        }.disposed(by: dispose)
        
//        XQCProvider.rx.request(.login)
//        .asObservable()
//        .mapJSON()
//            .subscribe(onNext: { (result) in
//                print(result)
//            }, onError: { (err) in
//                print(err)
//            }).disposed(by: dispose)
        
        myviewModel.getPosts().subscribe(onNext: { (model) in
            print(model.toJSONString()!)
        }, onError: { (err) in
            print(err)
            }).disposed(by: dispose)
        
    }
    
    
}

