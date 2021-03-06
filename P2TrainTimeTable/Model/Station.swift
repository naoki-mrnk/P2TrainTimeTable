//
//  Station.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/20.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

struct Station: Decodable {
    
    let title: String
    let railway: String
    let stationTimetable: [String]?
    let sameAs: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "dc:title"
        case railway = "odpt:railway"
        case stationTimetable = "odpt:stationTimetable"
        case sameAs = "owl:sameAs"
    }
}
