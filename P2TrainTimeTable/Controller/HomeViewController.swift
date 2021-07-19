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
        
        setupNavigationBar()
        setupTextField()
        setupLabel()
        
        inputStationSearchBar.delegate = self
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "検索"
    }
    
    func setupTextField() {
        inputStationSearchBar.placeholder = "駅名を入力"
    }
    
    func setupLabel() {
        favoriteLabel.text = "お気に入り"
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
        if inputStationSearchBar.text != nil {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellIdentifier, for: indexPath)
        
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
