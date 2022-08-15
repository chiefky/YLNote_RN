//
//  YLNoteTmpViewController.swift
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLTmpNoteQesManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "TmpNote";
    }
    
    override var cellIdentifier: String {
        return "YLNoteTmpViewController.cell";
    }
    
    override var headerIdentifier: String {
        return "YLNoteTmpViewController.header";
    }
}

class YLNoteTmpViewController: UIViewController {
    deinit {
        print("\(self.description): \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.title = "笔记整理"
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
    
    lazy var dataManager: YLTmpNoteQesManager = {
        let manager = YLTmpNoteQesManager()
        return manager
    }()
    
    var sectionDatas: [YLNoteGroup] {
        return self.dataManager.allDatas
    }
    
}

