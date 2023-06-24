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
    var buttonA: UIButton = UIButton(type: .custom)
    var label_a: UILabel = UILabel(frame: .zero)
    
    var buttonB: UIButton = UIButton(type: .custom)
    var view_b = UIView(frame: .zero)
    
    var view_c = UIView(frame: .zero)
    var viewC = UIView(frame: .zero)
    
    var buttonD: UIButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    @objc func buttonAction_A(_ sender: Any) {
        print("Button Action");
    }
    @objc func buttonAction_B(_ sender: Any) {
        print("Button view ,Button view  ");
    }
    
    @objc func gestureAction_C(_ sender: Any) {
        print("UIView view,UIView view");
    }
    
    @objc func buttonAction_D(_ sender: Any) {
        print("Button D , control action   ");
    }
    
    @objc func gestureAction_D(_ sender: Any) {
        print("Button D , gesture action   ");
    }

    func setupUI() {
        view.backgroundColor = YLTheme.main().backColor;
        switch type {
        case 65:
            setupUI_A();
        case 66:
            setupUI_B();
        case 67:
            setupUI_C();
        case 68:
            setupUI_D();
        default:
            setupUI_A();
        }

    }
    
    
    func setupUI_A() {
        buttonA.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1);
        buttonA.setTitle("button", for: .normal)
        view.addSubview(buttonA);
        buttonA.snp.makeConstraints { make in
            make.top.equalTo(200);
            make.centerX.equalToSuperview();
            make.width.equalTo(300);
            make.height.equalTo(100);
        }
        
        label_a.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1);
        label_a.text = "label";
        label_a.textAlignment = .center;
        view.addSubview(label_a);
        label_a.snp.makeConstraints { make in
            make.centerY.equalTo(buttonA.snp.centerY);
            make.left.equalTo(buttonA.snp.left).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(60);
        }
        buttonA.addTarget(self, action: #selector(buttonAction_A), for: .touchUpInside)
    }
    

    func setupUI_B() {
        buttonB.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1);
        buttonB.setTitle("button", for: .normal)
        view.addSubview(buttonB);
        buttonB.snp.makeConstraints { make in
            make.top.equalTo(200);
            make.centerX.equalToSuperview();
            make.width.equalTo(300);
            make.height.equalTo(100);
        }
        
        view_b.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1);
        view.addSubview(view_b);
        view_b.snp.makeConstraints { make in
            make.centerY.equalTo(buttonB.snp.centerY);
            make.left.equalTo(buttonB.snp.left).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(60);
        }
        buttonB.addTarget(self, action: #selector(buttonAction_B), for: .touchUpInside)

    }

    func setupUI_C() {
        viewC.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1);
        view.addSubview(viewC);
        viewC.snp.makeConstraints { make in
            make.top.equalTo(200);
            make.centerX.equalToSuperview();
            make.width.equalTo(300);
            make.height.equalTo(100);
        }
        
        view_c.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1);
        view.addSubview(view_c);
        view_c.snp.makeConstraints { make in
            make.centerY.equalTo(viewC.snp.centerY);
            make.left.equalTo(viewC.snp.left).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(60);
        }
        
        print("蓝：\(viewC)，粉：\(view_c)");
//        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction_C))
//        viewC.addGestureRecognizer(tap);
    }

    func setupUI_D() {
        buttonD.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1);
        view.addSubview(buttonD);
        buttonD.snp.makeConstraints { make in
            make.top.equalTo(200);
            make.centerX.equalToSuperview();
            make.width.equalTo(300);
            make.height.equalTo(100);
        }
        
        buttonD.addTarget(self, action: #selector(buttonAction_D), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction_D))
        buttonD.addGestureRecognizer(tap);
        
    }
    
}
