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
    // MARK: LeetCode 4. 剑指 Offer 24. 反转链表
    @objc func recur_reverseListNode() {
        let linkList = LinkList()
        for i in [1,2,3,4] {
            linkList.append(value: i)
        }
        
        var head = reverseListNode(linkList.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print("⛓⛓⛓:",str)
    }
    
    func reverseListNode(_ head:ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let newHead = reverseListNode(head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    
    // MARK: LeetCode 5. 剑指 Offer 25. 合并两个排序的链表
    @objc func recur_mergeTwoLists() {
        let l1 = LinkList()
        for i in [1,2,4] {
            l1.append(value: i)
        }
        let l2 = LinkList()
        for i in [1,3,4] {
            l2.append(value: i)
        }
        
        var head = mergeTwoLists(l1.first, l2.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print("⛓⛓⛓:",str)
    }
   
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode?{
        var head:ListNode? = nil
        
        if let l1 = l1,let l2 = l2 {
            if l1.val <= l2.val {
                head = l1
                head?.next = mergeTwoLists(l1.next, l2)
            } else {
                head = l2
                head?.next = mergeTwoLists(l1, l2.next)
            }
        } else {
            return l1 != nil ? l1 : l2
        }
        return head
    }
    // MARK: LeetCode
    // MARK: 10. LeetCode108. 将有序数组转换为二叉搜索树
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
    
    // MARK: 12. 剑指 Offer 28. 对称的二叉树
    @objc func recur_isSymmetric() {
        let A =  [1,2,2,3,4,4,3]
        let root = TreeNode.from(A, 0)
        let res = recur_isSymmetric(root)
        print("🌲\(A) 是对称二叉树: \(res)")
    }
    
    /// 递归
    /// 时间复杂度：O(n)；空间复杂度：O(h),最差退化成链表O(n)
    /// - Parameter root:
    /// - Returns: 是否对象
    func recur_isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        return recur_check(left: root.left, right: root.right)
    }
    
    func recur_check(left:TreeNode?,right: TreeNode? ) -> Bool {
        guard let left = left,let right = right else {
            return left === right
        }

        if left.val != right.val {return false}
        let res_l = recur_check(left: left.right, right: right.left)
        let res_r = recur_check(left: left.left, right: right.right)
        return res_l && res_r
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_recur_list"
    }

    
}
