//
//  YLAlgoArrayListRow_3.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个 升序排列 的数组 nums ，请你 原地 删除重复出现的元素，使每个元素 只出现一次 ，返回删除后数组的新长度。元素的 相对顺序 应该保持 一致 。
 由于在某些语言中不能改变数组的长度，所以必须将结果放在数组nums的第一部分。更规范地说，如果在删除重复项之后有 k 个元素，那么 nums 的前 k 个元素应该保存最终结果。
 将最终结果插入 nums 的前 k 个位置后返回 k 。
 不要使用额外的空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。

 来源：力扣（LeetCode）
 链接: https://leetcode.cn/problems/remove-duplicates-from-sorted-array/
 */

class YLAlgoArrayListRow_3: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func testMethod_1() {
        var array = [1]//[0,0,1,1,1,2,2,3,3,4]
        let res = method_1(&array);
        print("结果：\(res)")
    }
    
    /// 利用游标，修改游标指向的元素将后置重复元素提前，最后删除游标后面的所有元素
    /// - Parameter nums: 任意排序好的数组
    /// - Returns: 有效数组长度
    func method_1(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count;
        }
        var lenth = 0
        for i in 1...nums.count-1 {
            if nums[lenth] != nums[i] {
                lenth += 1;
                nums[lenth] = nums[i];
            }
            print("\(i):\(nums)");
        }
        nums.removeSubrange(lenth+1..<nums.count)
        return nums.count
    }
    
    /// 快慢指针
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func method2(_ nums: inout [Int]) -> Int {
        return 0
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_3"
    }
}
