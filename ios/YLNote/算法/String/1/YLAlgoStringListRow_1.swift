//
//  YLAlgoStringListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：
 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 
 示例 1：
 输入：s = "()"
 输出：true

 示例 2：
 输入：s = "()[]{}"
 输出：true
 
 示例 3：
 输入：s = "(]"
 输出：false
 
 示例 4：
 输入：s = "([)]"
 输出：false
 
 示例 5：
 输入：s = "{[]}"
 输出：true

 链接：https://leetcode.cn/problems/valid-parentheses
 */
class YLAlgoStringListRow_1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func testMethod() {
        let str = "[{{}"
        let res = method_1(str)
        print("🍎：\(res)")
        
    }
    
    func method_1(_ s:String) -> Bool {
        let dic:[Character:Character] = ["}":"{","]":"[",")":"("];
        var valid:[Character] = []
        for c in s {
            if dic.values.contains(c) {
                // { ,[, (
                valid.append(c)
            } else if let value = dic[c], value != valid.popLast() {
                // },],)
                return false
            }
        }
        
        return true
        
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_1"
    }
}
