//
//  RealmModel.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/09/04.
//

import Foundation
import RealmSwift

class LibraryTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var thumbnail: String
    @Persisted var title: String
    @Persisted var publisher: String
    @Persisted var date: String
    @Persisted var price: Int
    @Persisted var sale: Int
    @Persisted var memo: String?
    
    convenience init(thumbnail: String, title: String, publisher: String, date: String, price: Int, sale: Int, memo: String?) {
        self.init()
        
        self.thumbnail = thumbnail
        self.title = title
        self.publisher = publisher
        self.date = date
        self.price = price
        self.sale = sale
        self.memo = memo
    }
}
