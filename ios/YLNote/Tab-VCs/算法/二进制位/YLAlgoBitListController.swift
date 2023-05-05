//
//  YLAlgoBitListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoBitListController: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -  LeetCode338. 比特位计数
    // https://leetcode.cn/problems/counting-bits/description/
    @objc func bit_countBits() {
        let res = countBits_dp(5);
        print("🌹：\(res)");
    }
    
    ///方法一 动态规划（最低有效位）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func countBits_dp(_ n:Int) -> [Int] {
        if n == 0 { return [0]}
        var res = Array(repeating: 0, count: n+1)
        for i in 1...n {
            res[i] = res[i>>1] + i&1
        }
        return res
    }
    
    ///方法二 每一个数逐一求解
    /// 时间复杂度：O(nlogn)；空间复杂度：O(1)
        func countBits(_ n: Int) -> [Int] {
            if n == 0 { return [0]}
            var res:[Int] = [0]
            for i in 1...n {
                var x = i
                var x_re = 0
                while x != 0 {
                    x_re += x&1;
                    x >>= 1;
                }
                res.append(x_re)
            }
            return res;
        }

    //    MARK: LeetCode461. 汉明距离
    // 概念：两个（相同长度）字符串对应位置的不同字符的数量，我们以d（x,y）表示两个字x,y之间的汉明距离；
    // 链接：https://leetcode.cn/problems/hamming-distance/description/
    @objc func bit_hammingDistance() {
        let res = hammingDistance(1, 4)
        print("其汉明距离为：\(res)")
        
    }
    
    /// 异或运算
    /// 时间复杂度：O(log(C));空间复杂度：O(1)；；其中C为x,y异或值的位数
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
          var xor = x ^ y;
          var res = 0;
          while xor != 0 {
              res += xor&1;
              xor >>= 1
          }
          return res;
      }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_bit_list"
    }

}
