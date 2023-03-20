//
//  YLAlgoArrayListRow_23.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 面试题40. 最小的k个数
 输入整数数组 arr ，找出其中最小的 k 个数。例如，输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。

 示例 1：
 输入：arr = [3,2,1], k = 2
 输出：[1,2] 或者 [2,1]
 
 示例 2：
 输入：arr = [0,1,2,1], k = 1
 输出：[0]

 限制：
 0 <= k <= arr.length <= 10000
 0 <= arr[i] <= 10000
 
 */
class YLAlgoArrayListRow_23: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let arr = [0,1,2,1], k = 1
        let res = getLeastNumbers(arr,k)
        print("🍎结果：\(res)")
    }

    /// 时间复杂度：O(n*logn)；空间复杂度：O(logn)
    /// 快排
    func getLeastNumbers(_ arr:  [Int], _ k: Int) -> [Int] {
        guard k > 0 else { return [] } // 排除k=0的情况，省去排序操作
        if k >= arr.count {
            return arr;
        }
        var nums = arr
        quickSort(&nums, 0, nums.count-1, k)
        return Array(nums[0..<k]);
    }
    
    /// 时间复杂度：O(n*logn)；空间复杂度：O(logn)
    /// 递归次数：logn
    /// 每次递归都需要遍历n个数
    /// 优化后的快排
    func quickSort(_ arr: inout [Int],_ low:Int,_ high:Int, _ k: Int) {
        guard low < high else { return }
        var l = low,r = high;
        while l<r {
            // arr[low]作哨兵对象
            while l<r,arr[r] >= arr[low] {
                r -= 1;
            }
            while l<r,arr[l] <= arr[low] {
                l += 1;
            }
            arr.swapAt(l, r);
        }
        arr.swapAt(low, l); // 哨兵对象将数组划分为两部分，左侧都小于哨兵对象，右侧都大于哨兵对象
        if k < l {
            quickSort(&arr, low, l-1, k)
        }
        if k > l {
            quickSort(&arr, l+1, high, k)
        }
    }
        
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_23"
    }
    
}
