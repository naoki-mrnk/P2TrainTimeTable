//
//  Railway.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/24.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

struct Railway: Decodable {
    
    let title: String

    enum CodingKeys: String, CodingKey {
        
        case title = "dc:title"
    }
}
