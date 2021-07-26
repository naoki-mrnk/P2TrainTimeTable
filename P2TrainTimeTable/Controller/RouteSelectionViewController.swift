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
    /// 駅の情報を格納する配列
    var staionInformations: [Station] = []
    var timetable: [String] = []
    var staionName = String()
    var routeNameID = String()
    
    
    // MARK: - IBOutlets
    @IBOutlet private weak var routeLabel: UILabel!
    @IBOutlet private weak var routeSelectionTableView: UITableView!
    
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        print(inputStationName)
        displayRoute(stationName: inputStationName, staionInformation: staionInformations)
        staionName = inputStationName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        routeSelectionTableView.reloadData()
    }
    
    func setup() {
        // NavigationBar
        self.navigationItem.title = inputStationName + K.NavigationBar.station
        // Label
        routeLabel.text = K.Label.route
        // TableView
        routeSelectionTableView.delegate = self
        routeSelectionTableView.dataSource = self
    }
    
    func displayRoute(stationName: String, staionInformation: [Station]?) {
        print("++++++")
        print(URL.stationURL(stationName)!)
        print("++++++")
        let task = URLSession.shared.dataTask(with: URL.stationURL(stationName)!) { (data, response, error) in

            do {
                let data: [Station] = try JSONDecoder().decode([Station].self, from: data!)
                self.staionInformations = data
                DispatchQueue.main.async {
                    self.routeSelectionTableView.reloadData()
                }
                print(data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == toTimetableIdentifier) {
            let timetableView = segue.destination as! TimetableViewController
            
            timetableView.stationName = staionName
            timetableView.routeNameID = routeNameID
            timetableView.timetable = timetable
        }
    }
}

// MARK: - UITableViewDataSource
extension RouteSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staionInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let routeCell = tableView.dequeueReusableCell(withIdentifier: routeCellIdentifier, for: indexPath)
        let stationInformation = staionInformations[indexPath.row]
        routeCell.textLabel?.text = stationInformation.railway
        
        return routeCell
    }
}

// MARK: - UITableViewDelegate
extension RouteSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routeNameID = staionInformations[indexPath.row].railway
        timetable = staionInformations[indexPath.row].stationTimetable!
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: self.toTimetableIdentifier, sender: nil)
    }
}
