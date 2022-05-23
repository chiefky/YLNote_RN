//
//  YLNoteQesDataManager.swift
//  YLNote
//
//  Created by tangh on 2022/2/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLNoteQesDataManager: YLQuestionDataManagerBase {
    override var jsonFileName: String {
        return "Note"
    }
    
    override var headerIdentifier: String {
        return "YLNotesViewController.header"
    }
    
    override var cellIdentifier: String {
        return "YLNotesViewController.cell"
    }

}
