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
    
    @objc func testMethod_2() {
        let res = printNumbers_dfs(2)
        print("🍎结果：\(res)")
    }
    

    
    func printNumbers(_ n: Int) -> [Int] {
        guard n > 0 else { return []}
        if n == 1 {
            return [1,2,3,4,5,6,7,8,9]
        } else {
            let preRes = printNumbers(n-1)
            var res:[Int] = preRes
            let startNum = (pow(10, n-1) as NSDecimalNumber).intValue
            let length = startNum * 9
            for i in 0..<length {
                let num = startNum + i
                res.append(num)
            }
            return res
        }
    }
    
    var res:[Int] = []
    func printNumbers_dfs(_ n: Int) -> [Int] {
        let array = Array(repeating: 0, count: n) // [0,0,0]
        dfs(n, 0, array)
        return res
    }
    
    func dfs(_ n:Int, _ idx: Int,_ numChars: [Int]) {
        var chars = numChars
        if idx == n {
            let str = chars.reduce("") { (partialResult, char) in
               return partialResult + String(char)
            }
            if let num = Int(str) {
                res.append(num)
            }
            return
        }
        for char in 0...9 {
            chars[idx] = char
            dfs(n, idx+1, chars)
        }
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_20"
    }
    
}
