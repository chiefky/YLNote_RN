//
//  sort.swift
//  YLNote
//
//  Created by tangh on 2022/3/2.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

func quicksort(_ nums:inout [Int],low: Int, high: Int) -> [Int] {
    if (low >= high) {
        return nums;
    }
    
    var l = low
    var h = high
    while l < h {
        while (l < h && nums[h] >= nums[low]) {
            h -= 1
        }
        while (l < h && nums[l] <= nums[low]){
            l += 1
        }
        nums.swapAt(l, h);
    }
    nums.swapAt(low, l);
    
    _ = quicksort(&nums, low: low, high: l-1)
    _ = quicksort(&nums, low: l+1, high: high)

    return nums

}

