//
//  YLAlgoArrayListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 61. 扑克牌中的顺子
 从若干副扑克牌中随机抽 5 张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。

 示例 1:
 输入: [1,2,3,4,5]
 输出: True
  

 示例 2:
 输入: [0,0,1,2,5]
 输出: True
 https://leetcode.cn/problems/bu-ke-pai-zhong-de-shun-zi-lcof/
 */

class YLAlgoArrayListRow_1: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func testArrayisContinuous() {
        let array = [1,3,3,4,2,5]//[11,13,12,0,0]
        let res = method_1(array);
        print("结果：\(res)")
    }
    
    /// 对排序后的非零数组,计算前后元素差值,
    /// 差值>=2:用可用的0补充，如果不够补就是false,够补 continue
    /// 差值==0: false
    /// 差值==1：continue
    /// - Parameter arr: 原始数组
    /// - Returns: 元素是否连续
    func method_1(_ arr:[Int]) -> Bool {
        let num_arry = arr.filter {$0 != 0} // 筛选非0数组
        let sorr_arr = num_arry.sorted { $0 > $1 } // 对非0数组排序
        var zero_count = arr.count - sorr_arr.count // 0的个数
        for i in 0...sorr_arr.count-2 {
            let dis = sorr_arr[i] - sorr_arr[i+1]
//            print("(num[i]:\(sorr_arr[i]),num[i+1]:\(sorr_arr[i+1])),\(dis),\(zero_count)")
            if dis == 0 { // dis == 1
                return false
            } else if dis == 1 { // dis == 1
                continue;
            } else  { // dis >= 2
                zero_count -= (dis-1);
                if zero_count >= 0 {
                    continue
                } else {
                    return false;
                }
            }
        }
        return true;
    }
    
    /// 判断一个数组是否是连续的（不可用补0代替）
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func method_test(_ nums:[Int]) -> Bool {
        guard nums.count > 1 else {
            return false
        }
        let sorted = nums.sorted()
        for i in 1...sorted.count-1 {
            let distance = abs(sorted[i] - sorted[i-1])
            if distance != 1 {
                return false;
            }
        }
        return true
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_1"
    }
}
