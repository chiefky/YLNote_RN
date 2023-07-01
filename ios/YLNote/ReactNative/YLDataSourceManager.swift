//
//  YLDataSourceManager.swift
//  YLNote
//
//  Created by tangh on 2023/6/28.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit


class YLDataSourceManager: NSObject,UITableViewDataSource,UITableViewDelegate {
    weak var target:YLReactTableListProtocol?
    var headerIdentifier = "YLDataSourceManager.header"
    var cellIdentifier = "YLDataSourceManager.cell"
    
    init<T: YLReactTableListProtocol>(target: T) {
        self.target = target
//        headerIdentifier = target.headerIdentifier
        cellIdentifier = target.cellIdentifier
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01;
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.target?.allDatas.count ?? 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.target?.allDatas[safe: indexPath.row] as? ItemData,
              let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? YLQuestionTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.titleLabel.text = data.title
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = self.target?.handelSelected(tableview: tableView, at: indexPath) else {
            print("selector is not defined")
            return;
        }
       
    }
}
