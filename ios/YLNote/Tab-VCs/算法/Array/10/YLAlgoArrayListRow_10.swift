//
//  YLAlgoArrayListRow_10.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。
 你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。
 返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/best-time-to-buy-and-sell-stock
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
