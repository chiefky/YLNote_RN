//
//  YLHomeViewController.swift
//  YLNote
//
//  Created by tangh on 2021/3/25.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
import YYModel
import SDWebImage

class YLHomeViewController: UIViewController {


    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var walletButn: UIButton!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIButton!
    
    @IBOutlet weak var attentionButton: UIButton!
    @IBOutlet var unloginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("\(#function)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let user = YLUserManager.shared().currentUser else {
            return
        }
        
        if let user = YLUserManager.shared().currentUser {
            reloadUserView(user)
        } else {
            let name = "张飒"
            
            if let sessionID = YLKeyChainManager.keyChainReadData(identifier: name) as? String {
                
                
            } else {
                showUnLoginView()
                return;
            }
        }

        
    }
    
    @IBAction func gotoLoginVCAction(_ sender: Any) {
        let loginVC = YLLoginViewController(nibName: "YLLoginViewController", bundle: nil)
        loginVC.loginDelegate = self;
        self.present(loginVC, animated: true) {}
        
    }
    
    /// 修改头像
    /// - Parameter sender: button
    @IBAction func changeAdvator(_ sender: Any) {

    }

    func setupUI() {
        title = "个人中心"
        
//        unloginView.removeFromSuperview()
//        nameLabel.text = user.name
//        telLabel.text = user.tel
        
    }
    
    func showUnLoginView() {
        self.view.addSubview(unloginView)
        unloginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func dissmissUnlogin() {
        unloginView.removeFromSuperview()
    }
    
    func reloadUserView(_ currentUser: YLUser) {
        nameLabel.text = currentUser.name
        telLabel.text = currentUser.tel
        genderLabel.text = currentUser.gender
        if let wallet = YLUserManager.shared().wallet {
            let balance = String(wallet.balance) + "币"
            walletButn.setTitle(balance, for: .normal)
        } 
        avatarImageView.sd_setImage(with: URL(string: currentUser
                                                .avatarUrl), for: .normal) { (image, err, type, url) in
            
        }
    }
    
    func saveToKeyChain() {
        guard let user = YLUserManager.shared().currentUser else { return }
        // 存储数据
        let saveBool = YLKeyChainManager.keyChainSaveData(data: user.sessionID as Any, withIdentifier: user.name)
        if saveBool {
            print("存储成功")
        }else{
            print("存储失败")
        }
    }
    
    func readKeyChain(identifier: String)  {
        // 获取数据
        let getString = YLKeyChainManager.keyChainReadData(identifier: identifier) as! String
        print(getString)

    }
}

extension YLHomeViewController: LoginProtocol {
    func userLogin(name: String, password: String, completionHandler: (Bool, String?) -> ()) {
        if name == "void" && password == "123" {
            //            success
            completionHandler(true,nil)
            dissmissUnlogin()
            let json = YLFileManager.jsonParse(withLocalFileName: "user")
            if let user = YLUser.yy_model(with: json as! [AnyHashable : Any]) {
                YLUserManager.shared().currentUser = user
                reloadUserView(user)
            }
        } else {
            //            failed
            completionHandler(false,"登录失败，请重新登录")
        }
    }
}
