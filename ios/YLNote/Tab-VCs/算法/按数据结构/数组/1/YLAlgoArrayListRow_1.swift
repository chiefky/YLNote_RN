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
        let res = isStraight(array);
        print("结果：\(res)")
    }
    
    /// 遍历五张牌，遇到大小王（即 000 ）直接跳过。
    /// 判别重复： 利用 Set 实现遍历判重， Set 的查找方法的时间复杂度为 O(1)O(1)O(1) ；
    /// 获取最大 / 最小的牌： 借助辅助变量 mamama 和 mimimi ，遍历统计即可。
    /// 复杂度分析：
    /// 时间复杂度 O(N)=O(5)=O(1)O(N) = O(5) = O(1)O(N)=O(5)=O(1) ： 其中 NNN 为 numsnumsnums 长度，本题中 N≡5N \equiv 5N≡5 ；遍历数组使用 O(N)O(N)O(N) 时间。
    /// 空间复杂度 O(N)=O(5)=O(1)O(N) = O(5) = O(1)O(N)=O(5)=O(1) ： 用于判重的辅助 Set 使用 O(N)O(N)O(N) 额外空间。

    /// - Parameter nums: 参数
    /// - Returns: 是否为顺子
    func isStraight(_ nums:[Int]) -> Bool {
     var numsSet = [Int]()
     var ma = 0, mi = 14;
     for num in nums {
     if num == 0 {
     continue;
     }
     ma = max(ma, num)
     mi = min(mi,num);
     if numsSet.contains(num) {
         return false ;
     }
     numsSet.append(num)
     }
        return ma - mi < 5
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_1"
    }
}
