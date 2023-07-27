//
//  YLADViewTools.swift
//  YLNote
//
//  Created by tangh on 2023/7/24.
//  Copyright © 2023 tangh. All rights reserved.
//

/**
 监测广告自动曝光的逻辑
 */

import Foundation


extension UIView {
    /// 判断是否在满足曝光条件
    /// - Parameters:
    ///   - threshold: 曝光门槛
    ///   - coordinateSpace: 可视窗口坐标系
    /// - Returns: 是否满足曝光条件
    func isViewVisible(exposureRatio threshold:Double,to coordinateSpace: UICoordinateSpace) -> Bool {
        
        if self.isHidden || self.layer.isHidden || self.alpha == 0 {
            return false
        }

        let viewConvertedFrame = self.convert(self.bounds, to: coordinateSpace) // 将自身坐标系转换到可视区域坐标系后，view的frame
        let intersectRect = CGRectIntersection(coordinateSpace.bounds, viewConvertedFrame); // 交叉区域 bounds （bounds和frame最大的区别是bounds不带位置信息，只有size信息）
        if (intersectRect.size.width != 0 && intersectRect.size.height != 0) {
            let areaReal = intersectRect.size.width * intersectRect.size.height / (viewConvertedFrame.size.width * viewConvertedFrame.size.height);
//            print("交叉部分：\(intersectRect)===\(viewConvertedFrame)---\(areaReal*100)%")
            if (areaReal >= threshold) {
                return true;
            } else{
                return false;
            }
        }
        return false
    }
}
