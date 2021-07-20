//
//  RouteSelectionViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit

class RouteSelectionViewController: UIViewController {
    
    // MARK: - Properties
    let routeCellIdentifier = "routeCell"
    let toTimetableIdentifier = "toTimeTable"
    /// Homeの検索ワードを格納する変数
    var inputStationName = String()
    
    // IBOutlets
    @IBOutlet weak var routeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = inputStationName + K.RouteSelection.station
    }
    
    func setupLabel() {
        routeLabel.text = K.RouteSelection.route
    }
}
