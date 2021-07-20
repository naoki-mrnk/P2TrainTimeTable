//
//  TimetableViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    // Properties
    let timetableCellIdentifier = "timetableCell"
    
    // IBOutlets
    @IBOutlet weak var timetableLabel: UILabel!
    @IBOutlet weak var timetableTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        
        setupNavigationBar()
        setupSegmentedControl()
        setupLabel()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = K.RouteSelection.station
        // TODO: - 駅名と路線名を追加
    }
    
    func setupSegmentedControl() {
        segmentedControl.setTitle("上り", forSegmentAt: 0)
        segmentedControl.setTitle("下り", forSegmentAt: 1)
    }
    
    func setupLabel() {
        timetableLabel.text = K.TimeTable.timetable
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
