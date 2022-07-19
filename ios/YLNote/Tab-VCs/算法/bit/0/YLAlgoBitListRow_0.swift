//
//  YLAlgoBitListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。
 如果存在一个整数 x 使得 n == 2^x，则认为 n 是 2 的幂次方。

 示例 1：
 输入：n = 1
 输出：true
 解释：20 = 1

 链接：https://leetcode.cn/problems/power-of-two
 */


class YLAlgoBitListRow_0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = method_1(32)
        print("🍎1：\(res)")

    }
    
    ///
    /// 一个数 n 是 2 的幂，当且仅当 n 是正整数，并且 n 的二进制表示中仅包含 1 个 1。如：16--> 10000 & 1111
    /// - Parameter num: <#num description#>
    /// - Returns: <#description#>
    func method_1(_ num:Int) -> Bool {
        return num == 0 ? false : (num & (num-1) == 0)
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_0"
    }
}
