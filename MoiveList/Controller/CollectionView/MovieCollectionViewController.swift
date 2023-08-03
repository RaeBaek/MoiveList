//
//  MovieListCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieCollectionViewController: UIViewController {
    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var rightSearchBarButtonItem: UIBarButtonItem!
    
    var movieCollectionList = MovieInfo() {
        didSet { // 변수가 달라짐을 감지
            movieCollectionView.reloadData()
        }
    }
    
    var searchCollectionList: MovieInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RB님의 책장"
        
        // 검색리스트에 기본 영화리스트를 대입
        searchCollectionList = movieCollectionList
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "검색할 영화를 입력해주세요."
        
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
        
        movieCollectionView.collectionViewLayout = layout
        
    }
    
}

extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        guard let searchCollectionList = searchCollectionList else {
            return UICollectionViewCell()
        }
        let item = searchCollectionList.movies[indexPath.row]
        cell.configureCell(item: item)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(_ sender: UIButton) {
        print("\(sender.tag) clicked")
        movieCollectionList.movies[sender.tag].like.toggle()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = searchCollectionList?.movies.count else {
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {
            return
        }
        
        let item = movieCollectionList.movies[indexPath.row]
        
        vc.movieInfo = item
        vc.type = .navigation
//        vc.configureViewController(item: item)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MovieCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchCollectionList?.movies.removeAll()
        // 반복문 시작
        for item in movieCollectionList.movies {
            guard let text = searchBar.text else {
                return
            }
            // item의 영화 이름이 서치바의 문자를 가지고 있다면?
            if text == "" {
                searchCollectionList = movieCollectionList
            } else if item.title.contains(text) {
                // 서치 리스트에 추가
                searchCollectionList?.movies.append(item)
            } else {
                
            }
        }
        // 추가 후 컬렉션 뷰 리로드!
        movieCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchCollectionList = movieCollectionList
        searchBar.text = nil
        movieCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCollectionList?.movies.removeAll()
        // 반복문 시작
        for item in movieCollectionList.movies {
            guard let text = searchBar.text else {
                return
            }
            // item의 영화 이름이 서치바의 문자를 가지고 있다면?
            if text == "" {
                searchCollectionList = movieCollectionList
            } else if item.title.contains(text) {
                // 서치 리스트에 추가
                searchCollectionList?.movies.append(item)
            } else {
                
            }
        }
        // 추가 후 컬렉션 뷰 리로드!
        movieCollectionView.reloadData()
    }
}
