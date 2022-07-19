//
//  PinkPigSwift.swift
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

/// 父类
class PinkPigSwift: NSObject {
    @objc var name:String = "tangh"
    @objc var gender:String = "male"
    @objc dynamic var age:Int = 32
    
    func showCard() {
        print("No.20090919");
    }
    
    @objc func sayHello() {
        print("Hello, My name is \(self)")
    }
    
    @objc func introduction()  {
        print("\(name): gender:\(gender),age:\(age)")
    }
}

// 父类的扩展（不可添加存储属性）
extension PinkPigSwift {
    var type: String {
        return "swift"
    }
}

/// 子类
class PinkPigSwiftSon: PinkPigSwift {
    // 只有重写后才能继承父类的 @objc 特性，不重写不能继承
    override var age: Int {
        set {
            super.age = newValue
        }
        get {
            return super.age
        }
    }
    
    @objc var clothes: String = "👗"
    
}

@objcMembers class KittenSwift {
    var name:String = "yingj"
    var gender:String = "female"
    var age:Int = 32
}

class MyClass {
  dynamic func foo() { }       // error: 'dynamic' method must be '@objc'
  @objc dynamic func bar() { } // okay
}

