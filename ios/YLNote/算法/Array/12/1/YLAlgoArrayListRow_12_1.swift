//
//  YLAlgoArrayListRow_12_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个非空整数数组，除了某两个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
 说明：
 你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
 示例 1:
 输入: [2,2,1,3]
 输出: [1,3]
 */

class YLAlgoArrayListRow_12_1: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let arr = [4,1,2,1,2,3];
        let res = method_1(arr)
        print("结果：\(res)")
    }
    
    @objc func testMethod_2() {
        
        let arr = [4,1,2,1,2,3,7];
        let res = method_2(arr)
        print("结果：\(res)")
    }
        

    func method_1(_ nums: [Int]) -> [Int] {
        guard nums.count > 3 else { return [] }
        var v1 = 0,v2 = 0
        var xor = 0
        for num in nums {
            xor ^= num
        }
        var x = xor;
        var k = 0;
        while ((x&1) == 0) {
            x >>= 1
            k += 1;
        }
        
        for num in nums {
            let tmp = num>>k
            if ((tmp&1) == 0) {
                v1 ^= num
            } else {
                v2 ^= num;
            }
        }
        
        return [v1,v2];
    }
    
    /// 取出只出现1次的多个元素
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func method_2(_ nums:[Int]) -> [Int] {
        var res:[Int] = []
        for num in nums {
            if res.contains(num) {
                if let index = res.firstIndex(of: num) {
                    res.remove(at: index)
                } else {
                    print("error")
                }
            } else {
                res.append(num)
            }
        }
        return res
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_12_1"
    }

}
