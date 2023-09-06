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
    @Persisted var thumbnailImage: String
    @Persisted var libraryTitle: String
    @Persisted var publisher: String
    @Persisted var date: String
    @Persisted var price: Int
    @Persisted var sale: Int
    @Persisted var memo: String?
    @Persisted var like: Bool
    @Persisted var priceGap: String
    @Persisted var test: String
    @Persisted var count: Double
    
    convenience init(thumbnailImage: String, libraryTitle: String, publisher: String, date: String, price: Int, sale: Int, memo: String?) {
        self.init()
        
        self.thumbnailImage = thumbnailImage
        self.libraryTitle = libraryTitle
        self.publisher = publisher
        self.date = date
        self.price = price
        self.sale = sale
        self.memo = memo
        self.priceGap = "판매가격은 \(price)이고 세일가격은 \(sale)입니다!"
    }
}
