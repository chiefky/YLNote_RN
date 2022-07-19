//
//  YLAlgoArrayListRow_8.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。
 请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。
 注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/merge-sorted-array
 */

class YLAlgoArrayListRow_8: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        var array = [3,7]
        let arr2 = [1,2,8,9]
        
        method_1(&array,2,arr2,4);
        print("结果：\(array)")
    }

    func method_1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n == 0 {
            return;
        }
        if m == 0 {
            nums1 = nums2;
            return;
        }
        var r1 = m-1
        var r2 = n-1
        var cur = m+n-1
        
        while r1>0 && r2>0 {
            if nums2[r2] >= nums1[r1] {
                nums1[cur] = nums2[r2];
                r2 -= 1;
            } else {
                nums1[cur] = nums1[r1];
                r1 -= 1;
            }
            cur -= 1;
        }
        while r2 > 0 {
            nums1[cur] = nums2[r2];
            r2 -= 1;
            cur -= 1;
        }
        
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_8"
    }
  
}
