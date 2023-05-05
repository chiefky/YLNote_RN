//
//  YLAlgoBitListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 面试题16. 数值的整数次方（快速幂，清晰图解）
 https://leetcode.cn/problems/shu-zhi-de-zheng-shu-ci-fang-lcof/solutions/112529/mian-shi-ti-16-shu-zhi-de-zheng-shu-ci-fang-kuai-s/
 
 */


class YLAlgoBitListRow_6: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = mypow(2, 5)
        print("🍎1：\(res)")
    }
    
    /// 快速幂运算
    /// - Parameters:
    ///   - x: 底数
    ///   - n: 指数
    /// - Returns: 幂乘积
    /// 时间复杂度：O(logn)；空间复杂度：O(1)
    func mypow(_ x:Double,_ n:Int) -> Double {
        var x = x, res:Double = 1, m = n;
        if n < 0 {
            x = 1/x;
            m = -m;
        }
        while m > 0 {
            if (m&1 == 1){
                res *= x;
            }
            x *= x;
            m >>= 1;
        }
        return res;
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_6"
    }
}
