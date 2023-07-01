//
//  YLWalletInstance.swift
//  YLNote
//
//  Created by tangh on 2021/3/31.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit

class YLCard: NSObject {
    var cradId: String = ""
    var bank: String = ""
    var user: YLPet

    init(_ id: String, bank: String, user: YLPet) {
        self.bank = bank
        self.cradId = id
        self.user = user
    }
    
}

/// 第一种方式：全局变量
let sharedInstance = YLWallet(balance: 0)
class YLWallet: NSObject {
    // Properties
    let balance: Double
    var crad: YLCard?
    
    // Initialization
    init(balance: Double) {
        self.balance = balance
    }
}

class YLWalletManager: NSObject {
    let expenditure: Double? // 支出金额
    
    let sharedInstance = YLWalletManager(expenditure: 0)
    
    
    init(expenditure: Double) {
        self.expenditure = expenditure
    }
}

class YLAttentionManager: NSObject {
    let article: YLQuestionArticle? = nil
  
    let sharedInstance: YLAttentionManager = {
        let mana = YLAttentionManager()
        return mana
    }()
}
