//
//  YLSwift-OCViewController.swift
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
// MARK: 在swift中使用OC
class YLOC_in_SwiftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "在swift中使用OC"

        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
       
        testOCClass()
        testDifferenceSwift_OCPro()
        testDynamicKeyWord()
    }
    
    /// 在swift中使用OC类
    func testOCClass() {
        // 1.类使用
        let pig = PinkPigOC()
        // 2.1 方法使用1
        pig.sayHello()
        
        // 2.2 方法使用2
        let selector = NSSelectorFromString("showCard")
        if pig.responds(to: selector) {
            pig.perform(selector)
        }
         
        // 3. 属性
        let name = pig.name
        print("name:\(name)");
    }
    
    /// 注意swift类中继承的属性,不重写不会继承@objc特性
    func testDifferenceSwift_OCPro() {
        print("*************🐷 所有属性：")
        printPropertyName(of: PinkPigOC.self)
        printPropertyName(of: PinkPigSwift.self)
        printPropertyName(of: PinkPigSwiftSon.self)
        print("*************🐷.")
    }
    // MARK: - 在swift中使用swift类，保证 Swift 类中的 API 在swift类中 也是运行时调用的。 (KVO)
    var pkSon = PinkPigSwiftSon()
    func testDynamicKeyWord() {
        pkSon.addObserver(self, forKeyPath: "name",options: [.new,.old], context: nil)
        pkSon.addObserver(self, forKeyPath: "age",options: [.new,.old], context: nil)
        pkSon.addObserver(self, forKeyPath: "clothes",options: [.new,.old], context: nil)
        pkSon.name = "🐒"
        pkSon.age = 8
        pkSon.clothes = "👘"
        pkSon.introduction()
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
                print("KVO \(keyPath ?? "") old: \(change?[.oldKey] ?? "")")
                print("KVO \(keyPath ?? "") new: \(change?[.newKey] ?? "")")
    }

    deinit {
        pkSon.removeObserver(self, forKeyPath: "name")
        pkSon.removeObserver(self, forKeyPath: "age")
        pkSon.removeObserver(self, forKeyPath: "clothes")

    }
    
    func printPropertyName(of cls: AnyClass) {
        /** 记录属性个数 */
        var propertyCount: UInt32 = 0
        /** 获取所有属性 */
        guard let propertyList = class_copyPropertyList(cls, &propertyCount) else {
            return
        }
        /** 遍历所有属性 */
        var allPro = "\(cls): "
        for index in 0..<numericCast(propertyCount) {
            let property: objc_property_t = propertyList[index]
            /** 获取属性名 */
            if let propertyName = String(utf8String: property_getName(property)) {
                let punctuation = index == propertyCount - 1 ? "." : "," ;
                allPro += propertyName + punctuation + " "
            }
        }
        print(allPro)
        
// 在swift文件中，使用了C语言函数的create\copy\malloc，不需要手动写CFRelease(source)、free()之类的了。
//        free(propertyList)
    }


}
