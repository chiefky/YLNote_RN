//
//  YLAlgoTreeListRow_10.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 33. 二叉搜索树的后序遍历序列
 
 输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历结果。如果是则返回 true，否则返回 false。假设输入的数组的任意两个数字都互不相同。

 链接：https://leetcode.cn/problems/er-cha-sou-suo-shu-de-hou-xu-bian-li-xu-lie-lcof/?favorite=xb9nqhhg
 */
class YLAlgoTreeListRow_10: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr1 = [1,2,5,10,6,9,4,3]
        let res = verifyPostorder(arr1)
        print("🌲：\(res)");

    }
    
    func verifyPostorder(_ postorder: [Int]) -> Bool {
         return verify_recursion(postorder, 0, postorder.count-1)
     }
    
    /// 分治递归
    /// - Parameters:
    ///   - array: <#array description#>
    ///   - i: <#i description#>
    ///   - j: <#j description#>
    /// - Returns: <#description#>
     func verify_recursion(_ array:[Int],_ i:Int, _ j: Int) -> Bool {
         guard i < j else {
             return true;
         }
         var p = i
         while array[p] < array[j] {
             p += 1;
         }

         let m = p
         while array[p] > array[j] {
             p += 1
         }
         let left_res = verify_recursion(array,i,m-1)// 左子树是后续遍历
         let right_res = verify_recursion(array,m,j-1) // 右子树是后续遍历
         return p == j && left_res && right_res // 本树 && 左子树 && 右子树
     }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_10"
    }

}

