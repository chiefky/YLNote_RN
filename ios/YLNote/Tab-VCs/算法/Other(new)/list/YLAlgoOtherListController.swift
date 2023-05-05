//
//  YLAlgoOtherListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoOtherListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
       
    // MARK: - 剑指 Offer 14- II. 剪绳子 II
    // 链接 https://leetcode.cn/problems/jian-sheng-zi-ii-lcof/
    @objc func oth_cuttingRopeII() {
        let res = cuttingRope_math(10);
        print("🌹：\(res)");
    }
    /// 方法一 推导过程参考剪绳子I
    /// 利用数学推导（求导数推出最短长度每份长为3,得到的乘积最大）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func cuttingRope_math(_ n: Int) -> Int {
        guard n > 3 else {
            return n-1;
        }
        let p = 1000000007;
        var n = n,res = 1;
        while n > 4 {
            res = res*3%p;
            n -= 3;
        }
        return res*n%p;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_other_list"
    }

    
}
