//
//  YLAlgoArrayListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/*
 给定一个包含 n + 1 个整数的数组 nums ，其数字都在 [1, n] 范围内（包括 1 和 n），可知至少存在一个重复的整数。
 假设 nums 只有 一个重复的整数 ，返回 这个重复的数 。
 你设计的解决方案必须 不修改 数组 nums 且只用常量级 O(1) 的额外空间。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/find-the-duplicate-number
 */
class YLAlgoArrayListRow_0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_1(array);
        print("重复元素是：\(res)")
    }

    @objc func testMethod_2() {
        let array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_1(array);
        print("重复元素是：\(res)")
    }

    /// 方法一：利用Set的特性，不含重复元素 【时间复杂度：O(n); 空间复杂度：O(n)】
    /// - Parameter data: 原数组
    /// - Returns: 重复元素
    func method_1(_ data: [Int]) -> Int {
        guard data.count > 0 else {
            return -1
        }
        
        for i in 0..<data.count {
            if data[i]<0 || data[i] > data.count-1 {
                return -1
            }
        }
        
        var set: Set<Int> = Set()
        print("初始值 ：\(set.description)")
        var count = 0 // 执行插入次数
        for i in 0...data.count-1 {
            if (set.contains(data[i])) {
                return data[i]
            }
            set.insert(data[i])
            count += 1
            print("i=\(i): 插入\(count)次\(set.description)")
        }
        
        return -1
    }

    /// 方法二：数组重拍  【时间复杂度：O(n); 空间复杂度：O(n)】
    /// - Parameter data: 可修改数组（注意`inout`关键字，调用处需要加`&`）
    /// - Returns: 返回找到的第一个重复元素
    func method_2(_ data: inout [Int]) -> Int {
        if data.count <= 0 {
            return -1
        }
        
        for i in 0...data.count-1 {
            if data[i] < 0 || data[i] > data.count-1 {
                return -1
            }
        }
        
        print("初始值 ：\(data.description)")
        for i in 0...data.count-1 {
            var count = 0 // 执行交换次数
            
            while data[i] != i {
                if data[i] == data[data[i]] {
                    return data[i]
                }
                
                let tmp = data[i]
                data[i] = data[tmp]
                data[tmp] = tmp
                count += 1
                print("i=\(i): 交换\(count)次\(data.description)")
            }
        }
        return -1
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_0"
    }
}
