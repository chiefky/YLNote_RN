//
//  YLAlgoArrayListRow_31.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 49. 丑数
 我们把只包含质因子 2、3 和 5 的数称作丑数（Ugly Number）。求按从小到大的顺序的第 n 个丑数。

 https://leetcode.cn/problems/chou-shu-lcof/description/
 */
class YLAlgoArrayListRow_31: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let res = nthUglyNumber(10)
        print("🍎结果：\(res)")
    }
    
    func nthUglyNumber(_ n: Int) -> Int {
        var a = 0,b = 0,c = 0;
        var res:[Int] = [1];
        for i in 1..<n {
            var n2 = res[a] * 2, n3 = res[b] * 3, n5 = res[c]*5;
            let minUgly = min(n2, n3, n5);
            res.append(minUgly);
            if (res[i] == n2) { a += 1; }
            if (res[i] == n3) { b += 1; }
            if (res[i] == n5) { c += 1; }
        }
        return res.last ?? 0;
        
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_31"
    }
    
}
