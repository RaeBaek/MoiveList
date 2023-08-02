//
//  PopularTableViewCell.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/08/02.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    static let identifier = "PopularTableViewCell"
    
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movietitleLabel: UILabel!
    @IBOutlet var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackView.clipsToBounds = true
        imageBackView.layer.cornerRadius = 10
        movietitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        movietitleLabel.textColor = .black
        movieDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        movieDescriptionLabel.textColor = .gray
        
        
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
