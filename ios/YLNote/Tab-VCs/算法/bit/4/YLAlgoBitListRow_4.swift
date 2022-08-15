//
//  YLAlgoBitListRow_4.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 15. 二进制中1的个数
 编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为 汉明重量).）。
 
 https://leetcode.cn/problems/er-jin-zhi-zhong-1de-ge-shu-lcof/
 */


class YLAlgoBitListRow_4: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = method_1(128)
        print("🍎1：\(res)")
    }
    
    
    /// 时间复杂度：O(1), 空间复杂度： O(1)。
    /// - Parameter num: num description
    /// - Returns: description
    func method_1(_ n:Int) -> Int {
        var x = n, res = 0
        while x != 0 {
            let tmp = x&1
            res += tmp
            x >>= 1
        }
        return res;
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_4"
    }
}
