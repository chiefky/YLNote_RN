//
//  CQueue.swift
//  YLNote
//
//  Created by tangh on 2022/8/11.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
class CQueue {
    var stackIn:[Int]
    var stackOut:[Int]
    
    init() {
        stackIn = []
        stackOut = []
    }
    
    func appendTail(_ value: Int) {
        stackIn.append(value)
    }
    
    func deleteHead() -> Int {
        if self.stackOut.isEmpty {
            if self.stackIn.isEmpty {
                return -1
            } else {
                while !self.stackIn.isEmpty {
                    let element = self.stackIn.removeLast()
                    self.stackOut.append(element)
                }
            }
        }
        return self.stackOut.removeLast()
    }
}
