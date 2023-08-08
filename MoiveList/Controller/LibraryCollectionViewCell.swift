//
//  LibraryCollectionViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/08.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    static let identifier = "LibraryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
