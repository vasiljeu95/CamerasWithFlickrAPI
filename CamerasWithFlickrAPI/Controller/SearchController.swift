//
//  SearchController.swift
//  CamerasWithFlickrAPI
//
//  Created by Stepan Vasilyeu on 3/9/20.
//  Copyright © 2020 Stepan Vasilyeu. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    private var timer: Timer?
    
    let networkService = NetworkService()
    var cameras = [Camera]()
    let searchController = UISearchController(searchResultsController: nil)
    let cameraApiKey = "2a63b8b33fa0595de0c2f9a38e0665a5"
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self //as? UISearchBarDelegate
    }
    
    func setupTableView() {
        view.backgroundColor = .white
        //let nibDetail = UINib(nibName: "CameraDetailCell", bundle: nil)
        tableView.register(CameraDetailCell.self, forCellReuseIdentifier: CameraDetailCell.reuseId)
        //let nib = UINib(nibName: "CameraCell", bundle: nil)
        tableView.register(CameraCell.self, forCellReuseIdentifier: CameraCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameras.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let camera = cameras[indexPath.row]
        
        switch camera.details != nil {
        case true:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CameraDetailCell.reuseId, for: indexPath) as? CameraDetailCell {
                cell.setCamera(camera: camera)
                return cell
            }
        case false:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CameraCell.reuseId, for: indexPath) as? CameraCell {
                cell.setCamera(camera: camera)
                return cell
            }
        }
        return UITableViewCell()
    }
    
//            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                let cell = tableView.dequeueReusableCell(withIdentifier: CameraCell.reuseId, for: indexPath) as! CameraCell
//                let camera = cameras[indexPath.row]
//                cell.setCamera(camera: camera)
//                return cell
//            }
                
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

// MARK: - UISearchBarDelegate
extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchCameras: String) {
        print(searchCameras)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTrack(apiKey: self.cameraApiKey, search: searchCameras) { [weak self](searchResults) in
                self?.cameras = searchResults?.cameras?.camera ?? []
                self?.tableView.reloadData()
            }
        })
    }
}
