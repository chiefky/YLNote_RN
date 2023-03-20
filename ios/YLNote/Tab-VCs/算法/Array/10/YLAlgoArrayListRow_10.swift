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
        let res = maxProfit(arr)
        
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// 遍历过程中找最低买入价格，比较先前记录利润与当前利润的大小
    func maxProfit(_ prices: [Int]) -> Int {
         var maxValue = 0
         var inPrice = prices[0]
         for price in prices {
             inPrice = min(inPrice,price)
             maxValue = max(maxValue,price-inPrice)
         }
         return maxValue;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_10"
    }
    
}
