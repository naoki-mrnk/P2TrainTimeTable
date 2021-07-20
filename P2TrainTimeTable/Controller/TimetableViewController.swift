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
    let timetableCell = "timetableCell"
    
    // IBOutlets
    @IBOutlet weak var timetableLabel: UILabel!
    @IBOutlet weak var timetableTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
