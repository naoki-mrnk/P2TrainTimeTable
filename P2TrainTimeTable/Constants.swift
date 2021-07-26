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
    
    struct URL {
        static let scheme = "Scheme"
        static let host = "Host"
        static let station = "Station"
        static let railway = "Railway"
        static let timetable = "Timetable"
        static let title = "dc:title"
        static let consumerKey = "acl:consumerKey"
        static let sameAs = "owl:sameAs"
        static let key = "Key"
    }
    
    struct NavigationBar {
        static let search = "検索"
        static let station = "駅"
        static let hyphen = " - "
    }
    
    struct SearchBar {
        static let inputStationName = "駅名を入力"
    }
    
    struct Label {
        static let favorite = "お気に入り"
        static let route = "路線"
        static let timetable = "時刻表"
    }
    
    struct AlertMessage {
        static let pleaseEnterText = "サーチバーに文字が入力されていません"
        static let registrationComplete = "登録完了"
        static let registered = "登録されています"
        static let isDeleted = "削除しますか?"
    }
    
    struct AlertAction {
        static let ok = "OK"
        static let delete = "Delete"
        static let cancel = "Cancel"
    }
    
    struct SegmentedControl {
        static let inbound = "上り"
        static let outbound = "下り"
    }
}
