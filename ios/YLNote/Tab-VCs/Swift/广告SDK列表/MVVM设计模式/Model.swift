//
//  YLADInfo.swift
//  YLNote
//
//  Created by tangh on 2023/7/25.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation
struct YLADInfo {
    var adId:String = "1"
    var adPicUrls:[String] = []
    var adTitle:String = "大图"
    var adLink:String = ""
    init(adId: String) {
        self.adId = adId
    }
}


// MARK: Model
class YLNews {
    private var ads:[YLAdProtocol]
    private var actors: [Actor]
    private var position:[Int]
    var allDatas: [Any] {
        var datas: [Any] = self.actors
        self.insertElements(from: ads, into: &datas, at: position)
        return datas
    }

    init(ads: [YLAdProtocol], actors: [Actor], position: [Int]) {
        self.ads = ads
        self.actors = actors
        self.position = position
    }
    
    
    func insertElements(from arrayB: [Any], into arrayA: inout [Any], at positions: [Int]) {
        guard arrayB.count == positions.count else {
            print(" number of elements in arrayB should be equal to the number of positions.")
            return
        }
        for (index, element) in arrayB.enumerated() {
            let position = positions[index]
            
            if position >= 0 && position <= arrayA.count {
                arrayA.insert(element, at: position)
            } else {
                print("Invalid position: \(position)")
            }
        }
    }
}

class YLActorCellModel {
    var avatar: String
    var name: String
    init(avatar: String, name: String) {
        self.avatar = avatar
        self.name = name
    }
    
}

/// Model
protocol YLAdProtocol {
    var adId: String { get set }
    var adImages: [String] { get set }
    var adLink: String { get set }

    func display()
    func click()
    
}

extension YLAdProtocol {
    
    var adLink: String {
        get {
            return adLink
        }
        set {
            adLink = newValue
        }
    }
    
    var adImages: [String] {
        get {
            return adImages
        }
        set {
            self.adImages = newValue
        }
    }

    func display() {
        
    }
    
    func click() {
        
    }
}

class YLAdBig: YLAdProtocol {
    var adLink: String
    var adId: String
    var imageUrl:String
    init(adId: String, imageUrl: String, adLink:String? = nil) {
        self.adId = adId
        self.imageUrl = imageUrl
        self.adLink = adLink ?? ""
    }
    
}

class YLAdSmall: YLAdProtocol {
    var adId: String
    var imageUrl:String
    var title:String = ""
    init(adId: String, imageUrl: String, title: String) {
        self.adId = adId
        self.title = title
        self.imageUrl = imageUrl
    }
}


class YLAdThree: YLAdProtocol {
    var adId: String
    var adImages: [String] {
        didSet {
            self.adImages = self.adImages.count > 3 ? Array(self.adImages.prefix(3)) : self.adImages
        }
    }
    init(adId: String, adLink: String, adImages: [String]) {
        self.adId = adId
        self.adImages = adImages
    }
}
