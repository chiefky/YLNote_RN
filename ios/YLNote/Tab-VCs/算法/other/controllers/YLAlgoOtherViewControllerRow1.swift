//
//  YLAlgoOtherViewControllerRow1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoOtherViewControllerRow1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 练习一：交换数字
    @objc func testSwap1() {
        var a = 11,b = 99
        print("原始值：a:\(a),b:\(b)");
        swapNumbersWithTemp(a: &a, b: &b)
        print("交换后：a:\(a),b:\(b)");
    }

    @objc func testSwap2() {
        var a = 11,b = 99
        print("原始值：a:\(a),b:\(b)");
        swapNumbersWithArithmetic(a: &a, b: &b)
        print("交换后：a:\(a),b:\(b)");
    }

    @objc func testSwap3() {
        var a = 11,b = 99
        print("原始值：a:\(a),b:\(b)");
        swapNumbersWithXOR(a: &a, b: &b)
        print("交换后：a:\(a),b:\(b)");
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_other_row_1"
    }


}
