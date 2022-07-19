//
//  YLSwiftTViewController.swift
//  YLNote
//
//  Created by tangh on 2022/4/28.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLSwiftTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        testStack()
    }
    
    func swapTwoValue<R>(_ a: inout R, _ b: inout R) {
        let tmp = a
        a = b
        b = tmp
    }

    func testStack() {
        var strs = Stack<String>()
        print(">>>>字符串元素入栈: ")
        strs.push("google")
        strs.push("runoob")
        print(strs.items);
         
        let deletetos = strs.pop()
        print("<<<<出栈元素: " + deletetos)
        print(strs.items);

    }
    
    func testSwap() {
        var numb1 = "哈喽"
        var numb2 = "200"
         
        print("交换前数据:  \(numb1) 和 \(numb2)")
        swapTwoValue(&numb1, &numb2)
        print("交换后数据: \(numb1) 和 \(numb2)")
        
    }
}

// MARK: 泛型--栈
struct Stack<T> {
    var items:[T] = []
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

extension Stack {
    var top: T? {
        return items.isEmpty ? nil : items.last
    }
}

// Container 协议关联类型 ItemType
protocol Container {
    associatedtype ItemType
    // 添加一个新元素到容器里
    mutating func append(_ item: ItemType)
    // 获取容器中元素的数
    var count: Int { get }
    // 通过索引值类型为 Int 的下标检索到容器中的每一个元素
    subscript(i: Int) -> ItemType { get }
}


