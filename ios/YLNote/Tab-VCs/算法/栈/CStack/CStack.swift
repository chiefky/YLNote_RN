//
//  CStack.swift
//  YLNote
//
//  Created by tangh on 2022/8/11.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
class CStack {
    
    var nums:[Int] = []
    init() {
        nums = []
    }
    
    func pop() {
        nums.removeLast()
    }
    
    func push(_ x: Int) {
        nums.append(x)
    }
    
    func top() -> Int {
        return nums.last ?? Int.max
    }
    
}

class MinStack {
    var nums:[Int] = [];
    var min_nums:[Int] = []
    /** initialize your data structure here. */
    init() {
        nums = []
        min_nums = []
    }
    
    func push(_ x: Int) {
        nums.append(x)
        if let top = min_nums.last {
            if x <= top {
                min_nums.append(x)
            }
        } else {
            min_nums.append(x)
        }
    }
    
    func pop() {
        guard let num = nums.popLast() else {return}
        if let min = min_nums.last, min == num {
            min_nums.removeLast()
        }
    }
    
    func top() -> Int {
        return nums.last ?? Int.min
    }
    
    func min() -> Int {
        return min_nums.last ?? Int.min
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(x)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.min()
 */
