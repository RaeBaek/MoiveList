//
//  RecentlyCollectionViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/02.
//

import UIKit

class RecentlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    
    static var identifier = "RecentlyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
        
        backView.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.black.cgColor
        // 햇빛이 비추는 위치
        self.layer.shadowOffset = .zero //CGSize(width: 0, height: 0)
        // 섀도우 퍼짐의 정도
        self.layer.shadowRadius = 3
        // 섀도우 불투명도
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
        
    }
    
    func configureCell(item: Movie) {
        posterImageView.image = UIImage(named: item.posterImageName)
    }

}
