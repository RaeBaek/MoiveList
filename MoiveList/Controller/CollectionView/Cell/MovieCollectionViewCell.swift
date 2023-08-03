//
//  MovieListCollectionViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet var backView: UIView!
    @IBOutlet var movietitleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.black.cgColor
        // 햇빛이 비추는 위치
        self.layer.shadowOffset = .zero //CGSize(width: 0, height: 0)
        // 섀도우 퍼짐의 정도
        self.layer.shadowRadius = 5
        // 섀도우 불투명도
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
    }
    
    func configureCell(item: Movie) {
        
        backView.backgroundColor = UIColor(red: item.red / 255, green: item.green / 255, blue: item.blue / 255, alpha: 1.0)
        
        movietitleLabel.text = item.title
        movietitleLabel.font = .systemFont(ofSize: 19, weight: .bold)
        movietitleLabel.textColor = .white
        
        
        rateLabel.text = "\(item.rate)"
        rateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        rateLabel.textColor = .white
        
        posterImageView.image = UIImage(named: item.posterImageName)
        posterImageView.contentMode = .scaleToFill
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink
        
        if item.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
