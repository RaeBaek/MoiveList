//
//  PopularTableViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/02.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movietitleLabel: UILabel!
    @IBOutlet var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        movietitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        movietitleLabel.textColor = .black
        movieDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        movieDescriptionLabel.textColor = .gray
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
        
        imageBackView.layer.cornerRadius = 10
        imageBackView.layer.shadowColor = UIColor.black.cgColor
        // 햇빛이 비추는 위치
        imageBackView.layer.shadowOffset = .zero //CGSize(width: 0, height: 0)
        // 섀도우 퍼짐의 정도
        imageBackView.layer.shadowRadius = 3
        // 섀도우 불투명도
        imageBackView.layer.shadowOpacity = 0.5
//        imageBackView.clipsToBounds = true
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(row: Movie) {
        posterImageView.image = UIImage(named: row.posterImageName)
        movietitleLabel.text = row.title
        movieDescriptionLabel.text = row.movieDiscription
    }
    
}
