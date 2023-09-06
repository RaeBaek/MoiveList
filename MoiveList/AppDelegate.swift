//
//  AppDelegate.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/30.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Realm Table의 버전을 업데이트하고 싶다면 적어줘야할 코드
        let config = RealmSwift.Realm.Configuration(schemaVersion: 9) { migration, oldSchemaVersion in

            if oldSchemaVersion < 1 { } // like column (찜) 추가
            
            if oldSchemaVersion < 2 { } // like column (찜) 삭제
//
            if oldSchemaVersion < 3 {  // thumbnail -> thumbnailImage column 명 변경
                migration.renameProperty(onType: LibraryTable.className(), from: "thumbnail", to: "thumbnailImage")
            }
            
            if oldSchemaVersion < 4 {  // title -> libraryTitle column 명 변경
                migration.renameProperty(onType: LibraryTable.className(), from: "title", to: "libraryTitle")
            }

//            if oldSchemaVersion < 4 { } // column 명을 수정하는 경우 3과 같이 내부를 작성하지 않으면
//                                        // 수정 전 데이터가 모두 날라가게 된다. 주의 요망!
            
            if oldSchemaVersion < 5 { } // like column (찜) 추가

            if oldSchemaVersion < 6 { // diarySummary 컬럼 추가, title + contents 합쳐서 넣기
                migration.enumerateObjects(ofType: LibraryTable.className()) { oldObject, newObject in
                    guard let old = oldObject else { return }
                    guard let new = newObject else { return }

                    new["priceGap"] = "판매가격은 \(old["price"]!)이고 세일가격은 \(old["sale"]!)입니다!"
                }
            }
            
            if oldSchemaVersion < 7 { }
            
            if oldSchemaVersion < 8 {
                migration.enumerateObjects(ofType: LibraryTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 100
                }
            }
            
            if oldSchemaVersion < 9 {
                migration.enumerateObjects(ofType: LibraryTable.className()) { oldObject, newObject in
                    guard let old = oldObject else { return }
                    guard let new = newObject else { return }

                     // new optional, old optional
                    new["test"] = old["test"]

                    // new required, old optional
                    new["test"] = old["test"] ?? 11.0
                }
            }
        }
            
        Realm.Configuration.defaultConfiguration = config
        
            return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

