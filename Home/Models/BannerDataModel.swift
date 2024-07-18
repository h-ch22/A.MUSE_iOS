//
//  BannerDataModel.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import Foundation

struct BannerDataModel: Hashable{
    let id: Int
    let url: URL
    let title: String
    let author: String
    let sentence: String
    
    init(id: Int, url: URL, title: String, author: String, sentence: String) {
        self.id = id
        self.url = url
        self.title = title
        self.author = author
        self.sentence = sentence
    }
}
