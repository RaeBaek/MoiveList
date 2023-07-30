//
//  ViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/30.
//

import UIKit

class MovieTableViewController: UITableViewController {

    // 영화 리스트 '배열'을 받아오는 movieList 상수 선언
    let movieList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 셀의 높이 설정
        tableView.rowHeight = 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 어떤 셀을 보여줄 것인지에 대한 셀 정보를 guard else와 as? 다운캐스팅 구문으로 선언
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        // movieList.movies[indexPath.row]라는 반복되는 코드를 row 상수에 대입하여 row로 사용
        let row = movieList.movies[indexPath.row]
        
        // as? 다운캐스팅으로 cell 내부의 함수에 접근이 가능하다.
        // row를 인자로 넘겨 cell 파일에서 사용할 수 있도록 한다.
        cell.configureCell(row: row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 영화 리스트 배열 만큼 보여주기 위해 .count에 접근
        return movieList.movies.count
    }

}

