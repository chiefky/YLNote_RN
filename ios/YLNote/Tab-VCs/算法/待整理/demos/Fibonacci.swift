//
//  Fibonacci.swift
//  YLNote
//
//  Created by tangh on 2022/2/4.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation


/// 递归实现斐波那契数列 f(n) = f(n-1) + f(n-2) 时间复杂度：O(2^n) 空间复杂度：O(n-1)C
/// - Parameter n: n
/// - Returns: f(n)
func fibByRecursion(_ n: Int) -> Int {
    guard n > 0 else {
        return -1
    }
    
    if n <= 2 {
        return 1
    }
    
    return fibByRecursion(n-1) + fibByRecursion(n-2);
    
}

/// 递归+记忆存储
/// - Parameter n: n
/// - Returns: rem[n]
func fibb(_ n: Int, value: inout [Int]) -> Int {
    guard n>0 else {
        return -1
    }
    
    value[n] = fibb(n-1, value: &value) + fibb(n-2, value: &value);
    return value[n];
}

func fibByRemeber(_ n:Int) -> Int {
    var dp = [Int](repeating: -1, count: 40)
    return fibb(n, value: &dp)
}

func fibByArray(_ n:Int) -> Int {
    guard n>0 else {
        return -1
    }
    var rem:[Int] = [Int](repeating: -1, count: 40)

    rem[0] = 0
    rem[1] = 1
    for i in 2...n {
        rem[i] = rem[i-1] + rem[i-2]
    }
    return rem[n];
}
