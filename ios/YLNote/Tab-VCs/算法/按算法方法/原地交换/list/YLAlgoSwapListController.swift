//
//  YLAlgoSwapListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoSwapListController: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -  448. 找到所有数组中消失的数字
    // 链接：https://leetcode.cn/problems/find-all-numbers-disappeared-in-an-array/description/
    @objc func sw_findDisappearedNum() {
        let res = findDisappearedNumbers([1,3,4,3]);
        print("🌹中消失的数字：\(res)");
    }
    
    /// 原地交换
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var nums = nums
        var res:[Int] = []
        
        for i in 0..<nums.count {
            while nums[i] != nums[nums[i]-1] {
                nums.swapAt(i, nums[i]-1)
            }
        }
        
        for i in 0..<nums.count {
            if nums[i] != i+1 {
                res.append(i+1)
            }
        }
        return res
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_swap_list"
    }

}
