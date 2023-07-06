//
//  YLAlgoArrayListRow_28.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 12. 矩阵中的路径
 给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。
 单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。

 例如，在下面的 3×4 的矩阵中包含单词 "ABCCED"（单词中的字母已标出）。
 示例 1：
 输入：board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
 输出：true
 
 示例 2：
 输入：board = [["a","b"],["c","d"]], word = "abcd"
 输出：false

 提示：
 m == board.length
 n = board[i].length
 1 <= m, n <= 6
 1 <= word.length <= 15
 board 和 word 仅由大小写英文字母组成

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/ju-zhen-zhong-de-lu-jing-lcof
 */
class YLAlgoArrayListRow_28: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let board:[[Character]] = [["A","A","A","A","A","A"],["A","A","A","A","A","A"],["A","A","A","A","A","A"],["A","A","A","A","A","A"],["A","A","A","A","A","A"],["A","A","A","A","A","A"]];         // [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]];
        let word = "AAAAAAAAAAAABAA" //"ABCCDEE"
        let res = exist(board,word );
        print("🍎结果：\(res)")
    }
    var rows = 0
    var cols = 0
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard let firstline = board.first else { return false }
        var m_board = board
        let word = Array(word)
        rows = m_board.count;
        cols = firstline.count;
        for i in 0..<rows {
            for j in 0..<cols {
                if dfs_word(&m_board, word, i, j, 0) {
                    return true
                }
            }
        }
        return false
     }
    
    func dfs_word(_ board: inout [[Character]],_ word: [Character],_ i: Int,_ j: Int, _ k:Int) -> Bool {
        if i >= rows || i < 0 || j >= cols || j < 0 || board[i][j] != word[k]  {
            return false
        }
        if k == word.count - 1 {
            return true
        }
        board[i][j] = Character(" ")
        let res = dfs_word(&board, word, i-1, j, k+1) ||
        dfs_word(&board, word, i+1, j, k+1) ||
        dfs_word(&board, word, i, j-1, k+1) ||
        dfs_word(&board, word, i, j+1, k+1)
        
        board[i][j] = word[k]
        return res
    }
    
    
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_28"
    }
    
}
