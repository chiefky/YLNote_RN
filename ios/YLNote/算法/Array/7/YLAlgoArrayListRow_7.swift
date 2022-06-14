//
//  YLAlgoArrayListRow_7.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个由 整数 组成的 非空 数组所表示的非负整数，在该数的基础上加一。
 最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。
 你可以假设除了整数 0 之外，这个整数不会以零开头。
 
 链接：https://leetcode.cn/problems/plus-one
 
 */

class YLAlgoArrayListRow_7: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        var array = [9,9]
        let res = method_1(array);
        print("结果：\(res)")
    }


    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_7"
    }
    
    func method_1(_ digits: [Int]) -> [Int] {
        if(digits.isEmpty){
            return [];
        }
        var res = digits
        var i = digits.count - 1;
        while i>=0 {
            res[i] = (res[i] + 1)%10;
            if res[i] != 0 {
                return res
            }
            i -= 1;
        }
        if res[0] == 0 {
            res.insert(1, at: 0)
        }
        return res
    }
    
    func mehtod_2(_ digits: inout [Int]) -> [Int] {
        if(digits.isEmpty){
            return [];
        }
        var len = digits.count - 1;
        while(len>=0) {
            if(digits[len] != 9) {
                digits[len] += 1;
                return digits;
            } else {
                digits[len] = 0;
                len -= 1;
            }
        }
        if digits[0] == 0 {
            digits.insert(1, at: 0)
        }
        return digits
    }
    
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

        }
}
