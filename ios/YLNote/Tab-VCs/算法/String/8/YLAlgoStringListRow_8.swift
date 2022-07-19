//
//  YLAlgoStringListRow_8.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。如果是，返回 true ；否则，返回 false 。
 换句话说，s1 的排列之一是 s2 的 子串 。
 链接：https://leetcode.cn/problems/permutation-in-string
 */
class YLAlgoStringListRow_8: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = "ab", s2 = "eidbaooo"
        let res = method_1(s1, s2)
        print("🍎1：\(res)")
        
    }
    /// 字符串的排列
    /// - Parameters:
    ///   - s1: "ab"
    ///   - s2: "eidbaooo"
    /// - Returns: true
    func method_1(_ s1: String,_ s2: String) -> Bool {
        guard s2.count >= s1.count, s1.count > 0 else {
            return false
        }
        let m = s1.count, n = s2.count
        let sArray1 = Array(s1), sArray2 = Array(s2)
        var arr1 = Array(repeating: 0, count: 26), arr2 = Array(repeating: 0, count: 26)
        let ascii_a:Int = Int(Character("a").asciiValue ?? 97)
        
        for i in 0..<m {
            if let asciiValue1 = sArray1[i].asciiValue,let asciiValue2 = sArray2[i].asciiValue {
                arr1[Int(asciiValue1)-ascii_a] += 1;
                arr2[Int(asciiValue2)-ascii_a] += 1;
            }
        }
        print("🐷arr1:\(arr1),\n,arr2:\(arr2)")
        if arr1.elementsEqual(arr2) {
            return true
        }
        
        for j in m..<n {
            let head = j-m
            if let reduce_char_asciiValue2 = sArray2[head].asciiValue,let add_char_asciiValue2 = sArray2[j].asciiValue {
                arr2[Int(reduce_char_asciiValue2) - ascii_a] -= 1;
                arr2[Int(add_char_asciiValue2) - ascii_a ] += 1;
                if arr1.elementsEqual(arr2) {
                    return true
                }
            }
            print("🌸arr1:\(arr1),\n,arr2:\(arr2)")
            
        }
        
        return false
    }
    
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_8"
    }
}
