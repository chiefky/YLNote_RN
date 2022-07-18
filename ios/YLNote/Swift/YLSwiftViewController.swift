//
//  YLAlgoViewController.swift
//  YLNote
//
//  Created by tangh on 2021/1/5.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
class YLSwiftTabQesDataManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "LateSwift"
    }
    
    override var headerIdentifier: String {
        return "YLSwiftViewController.header"
    }
    
    override var cellIdentifier: String {
        return "YLSwiftViewController.cell"
    }

}

class YLSwiftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.title = "Swift"
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(table)
        table.register(YLGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: dataManager.headerIdentifier)
        table.register(UINib(nibName: String(describing: YLQuestionTableViewCell.self), bundle: nil), forCellReuseIdentifier: dataManager.cellIdentifier)

        table.dataSource = self.dataManager
        table.delegate = self.dataManager
    }
    
    //MARK: lazy method
    lazy var table: UITableView = {
        let t = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped )
        t.rowHeight = 40
        
        return t
    }()
    
    lazy var dataManager: YLSwiftTabQesDataManager = {
        let manager = YLSwiftTabQesDataManager()
        return manager
    }()
}

