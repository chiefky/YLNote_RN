//
//  YLAlgoDPListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoDPListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    // MARK: 剑指 Offer 10- I. 斐波那契数列
    @objc func dp_fib() {
        let res = fib(5)
        print("菲波那切数列：\(res)")
    }
    /// 时间复杂度：O(n)；空间复杂度：O(1）
    func fib(_ n: Int) -> Int {
        if n < 2 { return n }
        var res = 0, a = 0,b = 1;
        for _ in 2...n {
            res = (a+b)%1000000007
            a = b;
            b = res;
        }
        return res;
    }
    
    // MARK: 剑指 Offer 10- II. 青蛙跳台阶问题
    func dp_numWays()  {
        let res = numWays(5)
        print("青蛙跳：\(res)")
    }
    /// 时间复杂度：O(n)；空间复杂度：O(1）
    func numWays(_ n: Int) -> Int {
        if n < 2 { return 1 }
        var a = 1,b=1;
        var sum = 0;
        for _ in 2...n {
            sum = (a+b)%1000000007
            a = b;
            b = sum;
        }
        return sum;
    }
    
    // MARK: -  剑指 Offer 14- I. 剪绳子
    // 链接：https://leetcode.cn/problems/jian-sheng-zi-lcof/description/
    @objc func dp_cuttingRopeI() {
        let res = cuttingRope_math(10);
        print("🌹：\(res)");
    }
    /// 方法一(数学求导数)
    /// f(x) = x^(n/x)； x是每段绳子的长度
    /// 求导：f(x)' =（ 1-ln(x) ）/ x^2 * x^(1/x)
    /// f(x)' == 0 时取得极值，f(x)'>0，f(x)递增；f(x)'<0,f(x)递减；---> f(x)'==0时，f(x)取得极大值，此时x=e；
    /// 提示：e =
    /// 时间复杂度：O(1)，空间复杂度：O(1)
    func cuttingRope_math(_ n: Int) -> Int {
        if n < 4 { return n - 1 }
        let m:Int = n / 3;
        let remain = n%3;
        
        if remain == 0 {
            return Int(pow(Double(3), Double(m)));
        } else if remain == 1 {
            return Int(pow(Double(3), Double(m-1))) * 4 ;
        } else {
            return Int(pow(Double(3), Double(m))) * 2 ;
        }
    }
    
    /// 方法二(动态规划)
    /// - Parameter n: 绳子总长度
    /// - Returns: 分段后绳子长度的乘积
    /// 假如 第一段长度为i, 剩下的n-i可分两种情况：1. (n-i)作为一个整段不剪断；2.（n-i）视为一条新的绳子分成m段
    /// 对应结果：1. f(n) = i*(n-i)； 2. f(n) = i*f(n-i）
    /// 时间复杂度：O(n)，空间复杂度：O(n)
    func cuttingRope_dp(_ n: Int) -> Int {
        if n < 4 { return n-1 }
        var dp:[Int] = [0,1,2,3]
        for i in 4...n {
            var max_val = 0;
            for j in 1...i/2 {
                let p = dp[j] * dp[i-j]
                max_val = max(p, max_val)
            }
            dp.append(max_val)
            print("🌹：\(dp)")
        }
        return dp[n];
        
    }
    //    MARK: 剑指 Offer 42. 连续子数组的最大和
    @objc func dp_maxSubArray() {
        let nums = [-2,1,-3,4,-1,2,1,-5,4]
        let res = maxSubArray(nums)
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    func maxSubArray(_ nums: [Int]) -> Int {
        var curMax = 0;
        var res = nums[0];
        for num in nums {
            curMax = max(num, curMax+num);
            res = max(curMax, res)
        }
        return res
    }
    //    MARK: 剑指 Offer 43. 1～n 整数中 1 出现的次数 (😭😭😭😭😭)
    @objc func dp_countDigitOne() {
        let res = countDigitOne(23)
        print("结果：\(res)")
    }
    
    /// 时间复杂度:O(lgn);空间复杂度:O(1)
    func countDigitOne(_ n: Int) -> Int {
        var res = 0
        var high = n/10;
        var cur = n%10
        var low = 0;
        var digit = 1; // 位权(10^x)
        while high != 0 || cur != 0 {
            if cur == 0 {
                res += high * digit
            } else if cur == 1 {
                res += high*digit + low + 1
            } else {
                res += (high+1) * digit
            }
            
            low += cur * digit;
            cur = high%10;
            high = high/10;
            digit *= 10;
        }
        return res;
        
    }
    
    //    MARK: 剑指 Offer 46. 把数字翻译成字符串
    @objc func dp_translateNum() {
        let res = translateNum(12258)
        print("把数字翻译成字符串方法有：\(res)种")
    }
    /// 时间复杂度：O(n)；空间复杂度：O(n)
    func translateNum(_ num: Int) -> Int {
        let num_str = String(num)
        let n = num_str.count
        guard n > 1 else {
            return 1
        }
        var dp:[Int] = Array(repeating: 1, count: n+1) // 数字表示前i位翻译方法数
        for i in 2...n {
            let index0 = num_str.index(num_str.startIndex, offsetBy: i-2)
            let index1 = num_str.index(num_str.startIndex, offsetBy: i-1)
            let num = Int(num_str[index0...index1]) ?? 0
            if num >= 10 && num <= 25 {
                dp[i] = dp[i-2] + dp[i-1]
            } else {
                dp[i] = dp[i-1]
            }
        }
        return dp[n]
    }
    
    // MARK: 剑指 Offer 47. 礼物的最大价值
    @objc func dp_maxValue() {
        let grid = [
            [1,3,1],
            [1,5,1],
            [4,2,1]]
        let res = maxValue(grid)
        print(" 礼物的最大价值：\(res)")
    }
    /// 时间复杂度：O(n^2)；空间复杂度：O(1）
    func maxValue(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid[0].count;
        var dp:[[Int]] = grid;
        for i in 0..<m {
            for j in 0..<n {
                if i == 0,j == 0 { continue; }
                if i == 0 {
                    dp[i][j] += dp[i][j-1];
                } else if j == 0 {
                    dp[i][j] += dp[i-1][j];
                } else {
                    dp[i][j] += max(dp[i-1][j], dp[i][j-1]);
                }
            }
        }
        return dp[m-1][n-1];
    }
    
    //    MARK: 剑指 Offer 49. 丑数
    @objc func dp_nthUglyNumber() {
        let res = nthUglyNumber(10)
        print("丑数：\(res)")
    }
    func nthUglyNumber(_ n: Int) -> Int {
        var res = [1];
        var a = 0,b = 0,c = 0;
        
        for i in 1..<n {
            let n2 = res[a]*2;
            let n3 = res[b]*3;
            let n5 = res[c]*5;
            let ugly = min(n2, n3, n5);
            res.append(ugly);
            if res[i] == n2 { a += 1}
            if res[i] == n3 { b += 1}
            if res[i] == n5 { c += 1}
        }
        return res.last ?? 0;
    }
    
    //    MARK: 剑指 Offer 60. n个骰子的点数
    @objc func dp_dicesProbability() {
        
        let res = dicesProbability(1)
        print("骰子点数：\(res)")
    }
    func dicesProbability(_ n: Int) -> [Double] {
        var dp = Array(repeating: 1.0 / 6.0, count: 6);
        guard n >= 2 else {
            return dp
        }
        for i in 2...n {
            var tmp = Array(repeating: 0.0, count: 5*i+1);
            for j in 0..<dp.count {
                for k in 0..<6 {
                    tmp[j + k] += dp[j] / 6.0;
                }
            }
            dp = tmp;
        }
        return dp;
    }
    
    //    MARK: 剑指 Offer 63. 股票的最大利润
    @objc func dp_maxProfit() {
        let nums = [7,1,5,3,6,4]
        let res = maxProfit(nums)
        print("最大利润：\(res)")
        
    }
    func maxProfit(_ prices: [Int]) -> Int {
        var maxPro = 0;
        var inPrice = prices.first ?? 0
        for price in prices {
            inPrice = min(inPrice, price)
            let curPro = price - inPrice
            maxPro = max(maxPro,curPro);
        }
        return maxPro
    }
    //    MARK: 647. 回文子串
    // https://leetcode.cn/problems/palindromic-substrings/
    @objc func dp_countSubstrings() {
        let s = "aaaaa"
        let res = countSubstrings(s)
        print("回文串：\(res)")
    }
    
    /// 动态规划 (思路同第5题）不推荐动态规划，推荐中心扩展
    /// 时间复杂度：O(n^2)；空间复杂度：O(n^2)
    func countSubstrings(_ s: String) -> Int {
        let n = s.count
        if n < 2 {return n }
        let chars = Array(s)
        var status = Array(repeating: Array(repeating: false, count: n), count: n)
        for i in 0 ..< n {
            status[i][i] = true
        }
        var res = 0
        for L in 2...n {
            for i in 0..<n {
                let j = i+L-1
                if j > n-1 {
                    break;
                }
                if chars[i] != chars[j] {
                    status[i][j] = false;
                } else {
                    if j - i < 3 {
                        status[i][j] = true;
                    } else {
                        status[i][j] = status[i+1][j-1];
                    }
                }
                
                if status[i][j] {
                    res += 1
                }
            }
        }
        return res + n
    }
    
    //    MARK: 5. 最长回文子串
    //https://leetcode.cn/problems/longest-palindromic-substring/description/
    @objc func dp_longestPalindrome() {
        let s = "ac"
        let res = longestPalindrome(s)
        print("最长回文串：\(res)")
    }
    
    /// 动态规划
    /// 时间复杂度O(n^2)；空间复杂度：O(n^2)
    func longestPalindrome(_ s:String) -> String {
        let s_arr = Array(s)
        let n = s.count
        if n < 2 {return s}
        var status:[[Bool]] = Array(repeating: Array(repeating: false, count: n)
                                    , count: n)
        for i in 0 ..< n {
            status[i][i] = true
        }
        var maxVal = 1
        var begin = 0
        for L in 2...n {
            for i in 0..<n {
                let j = i + L - 1
                if j > n-1 {break;}
                
                if s_arr[i] != s_arr[j] {
                    status[i][j] = false;
                } else {
                    if j-i < 3{
                        status[i][j] = true;
                    } else {
                        status[i][j] = status[i+1][j-1]
                    }
                }
                
                let subLength = j-i+1
                if status[i][j] && subLength > maxVal {
                    maxVal = subLength;
                    begin = i;
                }
            }
        }
        let subSeq = s_arr[begin...begin+maxVal-1]
        return String(subSeq)
    }
    
    // MARK: -  LeetCode338. 比特位计数
    // https://leetcode.cn/problems/counting-bits/description/
    @objc func dp_countBits() {
        let res = countBits(5);
        print("🌹：\(res)");
    }
    
    /// 动态规划（最低有效位）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func countBits(_ n:Int) -> [Int] {
        if n == 0 { return [0]}
        var res = Array(repeating: 0, count: n+1)
        for i in 1...n {
            res[i] = res[i>>1] + i&1
        }
        return res
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_dp_list"
    }
    
}
