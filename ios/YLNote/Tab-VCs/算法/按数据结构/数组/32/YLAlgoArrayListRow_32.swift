//
//  YLAlgoArrayListRow_32.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**

 */

class YLAlgoArrayListRow_32: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let res = findNumSum([1,1,1,1], target: -100)
        print("🍎结果：\(res)")
    }
    
    func findNumSum(_ nums: [Int],target: Int) -> [Int] {
        guard nums.count >= 3 else {
            return []
        }
        var sum = nums[0]+nums[1]+nums[2]
        var res:[Int] = []
        for i in 0 ..< nums.count-2 {
            var r = nums.count - 1
            for l in i+1 ..< nums.count-1 {
                while l < r {
                    let tmp = nums[i] + nums[l] + nums[r]
                    if abs(target-tmp) <= abs(target-sum) {
                        sum = tmp
                        res = [nums[i],nums[l],nums[r]]
                        print("更新和，数组：\(sum) -- \(res)")
                    }
                    r -= 1
                }
            }
        }
        return res;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_32"
    }
    
}
