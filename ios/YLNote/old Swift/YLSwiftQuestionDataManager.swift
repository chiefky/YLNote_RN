//
//  YLSwiftQuestionDataManager.swift
//  YLNote
//
//  Created by tangh on 2022/2/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLSwiftTabQesDataManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "Swift"
    }
    
    override var headerIdentifier: String {
        return "YLSwiftViewController.header"
    }
    
    override var cellIdentifier: String {
        return "YLSwiftViewController.cell"
    }

}
