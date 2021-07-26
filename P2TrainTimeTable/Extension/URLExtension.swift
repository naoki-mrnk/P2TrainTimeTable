//
//  URLExtension.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/22.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import Foundation

extension URL {
    /// odpt:StationのURL
    static func stationURL(_ stationName: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = URLManager.getString(K.URL.scheme)
        urlComponents.host = URLManager.getString(K.URL.host)
        urlComponents.path = URLManager.getString(K.URL.station)
        urlComponents.queryItems = [
            URLQueryItem(name: K.URL.title, value: stationName),
            URLQueryItem(name: K.URL.consumerKey, value: URLManager.getString(K.URL.key))
        ]
        return urlComponents.url
    }
    
    /// odpt:RailwayのURL
    static func railwayURL(_ railway: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = URLManager.getString(K.URL.scheme)
        urlComponents.host = URLManager.getString(K.URL.host)
        urlComponents.path = URLManager.getString(K.URL.railway)
        urlComponents.queryItems = [
            URLQueryItem(name: K.URL.sameAs, value: railway),
            URLQueryItem(name: K.URL.consumerKey, value: URLManager.getString(K.URL.key))
        ]
        return urlComponents.url
    }
    
    /// odpt:StationTimetableのURL
    static func timetableURL(timetable: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = URLManager.getString(K.URL.scheme)
        urlComponents.host = URLManager.getString(K.URL.host)
        urlComponents.path = URLManager.getString(K.URL.timetable)
        urlComponents.queryItems = [
            URLQueryItem(name: K.URL.sameAs, value: timetable),
            URLQueryItem(name: K.URL.consumerKey, value: URLManager.getString(K.URL.key))
        ]
        return urlComponents.url
    }
}
