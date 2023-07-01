//
//  YLReactTableViewProtocol.swift
//  YLNote
//
//  Created by tangh on 2023/6/28.
//  Copyright © 2023 tangh. All rights reserved.
//

typealias YLReactTableListProtocol = YLReactListViewDelegate & YLReactListViewDataSource

protocol YLReactListViewDelegate {
    var testAction:String {get}
    func handelSelected(tableview: UITableView,at indexPath:IndexPath) -> Bool
}

protocol YLReactListViewDataSource:AnyObject {
    var allDatas: [Any] {get set}
    var headerIdentifier:String {get}
    var cellIdentifier:String {get}
}

extension YLReactListViewDelegate {
    var testAction:String {
        return "test"
    }
    
    func handelSelected(tableview: UITableView, at indexPath:IndexPath) -> Bool {
        print("\(tableview),\(indexPath)");
        
        return false
    }
}
