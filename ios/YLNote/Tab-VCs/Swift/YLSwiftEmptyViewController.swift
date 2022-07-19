//
//  YLSwiftEmptyViewController.swift
//  YLNote
//
//  Created by tangh on 2022/3/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLSwiftEmptyViewController: UIViewController {

    deinit {
        print("\(self) dealloc")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

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

}
