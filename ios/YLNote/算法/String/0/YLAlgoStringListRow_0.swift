//
//  YLAlgoStringListRow_9.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。
 链接：https://leetcode.cn/problems/fan-zhuan-dan-ci-shun-xu-lcof
 */
class YLAlgoStringListRow_9: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let res = method_1(" ")
        print("🍎1：\(res)")

    }
    
    func method_1(_ s:String) -> String {
        let words1 = s.split(separator: " ")
       return words1.reversed().joined(separator: " ")
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_9"
    }
}
