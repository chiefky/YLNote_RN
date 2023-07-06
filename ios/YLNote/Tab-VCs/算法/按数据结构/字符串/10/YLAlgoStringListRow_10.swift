//
//  YLAlgoStringListRow_10.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 2409. 统计共同度过的日子数
 你可以假设所有日期都在 同一个 自然年，而且 不是 闰年。每个月份的天数分别为：[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] 。

 示例 1：
 输入：arriveAlice = "08-15", leaveAlice = "08-18", arriveBob = "08-16", leaveBob = "08-19"
 输出：3
 解释：Alice 从 8 月 15 号到 8 月 18 号在罗马。Bob 从 8 月 16 号到 8 月 19 号在罗马，他们同时在罗马的日期为 8 月 16、17 和 18 号。所以答案为 3 。

 https://leetcode.cn/problems/count-days-spent-together/
 */
class YLAlgoStringListRow_10: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = "a2b"
        let res = countDaysTogether("10-01", "10-31", "11-01", "12-31")
        print("🍎1：\(res)")
        
    }
    /// 字符串的排列
    /// - Parameters:
    ///   - s1: "ab"
    ///   - s2: "eidbaooo"
    /// - Returns: true
    func countDaysTogether(_ arriveAlice: String, _ leaveAlice: String, _ arriveBob: String, _ leaveBob: String) -> Int {
        let arrival_1 = daythByDate(arriveAlice)
        let arrival_2 = daythByDate(arriveBob)
        
        let leave_1 = daythByDate(leaveAlice)
        let leave_2 = daythByDate(leaveBob)
        let leave = min(leave_1, leave_2)
        let arrival = max(arrival_1, arrival_2)
        let res = max(0, leave-arrival + 1)
        
        return res
       }
    
    func daythByDate(_ dateStr: String) -> Int {
        let arr = dateStr.components(separatedBy: "-")
        guard arr.count == 2 else { return 0 };
        guard let month = Int(arr.first!) else { return 0 }
        let days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        let day = Int(arr.last!) ?? 0
        var res = 0;
        for i in 0..<month-1 {
            res += days[i];
        }
        res += day;
       print("\(dateStr)---第\(res)天")
        return res;

    }
    
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_10"
    }
}
