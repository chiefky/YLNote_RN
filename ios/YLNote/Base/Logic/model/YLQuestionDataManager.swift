//
//  YLQuestionDataManager.swift
//  YLNote
//
//  Created by tangh on 2021/3/25.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
import YYModel

@objc protocol YLQuestionDataProtocol {
    
    // MARK: 必须实现
    @objc optional var jsonFileName: String { get }
    @objc optional var headerIdentifier: String { get }
    @objc optional var cellIdentifier: String { get }
    
//    // MARK: 可选实现
//    @objc optional func doFunction(with name: String) // 无参
//    @objc optional func doFunction(with name: String, object: Any!) // 一个参数
//    @objc optional func doFunction(with name: String, object1: Any!,object2: Any!) // 两个参数

    //    @objc optional func actionHandler()
}

typealias YLQuestionDataManagerBaseFuncHanler = (_ question: YLQuestion , _ pramater: Any?) -> ()

protocol YLQuestionDataManagerBaseProtocol: YLQuestionDataProtocol,UITableViewDelegate,UITableViewDataSource {
    
}

@objcMembers open class YLQuestionDataManagerBase: NSObject, YLQuestionDataManagerBaseProtocol {

    var jsonFileName: String {
        return ""
    }
    
    var cellIdentifier: String {
        return ""
    }
    
    var headerIdentifier: String {
        return ""
    }
    @objc var funcHandler: YLQuestionDataManagerBaseFuncHanler?

    @objc lazy var allDatas: [YLNoteGroup] = {
        let json = YLFileManager.jsonParse(withLocalFileName: self.jsonFileName )
        let array = NSArray.yy_modelArray(with: YLNoteGroup.self, json: json) as? [YLNoteGroup]
        return array ?? []
    }()

    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.allDatas.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.headerIdentifier) as? YLGroupHeaderView else { return UIView() }
        
        let groupData = self.allDatas[section]
        header.title = groupData.title
        header.unfoldStatus = groupData.unfoldStatus
        header.headerAction = {
            groupData.unfoldStatus = !groupData.unfoldStatus
            //刷新当前的分组
            let set = IndexSet(integer: section)
            tableView.reloadSections(set, with: .none)
            
        }
        return header
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupData = self.allDatas[section]
        return groupData.unfoldStatus ? groupData.questions.count : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? YLQuestionTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let group = self.allDatas[indexPath.section]
        if let question = group.questions[safe: indexPath.row] {
            let title = question.title
            cell.titleLabel.text = "\(indexPath.row). " + title
            cell.nextPage.isHidden = !question.showNextPage
            if question.showArticle {
                cell.articleButton.setImage(#imageLiteral(resourceName: "article"), for: .normal)
                cell.articleHandler = {
                    UIWindow.pushToArticleVC(question)
                }
            }
        }
        return cell;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupData = self.allDatas[indexPath.section]
        guard let question = groupData.questions[safe: indexPath.row] else { return }
        if question.showNextPage {
            UIWindow.pushToDemoVC(with: question)
        } else {
            let functionName = question.function
            guard functionName.count > 0 else {
                YLAlertManager.showToast(withMessage: "未定义响应事件", senconds: 1)
                return
            }
            
            self.funcHandler?(question,indexPath)
            
        }
        
        return
    }
    
//    func doFunction(with name: String, object: Any?) {
//        guard let pramater = object else { return }
//        let funcName = "test_" + name
//        if funcName.contains(":") {
//            /// 第1种 带参数
//            let funcc = NSSelectorFromString(funcName)
//            self.perform(funcc, with: pramater)
//        } else {
//            /// 第2种 不带参数
//            let function = Selector(funcName)
//            guard self.responds(to: function) else { return }
//            self.perform(function)
//        }
//    }

    
}

//class YLQuestionDataManager: NSObject {
//
////    @objc var allDatas = [YLNoteGroup]()
//
//    @objc var allDatas: [YLNoteGroup] {
//        guard let jsonFile = self.dataSource?.jsonFileName else { return [] }
//        let json = YLFileManager.jsonParse(withLocalFileName: jsonFile)
//        let array = NSArray.yy_modelArray(with: YLNoteGroup.self, json: json) as? [YLNoteGroup]
//        return array ?? []
//    }
//    @objc weak var dataSource: YLQuestionDataProtocol?
////    {
////        didSet {
////            if let tmp = dataSource {
////                allDatas = makeupDatas(tmp)
////            }
////        }
////    }
//
////    func makeupDatas(_ source: YLQuestionDataProtocol) -> [YLNoteGroup] {
////        let json = YLFileManager.jsonParse(withLocalFileName: self.dataSource?.jsonFileName ?? "")
////        let array = NSArray.yy_modelArray(with: YLNoteGroup.self, json: json) as? [YLNoteGroup]
////        return array ?? []
////    }
////
//
//
//}
//
//extension YLQuestionDataManager: UITableViewDataSource,UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.allDatas.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01;
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let datasource = self.dataSource,let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "datasource.headerIdentifier") as? YLGroupHeaderView else { return UIView() }
//
//        let groupData = self.allDatas[section]
//        header.title = groupData.title
//        header.unfoldStatus = groupData.unfoldStatus
//        header.headerAction = {
//            groupData.unfoldStatus = !groupData.unfoldStatus
//            //刷新当前的分组
//            let set = IndexSet(integer: section)
//            tableView.reloadSections(set, with: .none)
//
//        }
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let groupData = self.allDatas[section]
//        return groupData.unfoldStatus ? groupData.questions.count : 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let datasource = self.dataSource,let cell = tableView.dequeueReusableCell(withIdentifier: "datasource.cellIdentifier", for: indexPath) as? YLQuestionTableViewCell else { return UITableViewCell() }
//        cell.selectionStyle = .none
//        let group = self.allDatas[indexPath.section]
//        if let question = group.questions[safe: indexPath.row] {
//            let title = question.title
//            cell.titleLabel.text = "\(indexPath.row + 1). " + title
//            cell.nextPage.isHidden = !question.showNextPage
//            if question.showArticle {
//                cell.articleButton.setImage(#imageLiteral(resourceName: "bookshelf"), for: .normal)
//                cell.articleHandler = {
//                    UIWindow.pushToArticleVC(question)
//                }
//            }
//        }
//        return cell;
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let groupData = self.allDatas[indexPath.section]
//        guard let question = groupData.questions[safe: indexPath.row] else { return }
//        if question.showNextPage {
//            UIWindow.pushToDemoVC(with: question)
//        } else {
//            let functionName = question.function
//            guard functionName.count > 0,let _ = self.dataSource else {
//                YLAlertManager.showToast(withMessage: "未定义响应事件", senconds: 1)
//                return
//            }
//
//            let obj = ["row": indexPath.row,
//                       "section": indexPath.section,
//            ]
//
//            doFunction(with: question.function, object: obj)
//
////            if ((delegate.doFunction?(with: question.function)) != nil) {
////                delegate.doFunction?(with: question.function)
////
////            } else if ((delegate.doFunction?(with: question.function, object: indexPath.row)) != nil) {
////                delegate.doFunction?(with: question.function, object: (indexPath.row))
////
////            } else {
////                delegate.doFunction?(with: question.function, object1: (indexPath.row), object2: (indexPath.section))
////            }
//
//        }
//
//        return
//    }
//
//    func doFunction(with name: String, object: Any?) {
//        guard let pramater = object else { return }
//        let funcName = "test_" + name
//        if funcName.contains(":") {
//            /// 第1种 带参数
//            let funcc = NSSelectorFromString(funcName)
//            self.perform(funcc, with: pramater)
//        } else {
//            /// 第2种 不带参数
//            let function = Selector(funcName)
//            guard self.responds(to: function) else { return }
//            self.perform(function)
//        }
//    }
//
//
//}
