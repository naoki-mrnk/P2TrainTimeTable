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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeSelectionTableView.delegate = self
        routeSelectionTableView.dataSource = self

        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = inputStationName + K.RouteSelection.station
    }
    
    func setupLabel() {
        routeLabel.text = K.RouteSelection.route
    }
}

// MARK: - UITableViewDataSource
extension RouteSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: routeCellIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RouteSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // TODO: - スワイプ -> 削除の処理
        }
        timetableTableView.reloadData()
    }
}
