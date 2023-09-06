//
//  DetailBookViewController.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/09/06.
//

import UIKit
import RealmSwift

class DetailBookViewController: UIViewController {
    
    lazy var saveButton = {
        let view = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(saveButtonClicked))
        view.title = "저장"
        view.tintColor = .black
        return view
    }()
    
    @IBOutlet var memoTextField: UITextField!
    @IBOutlet var likeToggle: UISwitch!
    
    let realm = try! Realm()
    var data: LibraryTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congigure()
        
    }
    
    func congigure() {
        navigationItem.rightBarButtonItem = saveButton
        
        memoTextField.text = data?.memo
        guard let state = data?.like else { return }
        likeToggle.isOn = state
        
    }
    
    @objc func saveButtonClicked() {
        
        //Realm Update
        guard let data = data else { return }
        guard let memoText = memoTextField.text else { return }
        let isOn = likeToggle.isOn
        
        // 새로운 객체를 만들어서 '덮어쓰는 방법'
        // 수업에서 진행한 방법으로, value 에 설정한 컬럼을 제외한 다른 컬럼은 빈값으로 초기화 됨
        let item = LibraryTable(value: ["_id": data._id, "memo": memoText])
        
        do {
            try realm.write {
                // 원하는 부분만 업데이트를 하고자 할 때
                // 사용하는 realm.create
                // 새로운 객체를 생성해 덮어쓰는 것이 아닌 원하는 column의 내용만 수정하는 방법
                // value에 직접 값을 넣어준다.
                realm.create(LibraryTable.self, value: ["_id": data._id, "memo": memoText, "like": isOn], update: .modified)
            }
        } catch let error {
            print("Modified Error", error)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
