//
//  YLAlgoBitListRow_5.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 65. 不用加减乘除做加法
 写一个函数，求两个整数之和，要求在函数体内不得使用 “+”、“-”、“*”、“/” 四则运算符号。

 https://leetcode.cn/problems/bu-yong-jia-jian-cheng-chu-zuo-jia-fa-lcof/
 */


class YLAlgoBitListRow_5: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = add(20, 17)
        print("🍎1：\(res)")
    }

    func add(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        
        while b != 0 {
            print("a,b:[\(String(a,radix: 2)), \(String(b,radix: 2))]")
            let c = (a & b) << 1;
            print("c: \(String(c,radix: 2))")
            a ^= b
            b = c
            print("a,b:[\(String(a,radix: 2)), \(String(b,radix: 2))]")
        }
        return a;
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_5"
    }
}
