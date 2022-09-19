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
    func mark(_ content:UIView, _ completeHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void);

    @objc optional static func shareFunc()
}


extension UIViewController: YLShareProtocol {
        
    func mark(_ content:UIView, _ completeHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void) {
        //分享的标题
        let textToShare = "分享的标题";
        //分享的图片
        let imageToShare:UIImage = content.asImage()
        //如果想分享图片 就把图片添加进去 文字什么的同上
        let activityItems:[Any] = [textToShare,imageToShare];
        // 创建分享vc
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        // 设置不出现在活动的项目
//        activityVC.excludedActivityTypes = [.print,.message,.mail,
//                                            .addToReadingList,.openInIBooks,.copyToPasteboard,
//                                            .assignToContact,.saveToCameraRoll];
        
        // 根据需要指定不需要分享的平台
        activityVC.excludedActivityTypes = [.mail,.postToTwitter,.message,.print,.copyToPasteboard,.assignToContact,.addToReadingList,.postToFlickr,.postToVimeo,.postToWeibo,.airDrop,.openInIBooks];
        // >=iOS8.0系统用这个方法
//        activityVC.completionWithItemsHandler = {(activityType,completed,returnedItems,activityError) in
//            if (completed) { // 确定分享
//                print("哈哈")
//            }
//            else {
//                print("哼哼")
//            }
//        };
//
        // 分享之后的回调
        activityVC.completionWithItemsHandler = completeHandler
        self.present(activityVC, animated: true, completion: nil)

    }

}
