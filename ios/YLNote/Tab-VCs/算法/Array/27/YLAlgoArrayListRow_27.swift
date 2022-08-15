//
//  YLAlgoArrayListRow_27.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 62. 圆圈中最后剩下的数字

 0,1,···,n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字（删除后从下一个数字开始计数）。求出这个圆圈里剩下的最后一个数字。

 例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。

  
 https://leetcode.cn/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/
 */
class YLAlgoArrayListRow_27: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let res = lastRemaining(5, 3)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，
    /// 空间复杂度：O(1)
    /// - Parameter target: target
    /// - Returns: []
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        var res = 0
       for i in 2...n {
           res = (res+m)%i
       }
       return res

    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_27"
    }
    
}
