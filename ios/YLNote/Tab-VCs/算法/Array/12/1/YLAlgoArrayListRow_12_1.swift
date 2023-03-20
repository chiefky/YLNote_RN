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
        let res = singleNumber(arr)
        print("结果：\(res)")
    }
        
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// 按位运算（取得两数异或之和，再定位区分位置k分成两部分，分别再次异或）
    func singleNumber(_ nums: [Int]) -> [Int] {
        var n1 = 0,n2 = 0;

        var xor = 0 ;
        for num in nums {
            xor ^= num;
        }
        var k=0;
        while xor&1 == 0 {
            xor >>= 1
            k += 1;
        }
        
        for num in nums {
            let tmp = num>>k
            if tmp&1 == 1 {
                n1 ^= num
            } else {
                n2 ^= num
            }
        }
        return [n1,n2];
    }
        
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_12_1"
    }

}
