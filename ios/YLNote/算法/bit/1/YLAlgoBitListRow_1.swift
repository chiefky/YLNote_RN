//
//  YLAlgoBitListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为汉明重量）。
 
 提示：
 请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
 在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在上面的 示例 3 中，输入表示有符号整数 -3。
  

 示例 1：
 输入：00000000000000000000000000001011
 输出：3
 解释：输入的二进制串 00000000000000000000000000001011 中，共有三位为 '1'。


 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/number-of-1-bits
 
 */


class YLAlgoBitListRow_1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = method_1(25)
        print("🍎1：\(res)")

    }
    
    
    /// 时间复杂度：O(log n), 空间复杂度： O(1)。
    /// - Parameter num: <#num description#>
    /// - Returns: <#description#>
    func method_1(_ num:Int) -> Int {
        var count = 0, number = num
        while number != 0 {
            count += (number & 1)
            number >>= 1
        }
        return count
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_1"
    }
}
