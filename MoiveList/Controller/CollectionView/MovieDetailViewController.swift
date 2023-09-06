//
//  MovieDetailCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

enum TransitionType {
    case modal
    case navigation
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var backPosterImageView: UIImageView!
    @IBOutlet var sidePosterImageView: UIImageView!
    @IBOutlet var sidePosterImageScreenView: UIView!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var playButtonImage: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDiscriptionLabel: UILabel!
    @IBOutlet var entertainmentLabel: UILabel!
    
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    
    var movieInfo: Movie?
    var type: TransitionType?
    var contents: String?
    
    let placeholderText = "내용을 입력해주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let type = type else {
            return
        }
        
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = .lightGray
        
        switch type {
        case .modal:
            let xImage = UIImage(systemName: "xmark")
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xImage, style: .plain, target: self, action: #selector(xButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .black
        case .navigation:
            let backImage = UIImage(systemName: "chevron.backward")
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .black
        }
        
        configureViewController()
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func xButtonClicked() {
        dismiss(animated: true)
    }
    
    func configureViewController() {
        
        guard let movieInfo = movieInfo else {
            return
        }
        
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

extension MovieDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        
    }
    
    // 편집이 시작될 때(커서가 시작될 때)
    // 플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝날 때(커서가 없어지는 순간)
    // 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
}
