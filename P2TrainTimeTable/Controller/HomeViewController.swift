//
//  HomeViewController.swift
//  P2TrainTimeTable
//
//  Created by naoki-mrnk on 2021/07/19.
//  Copyright © 2021 naoki-mrnk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Property
    let favoriteCellIdentifier = "favoriteCell"
    let toRouteSelectionIdentifier = "toRouteSelection"
    
    // MARK: - IBOutlets
    @IBOutlet weak var inputStationSearchBar: UISearchBar!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteListTableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        // NavigationBar
        self.navigationItem.title = K.Home.search
        // SearchBar
        inputStationSearchBar.delegate = self
        inputStationSearchBar.placeholder = K.Home.inputStationName
        // Label
        favoriteLabel.text = K.Home.favorite
        // TableView
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
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
            let alert = UIAlertController(title: K.Home.pleaseEnterText, message: K.emptyWords, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: K.ok, style: UIAlertAction.Style.cancel, handler: {
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
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: favoriteCellIdentifier)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // TODO: - スワイプ -> 削除の処理
        }
        favoriteListTableView.reloadData()
    }
}
