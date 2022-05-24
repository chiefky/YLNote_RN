//
//  YLAlgoListDataManger.swift
//  YLNote
//
//  Created by tangh on 2022/2/5.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

class YLAlgoTabQesDataManger: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "Algo"
    }
    
    override var headerIdentifier: String {
        return "YLAlgorithmViewController.cell"
    }
    
    override var cellIdentifier: String {
        return "YLAlgorithmViewController.header"
    }

}
