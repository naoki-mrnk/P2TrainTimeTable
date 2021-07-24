//
//  URLManager.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/21.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

class URLManager {
    
    // Property
    static let property = loadURL()
    
    private init() {}
    
    private static func loadURL() -> [String : Any] {
        guard let path = Bundle.main.path(forResource: "url", ofType: "plist") else {
            return [:]
        }
        guard let datasourceDictionary = NSDictionary(contentsOfFile: path) as? [String : Any] else {
            return [:]
        }
        return datasourceDictionary
    }
    
    /// 指定されたキーの値を取得する
    /// String以外,keyに対応しないときはnilを返す
    static func getString(_ key: String) -> String {
        return property[key] as? String ?? ""
    }
}
