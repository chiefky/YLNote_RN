//
//  YLPerNoteQesManager.swift
//  YLNote
//
//  Created by tangh on 2022/2/5.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLPerNoteQesManager: YLQuestionDataManagerBase {

    override var jsonFileName: String {
        return "LateNote";
    }
    
    override var cellIdentifier: String {
        return "YLPerNoteViewController.cell";
    }
    
    override var headerIdentifier: String {
        return "YLPerNoteViewController.header";
    }
}
