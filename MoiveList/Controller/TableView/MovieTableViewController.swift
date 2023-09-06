//
//  ViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/30.
//

import UIKit
import Kingfisher
import RealmSwift

class MovieTableViewController: UIViewController {

    @IBOutlet var searchButton: UIBarButtonItem!
    @IBOutlet var mainTableView: UITableView!
    
    // 영화 리스트 '구조체'를 받아오는 movieList 상수 선언
    let movieTableList = MovieInfo()
    
    let realm = try! Realm()
    
    var tasks: Results<LibraryTable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "!!!!!")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let nib = UINib(nibName: LibraryTableViewCell.identifier, bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: LibraryTableViewCell.identifier)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 150
        
        title = "영화목록"
        searchButton.tintColor = .black
        
        tasks = realm.objects(LibraryTable.self)
        print(realm.configuration.fileURL)
        
        // SchemaVersion
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("넘오왔슴~", #function)
        print(tasks)
        
        mainTableView.reloadData()
        
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}


extension MovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 영화 리스트 배열 만큼 보여주기 위해 .count에 접근
        guard let data = tasks else { return 0 }
        return data.count //movieTableList.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 어떤 셀을 보여줄 것인지에 대한 셀 정보를 guard else와 as? 다운캐스팅 구문으로 선언
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else {
//            return UITableViewCell()
//        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.identifier) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        
        // movieList.movies[indexPath.row] -> 반복되는 코드를 row 상수에 대입하여 row로 사용
//        let row = movieTableList.movies[indexPath.row]
        
        // as? 다운캐스팅으로 cell 내부의 함수에 접근이 가능하다.
        // row를 인자로 넘겨 cell 파일에서 사용할 수 있도록 한다.
//        cell.configureCell(row: row)
        
        // fileName 가장 마지막에 확장자 꼭 기입할 것 (ex .jpg)
        guard let data = tasks else { return UITableViewCell() }
        
        let image = loadImageFromDocument(fileName: "hoon_\(data[indexPath.row]._id).jpg")
        
        guard let memo = data[indexPath.row].memo else { return UITableViewCell() }
        
        cell.bookTitleLabel.text = data[indexPath.row].libraryTitle
        cell.thumbImageView.image = image
        cell.publisherLabel.text = "출판사: " + data[indexPath.row].publisher
        cell.dateLabel.text = "초판날짜: " + data[indexPath.row].date
        cell.priceLabel.text = "판매가: \(data[indexPath.row].price)원"
        cell.saleLabel.text = "세일가: \(data[indexPath.row].sale)원"
        cell.memoLabel.text = "메모: \(memo)"
        cell.likeLabel.text = "찜상태: \(data[indexPath.row].like)"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: DetailBookViewController.identifier) as? DetailBookViewController else {
            return
        }
        
        guard let data = tasks else { return }
        let item = data[indexPath.row]
        
        vc.data = item
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] action, view, completionHandler in
            print("삭제 선택!")
            
            guard let self else { return }
            
            //Realm Delegate
            
            guard let data = tasks else { return }
            
            let item = data[indexPath.row]
            
            removeImageFromDocument(fileName: "hoon_\(item._id).jpg")
            
            do {
                try realm.write {
                    self.realm.delete(item)
                }
                mainTableView.reloadData()
            } catch let error {
                print(error)
            }
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
