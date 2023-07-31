//
//  MovieDetailCollectionViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class MovieDetailCollectionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    var navigationTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = navigationTitle
        titleLabel.text = navigationTitle
        
        let backImage = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
