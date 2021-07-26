//
//  TimetableViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit
import RealmSwift

class TimetableViewController: UIViewController {
    
    // MARK: - Properties
    let timetableCellIdentifier = "timetableCell"
    let heart = UIImage(named: "heart")!
    let heartFill = UIImage(named: "heartFill")!
    var railwayInformations: [Railway] = []
    var timetableObjects: [Timetable] = []
    var timetable: [String] = []
    var stationName = String()
    var routeNameID = String()
    var routeName = String()
    let realmManager = RealmManager.shared
    var favoriteItems: Results<FavoriteItem>!
    let item = FavoriteItem()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var timetableLabel: UILabel!
    @IBOutlet private weak var timetableTableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getRouteName(railway: routeNameID)
        displayTimetable(timetable: timetable[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timetableTableView.reloadData()
    }
    func setup() {
        // SegmentedControl
        segmentedControl.setTitle(K.SegmentedControl.inbound, forSegmentAt: 0)
        segmentedControl.setTitle(K.SegmentedControl.outbound, forSegmentAt: 1)
        // Label
        timetableLabel.text = K.Label.timetable
        // TableView
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        favoriteItems = realmManager.realm.objects(FavoriteItem.self)
        timetableTableView.reloadData()
        // fab
        favoriteButton.setImage(heart, for: .normal)
//        favoriteButton.setImage(heartFill, for: .selected)
    }
    
    func getRouteName(railway: String) {
        let task = URLSession.shared.dataTask(with: URL.railwayURL(railway)!) { (data, response, error) in
            
            do {
                let data: [Railway] = try JSONDecoder().decode([Railway].self, from: data!)
                print(data)
                // navigationBarのsetup
                self.navigationItem.title = self.stationName + K.NavigationBar.station + K.NavigationBar.hyphen + data[0].title
                self.routeName = data[0].title
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func displayTimetable(timetable: String) {
        let task = URLSession.shared.dataTask(with: URL.timetableURL(timetable: timetable)!) { (data, response, error) in
            print(URL.timetableURL(timetable: timetable)!)
            do {
                let data: [Timetable] = try JSONDecoder().decode([Timetable].self, from: data!)
                print(data)
                self.timetableObjects.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.timetableTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func saveToDB() {
        try! realmManager.realm.write {
            item.favoriteItemID = timetable[0]
            item.stationName = self.stationName
            item.routeName = self.routeName
        }
        realmManager.writeDB(DB: item)
        
        let alert = UIAlertController(title: K.AlertMessage.registrationComplete, message: K.emptyWords, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: K.AlertAction.ok, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteFromDB() {
        let alert = UIAlertController(title: K.AlertMessage.registered, message: K.AlertMessage.isDeleted, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: K.AlertAction.delete, style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let favoriteItem = self.favoriteItems.filter("favoriteItemID == '\(self.routeNameID)'")
                
                do{
                    try self.realmManager.realm.write {
                        self.realmManager.realm.delete(favoriteItem)
                    }
                }catch {
                    print("Error \(error)")
                }
            }
        })
        let cancelButton = UIAlertAction(title: K.AlertAction.cancel, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        timetableObjects = []
        switch sender.selectedSegmentIndex {
        case 0:
            displayTimetable(timetable: timetable[0])
        case 1:
            displayTimetable(timetable: timetable[2])
        default:
            print("error")
        }
        self.timetableTableView.reloadData()
    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
        let result = favoriteItems.filter("favoriteItemID == '\(routeNameID)'")
        if (result.count == 0) {
            saveToDB()
        } else {
            deleteFromDB()
        }
    }
}

// MARK: - UITableViewDataSource
extension TimetableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timetableObjects = timetableObjects.first?.stationTimetableObject else {
            
            return 0
        }
        return timetableObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timetableCellIdentifier, for: indexPath)
        let timetableObject = timetableObjects[0]
        cell.textLabel?.text = timetableObject.stationTimetableObject[indexPath.row].departureTime
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TimetableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
