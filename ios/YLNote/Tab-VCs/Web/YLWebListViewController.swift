//
//  YLWebListViewController.swift
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLWebListQesManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "WebList";
    }
    
    override var cellIdentifier: String {
        return "YLWebListViewController.cell";
    }
    
    override var headerIdentifier: String {
        return "YLWebListViewController.header";
    }
}

class YLWebListViewController: UIViewController {
    deinit {
        print("\(self.description): \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        self.navigationItem.title = "JS交互"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(self.table)
        self.table.dataSource = self.dataManager;
        self.table.delegate = self.dataManager;
        self.dataManager.funcHandler = { (ques,pram) in
            print("\(ques.description)")
        }
        
        let name = String(describing: YLQuestionTableViewCell.self)
        table.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: dataManager.cellIdentifier)
        table.register(YLGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: dataManager.headerIdentifier)
    }
    
    //MARK: lazy method
    lazy var table: UITableView = {
        let t = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped )
        t.rowHeight = 40
        
        return t
    }()
    
    lazy var dataManager: YLWebListQesManager = {
        let manager = YLWebListQesManager()
        return manager
    }()
    
    var sectionDatas: [YLNoteGroup] {
        return self.dataManager.allDatas
    }
    
}

