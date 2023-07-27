//
//  YLDelegateModel.swift
//  YLNote
//
//  Created by tangh on 2023/7/23.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

struct YLDelModel {
    var name: String = "张思"
    var age: Int = 19
    var gender: String = "男"
    
    func sayHello() {
        print("hello")
    }
    
    func sayEnglish() {
        print("I'm from England")
    }
}

extension YLDelModel: YLDemoProtocol {
    func testFather(name: String) -> String {
        print("pppppp")
        return "YLDelegateModel"
    }
}

class YLDelClassModel {
    var name: String = "李秀丽"
    var age: Int = 22
    var gender: String = "女"
    func sayHello() {
        print("hello")
    }
}

extension YLDelClassModel {
    func sayEnglosh() {
        print("\(YLDelClassModel.self)")
    }
}
