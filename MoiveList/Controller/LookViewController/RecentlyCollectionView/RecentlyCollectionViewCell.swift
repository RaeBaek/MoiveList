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
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
    }
    
    func configureCell(item: Movie) {
        posterImageView.image = UIImage(named: item.posterImageName)
    }

}
