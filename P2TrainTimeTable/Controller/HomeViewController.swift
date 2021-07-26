//
//  HomeViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit
import  RealmSwift

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let favoriteCellIdentifier = "favoriteCell"
    let toRouteSelectionIdentifier = "toRouteSelection"
    let realmManager = RealmManager.shared
    var favoriteItems: Results<FavoriteItem>!
    
    // MARK: - IBOutlets
    @IBOutlet private weak var inputStationSearchBar: UISearchBar!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var favoriteListTableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        favoriteItems = realmManager.realm.objects(FavoriteItem.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteListTableView.reloadData()
    }
    
    func setup() {
        // TableView
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        // NavigationBar
        self.navigationItem.title = K.NavigationBar.search
        // SearchBar
        inputStationSearchBar.delegate = self
        inputStationSearchBar.placeholder = K.SearchBar.inputStationName
        // Label
        favoriteLabel.text = K.Label.favorite
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == toRouteSelectionIdentifier) {
            let routeSelectionView = segue.destination as! RouteSelectionViewController
            // TextFieldからtextを取得
            routeSelectionView.inputStationName = inputStationSearchBar.text!
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        
        // nilじゃなければ遷移
        
        let isEmpty = inputStationSearchBar.text?.isEmpty ?? false
        if isEmpty {
            let alert = UIAlertController(title: K.AlertMessage.pleaseEnterText, message: K.emptyWords, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: K.AlertAction.ok, style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: toRouteSelectionIdentifier, sender: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: favoriteCellIdentifier)
        let object = favoriteItems[indexPath.row]
        let item = realmManager.realm.object(ofType: FavoriteItem.self, forPrimaryKey: object.favoriteItemID)
        cell.textLabel!.text = item?.stationName
        cell.detailTextLabel?.text = item?.routeName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // TODO: - スワイプ -> 削除の処理
            let favoriteItem = favoriteItems[indexPath.row]
            
            try! realmManager.realm.write {
                
                realmManager.realm.delete(favoriteItem)
            }
            favoriteListTableView.reloadData()
        }
    }
}
