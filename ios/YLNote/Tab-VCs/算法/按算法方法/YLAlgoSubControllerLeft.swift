//
//  YLAlgoSubViewController.swift
//  YLNote
//
//  Created by tangh on 2023/7/6.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLAlgoSubLeftDataManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "AlgoLeft"
    }
    override var headerIdentifier: String {
        return "YLAlgoSubControllerLeft.cell"
    }
    
    override var cellIdentifier: String {
        return "YLAlgoSubControllerLeft.header"
    }
    
}


class YLAlgoSubControllerLeft: UIViewController {
    
    static var name: String {
        set {
            print("\(newValue)")
        }
        get {
            return "son"
        }
    }
    
    deinit {
        print("\(Self.self) is Deinited")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - funcs
    
    func setupUI() {
        view.addSubview(self.table)
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.table.dataSource = self.dataManager;
        self.table.delegate = self.dataManager;
        self.dataManager.funcHandler = { (ques,indexpath) in
            print("indexpath:\(String(describing: indexpath)), \(ques.function)")
            let funcName = ques.function
            if funcName.contains(":") {
                /// 第1种 带参数
                let funcc = NSSelectorFromString(funcName)
                self.perform(funcc, with: indexpath)
            } else {
                /// 第2种 不带参数
                let function = Selector(funcName)
                guard self.responds(to: function) else {
                    print("Can't responder to sel: \(funcName)")
                    return
                }
                self.perform(function)
            }
            
        }
        
        let name = String(describing: YLQuestionTableViewCell.self)
        table.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: dataManager.cellIdentifier)
        table.register(YLGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: dataManager.headerIdentifier)
    }
    
    //MARK: 每日抽查测试:
    @objc func array_test() {
        testArray()
    }
    
    @objc func linklist_test(){
        testLinkList()
    }
    
    //MARK: lazy method
    lazy var table: UITableView = {
        let t = UITableView(frame:.zero, style: .grouped )
        t.rowHeight = 40
        
        return t
    }()
    
    lazy var dataManager: YLAlgoSubLeftDataManager = {
        let mana = YLAlgoSubLeftDataManager()
        return mana
    }()
    
    var sectionDatas: [YLNoteGroup] {
        return self.dataManager.allDatas
    }

}
