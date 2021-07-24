//
//  Timetable.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/24.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

struct Timetable: Decodable {
    let stationTimetableObject: [TimetableObject]
    
    enum CodingKeys: String, CodingKey {
        case stationTimetableObject = "odpt:stationTimetableObject"
    }
}
