//
//  YLAlgoStringListRow_11.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 38. 字符串的排列

 输入一个字符串，打印出该字符串中字符的所有排列。
 你可以以任意顺序返回这个字符串数组，但里面不能有重复元素。
 https://leetcode.cn/problems/zi-fu-chuan-de-pai-lie-lcof/
 */
class YLAlgoStringListRow_11: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = "abb"
        let res = permutation(s1)
        print("🍎1：\(res)")
        
    }
    
    /// 回溯法
    /// 时间复杂度：O(n!*n);空间复杂度：O(n）
    var res:[String] = []
    var visit:[Bool] = []
    func permutation(_ s: String) -> [String] {
        visit = Array(repeating: false, count: s.count)
        let arr = Array(s).sorted()
        var pre = [Character]()
        backTrac(arr, pre)
        return res;
    }
    
    func backTrac(_ s:[Character],_ pre: [Character]) {
        if pre.count == s.count {
            print("\(pre)");
            let tmp:String = String(pre);
            res.append(tmp);
            return;
        }
        
        for j in 0..<s.count {
            if(visit[j] || (j > 0 && s[j-1] == s[j] && !visit[j-1])){
                continue;
            }
            visit[j] = true;
            backTrac(s, pre+[s[j]]);
            visit[j] = false;
        }
        
    }
        
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_11"
    }
}
