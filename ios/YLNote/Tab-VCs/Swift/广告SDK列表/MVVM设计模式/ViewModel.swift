//
//  YLAdViewModel.swift
//  YLNote
//
//  Created by tangh on 2023/7/25.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

enum AdCellModelType {
    case big
    case small
    case three
    case gif
    case video(picBig:Bool)
}

protocol YLAdCellModelProtocol {
    var type: AdCellModelType {get}
    var exposure: Bool { get set }
    mutating func change(exposure:Bool)
}

extension YLAdCellModelProtocol {
    mutating func change(exposure:Bool) {
    }
}


// MARK: ViewModel
class YLNewsViewModel {
    private var model:YLNews
    var allCellModels: [Any] = []
    init(model: YLNews) {
        self.model = model
        self.constructAllCellModels()
    }
    
    func constructAllCellModels() {
        var datas: [Any] = []
            for data in model.allDatas {
                if let small = data as? YLAdSmall {
                    let cellModel = YLAdSmallCellModel(imageUrl: small.imageUrl, title: small.title)
                    datas.append(cellModel)
                }
                if let big = data as? YLAdBig {
                    let cellModel = YLAdBigCellModel(imageUrl: big.imageUrl)
                    datas.append(cellModel)
                }
                if let three = data as? YLAdThree {
                    let cellModel = YLAdThreeCellModel(adImages: three.adImages)
                    datas.append(cellModel)
                }
                if let actor = data as? Actor {
                    let cellModel = YLActorCellModel(avatar: actor.avatar, name: actor.name)
                    datas.append(cellModel)
                }
            }
        self.allCellModels =  datas
    }
}

/// 图文
class YLAdSmallCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false
    func change(exposure:Bool) {
        self.exposure = exposure
    }

    var type: AdCellModelType {
        return .small
    }
    var imageUrl: String
    var title: String
    init(imageUrl: String, title: String) {
        self.imageUrl = imageUrl
        self.title = title
    }
}

/// 三图
class YLAdThreeCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false
    func change(exposure:Bool) {
        self.exposure = exposure
    }
    var type: AdCellModelType {
        .three
    }
    var adImages:[String]
    init(adImages: [String]) {
        self.adImages = adImages
    }
}

/// 大图
class YLAdBigCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false
    func change(exposure:Bool) {
        self.exposure = exposure
    }

    var type: AdCellModelType {
        return .big
    }

    var imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

/// 视频大图
class YLAdVideoBigCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false

    var type: AdCellModelType {
        return .video(picBig: true)
    }
    var imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

/// 视频图文
class YLAdVideoSmallCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false

    var type: AdCellModelType {
        return .video(picBig: false)
    }
    var imageUrl: String
    var title: String
    init(imageUrl: String, title: String) {
        self.imageUrl = imageUrl
        self.title = title
    }
}

/// gif
class YLAdGifCellModel: YLAdCellModelProtocol {
    var exposure: Bool = false

    var type: AdCellModelType {
        return .gif
    }
    var imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }

}

/// 全屏
class YLAdFullScreenViewModel {
    var exposure: Bool = false

    var imageUrl: String
    var adLink:String
    init(imageUrl: String, adLink: String) {
        self.imageUrl = imageUrl
        self.adLink = adLink
    }
}

