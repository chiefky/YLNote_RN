//
//  YLAlfgoStringViewControllerRow0.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlfgoStringViewControllerRow1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func testInvalid_iteration() {
        let str = "[{{}"
        let res = isValid(str)
        
        print("🍎：\(res)")
        
    }

    //MARK: override
    override func fileName() -> String {
        return "Alfgo_string_row_1"
    }
}
