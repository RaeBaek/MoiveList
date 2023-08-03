//
//  LookViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/02.
//

import UIKit

class LookViewController: UIViewController {
    
    @IBOutlet var recentlyCollectionView: UICollectionView!
    @IBOutlet var popularTableView: UITableView!
    
    let data = MovieInfo()
    // 서치바 초기화
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "둘러보기"
        
        let collectionNib = UINib(nibName: "RecentlyCollectionViewCell", bundle: nil)
        recentlyCollectionView.register(collectionNib, forCellWithReuseIdentifier: "RecentlyCollectionViewCell")
        recentlyCollectionView.delegate = self
        recentlyCollectionView.dataSource = self
        
        let tableNib = UINib(nibName: "PopularTableViewCell", bundle: nil)
        popularTableView.register(tableNib, forCellReuseIdentifier: "PopularTableViewCell")
        popularTableView.delegate = self
        popularTableView.dataSource = self
        
        configureRecentlyCollectionViewLayout()
        configurePopularTableViewLayout()
        
    }
    
    func configureRecentlyCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = 80
        let height = (width / 2) * 3
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        recentlyCollectionView.collectionViewLayout = layout
    }
    
    func configurePopularTableViewLayout() {
        popularTableView.rowHeight = 130
    }
    

}

extension LookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyCollectionViewCell.identifier, for: indexPath) as? RecentlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = data.movies[indexPath.row]
        
        cell.configureCell(item: item)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        let item = data.movies[indexPath.row]
        vc.movieInfo = item
        vc.type = .modal
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
    }
    
}

extension LookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier) as? PopularTableViewCell else  {
            return UITableViewCell()
        }
        
        let row = data.movies[indexPath.row]
        
        cell.configureCell(row: row)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {
            return
        }
        
        let row = data.movies[indexPath.row]
        vc.movieInfo = row
        vc.type = .modal
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
}
