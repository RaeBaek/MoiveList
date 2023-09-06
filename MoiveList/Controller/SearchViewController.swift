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
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet var leftCloseBarButtonItem: UIBarButtonItem!
    @IBOutlet var bookSearchBar: UISearchBar!
    @IBOutlet var libraryTableView: UITableView!
    
    var library = LibraryList()
    
    let realm = try! Realm()
    
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        configureLeftCloseBarButtonItem()
        
        let nib = UINib(nibName: LibraryTableViewCell.identifier, bundle: nil)
        libraryTableView.register(nib, forCellReuseIdentifier: LibraryTableViewCell.identifier)
        
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
        libraryTableView.rowHeight = 150
        libraryTableView.prefetchDataSource = self
        
        bookSearchBar.delegate = self
        bookSearchBar.placeholder = "검색어를 입력해주세요."
        
    }
    
    @IBAction func closeBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
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
                        let thumbnailImage = item["thumbnail"].stringValue
                        let libraryTitle = item["title"].stringValue
                        let publisher = item["publisher"].stringValue
                        let date = item["datetime"].stringValue
                        let price = item["price"].intValue
                        let sale = item["sale_price"].intValue
                        
                        let data = Library(thumbnailImage: thumbnailImage, libraryTitle: libraryTitle, publisher: publisher, date: date, price: price, sale: sale, memo: "")
                        
                        self.library.list.append(data)
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        library.list.removeAll()
        
        guard let text = bookSearchBar.text else { return }
        callRequest(voca: text, page: page)
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if library.list.count - 1 == indexPath.row && !isEnd //&& page < 15
            {
                page += 1
                guard let voca = bookSearchBar.text else { return }
                callRequest(voca: voca, page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        print("====취소 \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.identifier) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        
        let image = library.list[indexPath.row].thumbnailImage
        let url = URL(string: image)
        
        cell.selectionStyle = .default
        cell.thumbImageView.kf.setImage(with: url)
        cell.bookTitleLabel.text = library.list[indexPath.row].libraryTitle
        
        cell.publisherLabel.text = "출판사: " + library.list[indexPath.row].publisher
        cell.dateLabel.text = "초판날짜: " + library.list[indexPath.row].date
        cell.priceLabel.text = "판매가: \(library.list[indexPath.row].price)원"
        cell.saleLabel.text = "세일가: \(library.list[indexPath.row].sale)원"
        cell.memoLabel.text = ""
        cell.likeLabel.text = ""
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = library.list[indexPath.row]
        
        let task = LibraryTable(thumbnailImage: data.thumbnailImage, libraryTitle: data.libraryTitle, publisher: data.publisher, date: data.date, price: data.price, sale: data.sale, memo: "")
        
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error {
            print("Add Task Error!!", error)
        }
        
        let imageLink = data.thumbnailImage
        guard let url = URL(string: imageLink) else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    // task는 LibraryTable의 인스턴스이다.
                    // LibraryTable은 realm 이므로 main에서 동작하고 있고 비동기 main에서 다뤄야한다.
                    self.saveImageToDocument(fileName: "hoon_\(task._id).jpg", image: image)
                    
                }
                
            } catch {
                print("error")
            }
        }
        
        print("저장됩니다!")
        
        // Alert 구현
        let alert = UIAlertController(title: "추가되었습니다!", message: "선택하신 도서가 메인화면에 추가되었습니다.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}
