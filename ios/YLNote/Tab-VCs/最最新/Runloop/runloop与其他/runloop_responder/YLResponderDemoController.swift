//
//  YLResponderDemoController.swift
//  YLNote
//
//  Created by tangh on 2023/2/9.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLResponderDemoController: UIViewController {
    @objc var type:Int = 0
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var label_a: UILabel!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var view_b: UIView!
    @IBOutlet weak var viewC: UIView!
    @IBOutlet weak var view_c: UIView!
    @IBOutlet weak var buttonD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seyupUI();
    }
    
    @IBAction func buttonAction_A(_ sender: Any) {
        print("Label Label Label");
    }
    @IBAction func buttonAction_B(_ sender: Any) {
        print("Button view ,Button view  ");
    }
    
    @IBAction func gestureAction_C(_ sender: Any) {
        print("UIView view,UIView view");
    }
    @IBAction func buttonAction_D(_ sender: Any) {
        print("Button D , control action   ");
    }
    @IBAction func gestureAction_D(_ sender: Any) {
        print("Button D , gesture action   ");
    }

    func seyupUI() {
        buttonD.isHidden = true;

        switch type {
        case 65:
            buttonA.isHidden = false;
            label_a.isHidden = false;
            buttonB.isHidden = true;
            view_b.isHidden = true;
            viewC.isHidden = true;
            view_c.isHidden = true;
        case 66:
            buttonA.isHidden = true;
            label_a.isHidden = true;
            buttonB.isHidden = false;
            view_b.isHidden = false;
            viewC.isHidden = true;
            view_c.isHidden = true;
        case 67:
            buttonA.isHidden = true;
            label_a.isHidden = true;
            buttonB.isHidden = true;
            view_b.isHidden = true;
            viewC.isHidden = false;
            view_c.isHidden = false;
        case 68:
            buttonA.isHidden = true;
            label_a.isHidden = true;
            buttonB.isHidden = true;
            view_b.isHidden = true;
            viewC.isHidden = true;
            view_c.isHidden = true;
            buttonD.isHidden = false;

        default:
            buttonA.isHidden = false;
            label_a.isHidden = false;
            buttonB.isHidden = false;
            view_b.isHidden = false;
            viewC.isHidden = false;
            view_c.isHidden = false;
        }
    }

}
