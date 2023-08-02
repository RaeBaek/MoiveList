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
    
    func configureCell(item: Movie) {
        
        backView.backgroundColor = UIColor(red: item.red / 255, green: item.green / 255, blue: item.blue / 255, alpha: 1.0)
        backView.layer.cornerRadius = 10
        
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
