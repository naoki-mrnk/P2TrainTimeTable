//
//  Constants.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

struct K {
    static let emptyWords = ""
    static let hyphen = "-"
    
    struct URL {
        static let scheme = "Scheme"
        static let host = "Host"
        static let station = "Station"
        static let timetable = "Timetable"
        static let title = "dc:title"
        static let consumerKey = "acl:consumerKey"
        static let sameAs = "owl:sameAs"
        static let key = "Key"
        
    }
    
    
    struct Home {
        static let search = "検索"
        static let inputStationName = "駅名を入力"
        static let favorite = "お気に入り"
    }
    
    struct RouteSelection {
        static let station = "駅"
        static let route = "路線"
    }
    
    struct TimeTable {
        static let timetable = "時刻表"
        static let inbound = "上り"
        static let outbound = "下り"
    }
}
