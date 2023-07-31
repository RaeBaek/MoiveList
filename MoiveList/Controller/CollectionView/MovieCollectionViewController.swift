//
//  MovieListCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {
    
    @IBOutlet var rightSearchBarButtonItem: UIBarButtonItem!
    
    let movieCollectionList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        title = "래훈님의 책장"
        
        configureRightSearchBarButtonItem()
        
        setCollectionViewLayout()
        
    }
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else {
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .overFullScreen
        
        present(nav, animated: true)
    }
    
    func configureRightSearchBarButtonItem() {
        rightSearchBarButtonItem.image = UIImage(systemName: "magnifyingglass")
        
        rightSearchBarButtonItem.tintColor = .black
    }
    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = movieCollectionList.movies[indexPath.row]
        
        cell.configureCell(item: item)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollectionList.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieDetailCollectionViewController") as? MovieDetailCollectionViewController else {
            return
        }
        
        vc.navigationTitle = movieCollectionList.movies[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
