//
//  Movie.swift
//  MoiveList
//
//  Created by 백래훈 on 2023/07/30.
//

import Foundation

// 영화 구조체 생성
struct Movie {
    var posterImageName: String
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
    var like: Bool
    let red: Double
    let green: Double
    let blue: Double
    
    var movieDiscription: String {
        get {
            return "\(releaseDate) | \(runtime)분 | \(rate)점"
        }
    }
}
