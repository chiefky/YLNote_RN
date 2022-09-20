//
//  YLShare.swift
//  YLNote
//
//  Created by tangh on 2022/9/16.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
import Social

@objc protocol YLShareProtocol {
    func share(title:String,content:UIView,completeHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void);

    @objc optional static func shareFunc()
}


extension UIViewController: YLShareProtocol {

    func share(title: String,content: UIView,completeHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void) {
        //分享的标题
        let textToShare = title
        //分享的图片
        let imageToShare:UIImage = content.asImage()
        //如果想分享图片 就把图片添加进去 文字什么的同上
        let activityItems:[Any] = [textToShare,imageToShare];
        // 创建分享vc
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        // 根据需要指定不需要分享的平台
        activityVC.excludedActivityTypes = [.mail,.postToTwitter,.message,.print,.copyToPasteboard,.assignToContact,.addToReadingList,.postToFlickr,.postToVimeo,.postToWeibo,.airDrop,.openInIBooks];
        // 分享之后的回调
        activityVC.completionWithItemsHandler = completeHandler
        self.present(activityVC, animated: true, completion: nil)

    }

}
