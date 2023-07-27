//
//  YLDemoProtocol.swift
//  YLNote
//
//  Created by tangh on 2023/7/22.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

protocol YLDemoProtocol {
    func testFather(name: String) -> String
}

protocol YLDemoSonProtocol: YLDemoProtocol {
    func testSon(name:String) -> String
}

extension YLDemoProtocol {
    func testFather(name: String) -> String {
        print("this is \(name)")
        return "father"
    }
}


extension YLDemoSonProtocol {
    func testFather(name: String) -> String {
        print("this is \(name)")
        return "son"
    }

    func testSon(name:String) -> String {
        print("this is \(name)")
        return "son"
    }

}
