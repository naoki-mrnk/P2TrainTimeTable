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
    @IBOutlet weak var routeSelectionTableView: UITableView!
    
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        // NavigationBar
        self.navigationItem.title = inputStationName + K.RouteSelection.station
        // Label
        routeLabel.text = K.RouteSelection.route
        // TableView
        routeSelectionTableView.delegate = self
        routeSelectionTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension RouteSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: routeCellIdentifier)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RouteSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
