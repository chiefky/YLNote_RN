//
//  YLAlgoArrayListRow_9.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。
 在「杨辉三角」中，每个数是它左上方和右上方的数的和。
  
 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/pascals-triangle/
 
 */

class YLAlgoArrayListRow_9: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr = generate(5);
        print("结果：\(arr)")
    }
    
    /// 巧妙利用二维数组，一维先全部用1组成的数组填充，然后二维修改一维内部的具体元素
    /// 时间复杂度：O(n^2)， 空间复杂度：O(1)
    /// - Parameter numRows: 第几行
    /// - Returns: 前n行的组成元素
    func generate(_ numRows: Int) -> [[Int]] {
        var res:[[Int]] = []
        for i in 0..<numRows {
            var tmp = [Int](repeating: 1, count: i+1)
            var j = 1
            while j < i {
                let preLine = res[i-1]
                tmp[j] = preLine[j-1] + preLine[j];
                j += 1
            }
            // print("\(tmp)");
            res.append(tmp)
        }
        return res
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_9"
    }
    
}
