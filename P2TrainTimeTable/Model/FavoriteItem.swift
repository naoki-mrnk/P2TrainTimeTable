//
//  FavoriteItem.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/25.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation
import RealmSwift

/// お気に入りの駅路線を管理
class FavoriteItem: Object {
    @objc dynamic var favoriteItemID: String = ""
    @objc dynamic var stationName: String = ""
    @objc dynamic var routeName: String = ""
    
    override static func primaryKey() -> String? {
        return "favoriteItemID"
    }
}
