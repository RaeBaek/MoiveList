//
//  MovieDetailCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieDetailCollectionViewController: UIViewController {
    
    @IBOutlet var backPosterImageView: UIImageView!
    @IBOutlet var sidePosterImageView: UIImageView!
    @IBOutlet var sidePosterImageScreenView: UIView!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var playButtonImage: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDiscriptionLabel: UILabel!
    @IBOutlet var entertainmentLabel: UILabel!
    
    @IBOutlet var overViewLabel: UILabel!
    
    var movieInfo = Movie(posterImageName: "", title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        configureViewController()
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureViewController() {
        
        title = movieInfo.title
        
        backPosterImageView.image = UIImage(named: movieInfo.posterImageName)
        backPosterImageView.contentMode = .scaleAspectFill
        
        sidePosterImageScreenView.clipsToBounds = true
        sidePosterImageScreenView.layer.cornerRadius = 15
        
        sidePosterImageView.image = UIImage(named: movieInfo.posterImageName)
        sidePosterImageView.contentMode = .scaleToFill
        
        playButton.tintColor = .white
        playButtonImage.image = UIImage(systemName: "play.circle")
        playButtonImage.tintColor = .white
        
        
        movieTitleLabel.text = movieInfo.title
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        movieDiscriptionLabel.text = movieInfo.movieDiscription
        movieDiscriptionLabel.textColor = .white
        movieDiscriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        entertainmentLabel.text = "CJ ENM | 12세이상관람가"
        entertainmentLabel.textColor = .white
        entertainmentLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        overViewLabel.text = movieInfo.overview
        overViewLabel.font = .systemFont(ofSize: 15, weight: .regular)
        overViewLabel.sizeToFit()
    }

}
