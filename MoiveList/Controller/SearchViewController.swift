//
//  SearchViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var leftCloseBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        configureLeftCloseBarButtonItem()
        
    }
    
    @IBAction func closeBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func configureLeftCloseBarButtonItem() {
        leftCloseBarButtonItem.image = UIImage(systemName: "xmark")
        leftCloseBarButtonItem.tintColor = .black
        
    }

}
