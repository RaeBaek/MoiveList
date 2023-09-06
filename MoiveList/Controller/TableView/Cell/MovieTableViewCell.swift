//
//  MovieTableViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/30.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // cell에서 보여주고자 하는 정보에 대한 변수들을 @IBOutlet 선언
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    // 셀을 꾸미기 위한 configureCell 함수.
    // 매개변수는 row 이며 Movie 인자를 받음.
    func configureCell(row: Movie) {
        posterImageView.image = UIImage(named: row.posterImageName)
        movieTitleLabel.text = row.title
        releaseDateLabel.text = row.movieDiscription
        overviewLabel.text = row.overview
        
    }
}
