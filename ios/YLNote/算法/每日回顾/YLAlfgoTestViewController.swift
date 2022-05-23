//
//  YLAlfgoTestViewController.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

/// 每日回顾1~2算法
class YLAlfgoTestViewController: YLBaseGroupTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func test_binary_search() {
        let nums = [-1,0,3,5,9,12]
        let res = day_test_binary_search(nums,target: 3)
        print("res: \(res)")
    }
    
    @objc func test_binary_search_res() {
        let nums = [-1,0,3,5,9,12]
        let res = day_test_binary_search_res(nums, target: 3, low: 0, high: nums.count - 1)
        print("res: \(res)")
    }

    @objc func test_quick_sort() {
        
        var nums = [1,2,9,3,5,8]
        let orign = nums
        let res = day_test_quicksort(&nums, low: 0, high: nums.count-1)
        print("before:\(orign) after: \(res)")
    }

    @objc func test_merge_sort() {
        let nums = [1,2,9,3,5,8]
        let res = day_test_mergesort(nums)
        print("before:\(nums) after: \(res)")
    }

    @objc func test_reverse_words() {
        let nums = [-1,0,3,5,9,12]
        let res = day_test_mergesort(nums)
        print("res: \(res)")
    }

    @objc func test_valid_string() {
    
    }
    
    @objc func test_sub_string() {
    
    }

    
    @objc func test_sub_sequence() {
    
    }

    
    
    // MARK: - override

    override func fileName() -> String {
        return "day_test"
    }
}
