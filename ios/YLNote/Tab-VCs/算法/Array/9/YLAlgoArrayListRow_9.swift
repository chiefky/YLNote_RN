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
        
        let arr = method_1(5);
        print("结果：\(arr)")
    }
    
    func method_1(_ numRows: Int) -> [[Int]] {
        if numRows == 0 {
            return []
        }
        var res:[[Int]] = []
        for i in 0...numRows-1 {
            res.append(getLine(i))
        }
        return res
    }
    
    func getNum(_ i: Int, _ n:Int) -> Int {
        if n == 0 || i == 0 || i == n {
            return 1
        }
        let res = getNum(i, n-1) + getNum(i-1, n-1)
        return res
    }
    
    func getLine(_ n:Int) -> [Int] {
        var res = [Int]()
        for i in 0...n {
            res.append(getNum(i, n))
        }
        return res
    }
    
    @objc func testMethod_2() {
        
        let arr = getRow(4);
        print("结果：\(arr)")
    }
    
    /// 巧妙利用二维数组，一维先全部用1组成的数组填充，然后二维修改一维内部的具体元素
    /// - Parameter numRows: 第几行
    /// - Returns: 前n行的组成元素
    func method_2(_ numRows: Int) -> [[Int]] {
        if numRows == 0 {
            return []
        }
        
        var a:[[Int]] = []
        for i in 0...numRows-1 {
            var tmp = [Int](repeating: 1, count: i+1)
            if i>1 {
                for j in 0...i {
                    if j==0 || j==i {
                        tmp[j] = 1;
                    } else {
                        let preLine = a[i-1];
                        tmp[j] = preLine[j] + preLine[j-1];
                    }
                }
            }
            // print("\(tmp)");
            a.append(tmp)
        }
        return a
    }
    
    /// 打印杨辉三角第i行
    /// - Parameter rowIndex: <#rowIndex description#>
    /// - Returns: <#description#>
    func getRow(_ rowIndex: Int) -> [Int] {
        if (rowIndex < 0) {return []};
        var a = [[Int]]()
        for i in 0...rowIndex {
            var tmp = [Int](repeating:1 ,count:i+1)
            if (i > 1) {
                for j in 1..<i {
                    let preLine = a[i-1]
                    tmp[j] = preLine[j-1] + preLine[j];
                }
            }
            a.append(tmp)
        }
        return a[rowIndex];
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_9"
    }
    
}
