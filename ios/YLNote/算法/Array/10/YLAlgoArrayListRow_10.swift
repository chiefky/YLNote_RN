//
//  YLAlgoArrayListRow_10.swift
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

class YLAlgoArrayListRow_10: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let arr = [7,6,4,3,1]//[7,1,5,3,6,4];
        let res = method_1(arr)
        
        print("结果：\(res)")
    }
    
    /// 暴力法（超时）
    /// - Parameter prices: <#prices description#>
    /// - Returns: <#description#>
    func method_1(_ prices: [Int]) -> Int {
        var res = 0
        if prices.count <= 1 {
            return res
        }
        
        var preMax = 0
        
        for i in 0...prices.count-1 {
            var j = prices.count - 1
            while j > i {
                preMax = prices[j] - prices[i];
                res = max(preMax, res)
                j -= 1
            }
        }
        
        return res
    }
    
    @objc func testMethod_2() {
        let arr = [7,1,5,3,6,4];
        let res = method_2(arr)
        print("结果：\(res)")
    }
    func method_2(_ prices: [Int]) -> Int {
          if prices.count <= 1 { return 0}
          var res = 0;
          var minValue = prices[0];
          for i in 0...prices.count-1 {
              if prices[i] < minValue {
                  minValue = prices[i]
              } else if (prices[i] - minValue > res) {
                  res = prices[i] - minValue
              }
          }
          return res
      }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_10"
    }
    
}
