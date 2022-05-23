//
//  YLAlfgoListDataManger.swift
//  YLNote
//
//  Created by tangh on 2022/2/5.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

class YLAlfgoTabQesDataManger: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "Alfgo"
    }
    
    override var headerIdentifier: String {
        return "YLAlgorithmViewController.cell"
    }
    
    override var cellIdentifier: String {
        return "YLAlgorithmViewController.header"
    }

}
