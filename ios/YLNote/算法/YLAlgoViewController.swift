//
//  YLAlgoViewController.swift
//  YLNote
//
//  Created by tangh on 2021/1/5.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit

class YLAlgoViewController: UIViewController {
    deinit {
        print("\(self.description): \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.title = "算法"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(self.table)
        self.table.dataSource = self.dataManager;
        self.table.delegate = self.dataManager;
//        self.dataManager.dataSource = self;
        self.dataManager.funcHandler = { (ques,pram) in
            print("\(ques.description)")
        }

        let name = String(describing: YLQuestionTableViewCell.self)
        table.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        table.register(YLGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
//        table.dataSource = self.dataManager
//        table.delegate = self.dataManager
    }
    
    //MARK: lazy method
    lazy var table: UITableView = {
        let t = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped )
        t.rowHeight = 40
        
        return t
    }()
    
    lazy var dataManager: YLAlfgoTabQesDataManger = {
        let manager = YLAlfgoTabQesDataManger()
        return manager
    }()
    
    var sectionDatas: [YLNoteGroup] {
        return self.dataManager.allDatas
    }
    
}

extension YLAlgoViewController: YLQuestionDataProtocol {
    var jsonFileName: String {
        return "Alfgo"
    }
    
    var headerIdentifier: String {
        return "YLAlgorithmViewController.cell"
    }
    
    var cellIdentifier: String {
        return "YLAlgorithmViewController.header"
    }
    
//    func doFunction(with name: String, object: Any) {
//        guard let index = object as? Int else { return }
//        let funcName = "test_" + name
//        if funcName.contains(":") {
//            /// 第1种 带参数
//            let funcc = NSSelectorFromString(funcName)
//            self.perform(funcc, with: index)
//        } else {
//            /// 第2种 不带参数
//            let function = Selector(funcName)
//            guard self.responds(to: function) else { return }
//            self.perform(function)
//        }
//    }
    
}

extension YLAlgoViewController: UITableViewDelegate {
    
}


