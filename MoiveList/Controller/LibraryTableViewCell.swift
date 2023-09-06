//
//  LibraryTableViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/09.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var publisherLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var saleLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.contentMode = .scaleToFill
        bookTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        publisherLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.font = .systemFont(ofSize: 13, weight: .regular)
        saleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        memoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        likeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
    }
    
    deinit {
        print("셀 deinit 됨!")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
