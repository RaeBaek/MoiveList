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
    
    var tasks: Results<LibraryTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let nib = UINib(nibName: LibraryTableViewCell.identifier, bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: LibraryTableViewCell.identifier)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 150
        
        title = "영화목록"
        searchButton.tintColor = .black
        
        // Realm Read
        let realm = try! Realm()
        tasks = realm.objects(LibraryTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("넘오왔슴~", #function)
        print(tasks)
        
        mainTableView.reloadData()
        
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}


extension MovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 영화 리스트 배열 만큼 보여주기 위해 .count에 접근
        return tasks.count //movieTableList.movies.count
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
        
        let image = tasks[indexPath.row].bookPosterImage
        let url = URL(string: image)
        
        cell.posterImageView.kf.setImage(with: url)
        
        cell.bookTitleLabel.text = tasks[indexPath.row].bookTitle
        
        cell.publisherLabel.text = "출판사: " + tasks[indexPath.row].bookPublisher
        cell.dateLabel.text = "초판날짜: " + tasks[indexPath.row].bookDate
        cell.priceLabel.text = "판매가: \(tasks[indexPath.row].bookPrice)원"
        cell.saleLabel.text = "세일가: \(tasks[indexPath.row].bookSale)원"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 사용자가 클릭 한 테이블 뷰의 상세화면을 보기위해 detailVC을 선언
//        guard let vc = storyboard?.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {
//            return
//        }
        
//        let row = movieTableList.movies[indexPath.row]
//        vc.movieInfo = row
        
        // 네비게이션 푸시 기능을 사용하여 화면 전환
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
