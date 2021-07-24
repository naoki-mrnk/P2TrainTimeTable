//
//  TimetableViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    // MARK: - Properties
    let timetableCellIdentifier = "timetableCell"
    let heart = UIImage(named: "heart")!
    let heartFill = UIImage(named: "heartFill")!
    var stationName = String()
    var routeName = String()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var timetableLabel: UILabel!
    @IBOutlet private weak var timetableTableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        // NavigationBar
        self.navigationItem.title = stationName + K.RouteSelection.station + K.hyphen + routeName
        // TODO: - 駅名と路線名を追加
        // SegmentedControl
        segmentedControl.setTitle(K.TimeTable.inbound, forSegmentAt: 0)
        segmentedControl.setTitle(K.TimeTable.outbound, forSegmentAt: 1)
        // Label
        timetableLabel.text = K.TimeTable.timetable
        // TableView
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        // fab
        favoriteButton.setImage(heart, for: .normal)
        favoriteButton.setImage(heartFill, for: .selected)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
    }
}

// MARK: - UITableViewDataSource
extension TimetableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timetableCellIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TimetableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
