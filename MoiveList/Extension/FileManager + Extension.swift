//
//  FileManager + Extension.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func removeImageFromDocument(fileName: String) {
        // 1. Document 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 경로 설정(세부경로, 이미지가 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print("ImageFile Remove Error", error)
        }
    }
    
    // Document 폴더에서 이미지를 가져오는 메서드
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        // 1. document 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return UIImage(systemName: "questionmark.square.dashed") ?? UIImage()
        }
        
        // 2. 경로 설정 (세부경로, 이미지가 저장되이 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path) ?? UIImage()
        } else {
            return UIImage(systemName: "questionmark.square.dashed") ?? UIImage()
        }
    }
    
    // Document 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: String, image: UIImage) {
        // 1. Document 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 저장할 경로 설정 (세부경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 3. 이미지 변환
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        // 4. 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("Imagefile Save error", error)
        }
    }
    
}
