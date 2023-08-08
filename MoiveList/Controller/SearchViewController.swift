//
//  SearchViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Library {
    var thumbnail: String
}

class SearchViewController: UIViewController {
    
    @IBOutlet var leftCloseBarButtonItem: UIBarButtonItem!
    @IBOutlet var bookSearchBar: UISearchBar!
    @IBOutlet var libraryCollectionView: UICollectionView!
    
    var library: [Library] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        configureLeftCloseBarButtonItem()
        
        libraryCollectionView.delegate = self
        libraryCollectionView.dataSource = self
        bookSearchBar.delegate = self
        bookSearchBar.placeholder = "검색어를 입력해주세요."
        
        setCollectionViewLayout()
        
    }
    
    @IBAction func closeBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    
    func callRequest(voca: String) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(voca)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        AF.request(url,
                   method: .get,
                   headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                self.library.removeAll()
                
                for item in json["documents"].arrayValue {
                    let thumbnail = item["thumbnail"].stringValue
                    let data = Library(thumbnail: thumbnail)
                    self.library.append(data)
                }
                
                print(self.library)
                
                self.libraryCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureLeftCloseBarButtonItem() {
        leftCloseBarButtonItem.image = UIImage(systemName: "xmark")
        leftCloseBarButtonItem.tintColor = .black
        
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return library.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        
        let urlString = library[indexPath.row].thumbnail
        
        guard let url = URL(string: urlString) else { return cell }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                cell.thumbnailImage.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        libraryCollectionView.collectionViewLayout = layout
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        callRequest(voca: text)
        
    }
}
