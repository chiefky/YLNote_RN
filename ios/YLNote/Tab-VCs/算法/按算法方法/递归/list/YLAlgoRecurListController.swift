//
//  YLAlgoRecurListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoRecurListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode108. 将有序数组转换为二叉搜索树
    @objc func recur_sortedArrayToBST() {
        let nums = [-10,-3,0,5,9]
        let root = sortedArrayToBST(nums)
        let res = root?.binaryTreeDescription()
        print("二叉树：\(res)")
    }
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else {
            return nil
        }
           let mid = nums.count/2
           let root = TreeNode(nums[mid])
           let left_nums:[Int] = Array(nums[0..<mid])
           let right_nums:[Int] = Array(nums[mid+1..<nums.count])
           root.left = sortedArrayToBST(left_nums)
           root.right = sortedArrayToBST(right_nums)
           return root;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_recur_list"
    }

    
}
