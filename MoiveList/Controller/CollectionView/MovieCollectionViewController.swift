//
//  MovieListCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {
    
    @IBOutlet var rightSearchBarButtonItem: UIBarButtonItem!
    
    var movieCollectionList = MovieInfo() {
        didSet { // 변수가 달라짐을 감지
            collectionView.reloadData()
        }
    }
    
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
        nav.modalPresentationStyle = .fullScreen
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        let item = movieCollectionList.movies[indexPath.row]
        cell.configureCell(item: item)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(_ sender: UIButton) {
        print("\(sender.tag) clicked")
        movieCollectionList.movies[sender.tag].like.toggle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollectionList.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailCollectionViewController") as? MovieDetailCollectionViewController else {
            return
        }
        
        let item = movieCollectionList.movies[indexPath.row]
        
        vc.movieInfo = item
//        vc.configureViewController(item: item)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
