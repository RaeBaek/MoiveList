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
    @Persisted var bookPosterImage: String
    @Persisted var bookTitle: String
    @Persisted var bookPublisher: String
    @Persisted var bookDate: String
    @Persisted var bookPrice: Int
    @Persisted var bookSale: Int
    
    
    convenience init(bookPosterImage: String, bookTitle: String, bookPublisher: String, bookDate: String, bookPrice: Int, bookSale: Int) {
        self.init()
        
        self.bookPosterImage = bookPosterImage
        self.bookTitle = bookTitle
        self.bookPublisher = bookPublisher
        self.bookDate = bookDate
        self.bookPrice = bookPrice
        self.bookSale = bookSale
    }
}
