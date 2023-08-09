//
//  SearchViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Library {
    var thumbnail: String
    var title: String
    var publisher: String
    var date: String
    var price: Int
    var sale: Int
}

class SearchViewController: UIViewController {
    
    @IBOutlet var leftCloseBarButtonItem: UIBarButtonItem!
    @IBOutlet var bookSearchBar: UISearchBar!
    @IBOutlet var libraryCollectionView: UICollectionView!
    @IBOutlet var libraryTableView: UITableView!
    
    var library: [Library] = []
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        configureLeftCloseBarButtonItem()
        
        //        libraryCollectionView.delegate = self
        //        libraryCollectionView.dataSource = self
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
        libraryTableView.rowHeight = 150
        libraryTableView.prefetchDataSource = self
        
        bookSearchBar.delegate = self
        bookSearchBar.placeholder = "검색어를 입력해주세요."
        
        //        setCollectionViewLayout()
        
    }
    
    @IBAction func closeBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    
    func callRequest(voca: String, page: Int) {
        guard let text = voca.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        
        print(url)
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                guard let statusCode = response.response?.statusCode else { return print("에러발생!")}
                
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    print(self.isEnd)
                    
                    for item in json["documents"].arrayValue {
                        let thumbnail = item["thumbnail"].stringValue
                        let title = item["title"].stringValue
                        let publisher = item["publisher"].stringValue
                        let date = item["datetime"].stringValue
                        let price = item["price"].intValue
                        let sale = item["sale_price"].intValue
                        
                        let data = Library(thumbnail: thumbnail, title: title, publisher: publisher, date: date, price: price, sale: sale)
                        self.library.append(data)
                    }
                    self.libraryTableView.reloadData()
                    
                } else {
                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요!")
                }
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
    
    //    func setCollectionViewLayout() {
    //
    //        let layout = UICollectionViewFlowLayout()
    //
    //
    //        let spacing: CGFloat = 16
    //        let width = UIScreen.main.bounds.width - (spacing * 3)
    //
    //        layout.scrollDirection = .vertical
    //
    //        layout.itemSize = CGSize(width: width / 2, height: width / 2)
    //        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    //
    //        layout.minimumLineSpacing = spacing
    //        layout.minimumInteritemSpacing = spacing
    //
    //        libraryCollectionView.collectionViewLayout = layout
    //
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        library.removeAll()
        
        guard let text = bookSearchBar.text else { return }
        callRequest(voca: text, page: page)
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if library.count - 1 == indexPath.row && !isEnd //&& page < 15
            {
                page += 1
                guard let voca = bookSearchBar.text else { return }
                callRequest(voca: voca, page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소 \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.identifier) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        
        let image = library[indexPath.row].thumbnail
        let url = URL(string: image)
        
        cell.posterImageView.kf.setImage(with: url)
        cell.bookTitleLabel.text = library[indexPath.row].title
        
        cell.publisherLabel.text = "출판사: " + library[indexPath.row].publisher
        cell.dateLabel.text = "초판날짜: " + library[indexPath.row].date
        cell.priceLabel.text = "판매가: \(library[indexPath.row].price)원"
        cell.saleLabel.text = "세일가: \(library[indexPath.row].sale)원"
        
        return cell
    }
    
}
