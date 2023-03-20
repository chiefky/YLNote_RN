//
//  YLAlgoArrayListRow_20.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。
 
 示例 1:
 
 输入: n = 1
 输出: [1,2,3,4,5,6,7,8,9]
  
 
 说明：
 
 用返回一个整数列表来代替打印
 n 为正整数
 
 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof
 */
class YLAlgoArrayListRow_20: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = printNumbers(3)
        print("🍎结果：\(res)")
    }
    
    var res:[Int] = []
    /// 时间复杂度：O(10^n)，空间复杂度：O(10^n)
    /// 其中n指的是递归的深度，每一层递归的时间复杂度是O(10)；
    /// 空间复杂度，结果列表 resresres 的长度为10^n - 1，各数字字符串的长度区间为 1,2,...n ，因此占用 O(10^n)大小的额外空间。
    func printNumbers(_ n: Int) -> [Int] {
        var bits:[Character] = Array(repeating: "0", count: n);// 构建一个n位数，每位全排列，去掉值为0的数就是结果
        dfs_sort(&bits, 0);// 从第0位开始排列，每拍好一个往res数组里插一个
        return res;
    }
    
    /// 深度遍历/全排列
    let base:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    func dfs_sort(_ chars: inout [Character], _ index:Int) {
        if index == chars.count {
            let numStr = String(chars)
            if let num = Int(numStr), num != 0 {
                res.append(num)
            }
            return;
        }

        for i in base {
            chars[index] = i
            dfs_sort(&chars, index+1)
        }
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_20"
    }
    
}
