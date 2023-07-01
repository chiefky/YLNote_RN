//
//  YLReactHomeViewController.swift
//  YLNote
//
//  Created by tangh on 2023/6/28.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import React

class YLReactHomeViewController: UIViewController,YLReactTableListProtocol {
    var manager:YLDataSourceManager?
    
    var allDatas: [Any] = []
    var headerIdentifier: String =  String(describing: type(of: YLReactHomeViewController.self)) + ".header"
    var cellIdentifier: String =  String(describing: type(of: YLReactHomeViewController.self)) + ".cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.title = "混合demo"
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(self.table)
        table.snp.makeConstraints { make in
            make.edges.equalToSuperview();
        };
        
        self.manager = YLDataSourceManager(target: self)
        self.table.dataSource = self.manager;
        self.table.delegate = self.manager;
        
        let name = String(describing: YLQuestionTableViewCell.self)
        table.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        //        table.register(YLGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: self.headerIdentifier)
        
        requestDatas()
    }
    
    
    func requestDatas() {
        let json = """
        [
               {
               "pageId": "1",
               "pageName": "RootScreen",
               "pageParam": {
        "user":"abc",
        "password":"1234"
        }
               },
               {
               "pageId": "2",
               "pageName": "Interaction",
               "pageParam": {}
               },
               {
               "pageId": "3",
               "pageName": "Detail",
               "pageParam": {}
               },
               {
               "pageId": "4",
               "pageName": "SignIn",
               "pageParam": {}
               },
               {
               "pageId": "5",
               "pageName": "SignUp",
               "pageParam": {}
               }

           ]
        """
        
        do {
            let jsonData = json.data(using: .utf8)!
            let pages = try JSONDecoder().decode([Page].self, from: jsonData)
            allDatas = pages.map {
                ItemData(title: $0.name ?? "undefined", oriData: $0)
            };
            print("\(allDatas)")
        } catch {
            print("JSON decoding failed. Error: \(error)")
        }
        
    }
    //MARK: lazy method
    lazy var table: UITableView = {
        let t = UITableView(frame:CGRect.zero, style: .plain )
        t.rowHeight = 44
        return t
    }()
    
}

extension YLReactHomeViewController {
    func handelSelected(tableview: UITableView, at indexPath: IndexPath) -> Bool {
        guard let data = allDatas[indexPath.row] as? ItemData else {
            print("data is error")
            return true
        }
        
        print("hello: \(indexPath),\(data.title)")
        
        let vc = YLReactContainerController()
        vc.moduleName = data.title
        self.navigationController?.pushViewController(vc, animated: true)

        return true
        
    }
    
}
