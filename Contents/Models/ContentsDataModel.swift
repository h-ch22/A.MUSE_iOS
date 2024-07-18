//
//  ContentsDataModel.swift
//  A.MUSE
//
//  Created by 하창진 on 7/18/24.
//

import Foundation

struct ContentsDataModel: Hashable{
    let id: String
    let title: String
    let author: String
    let publisher: String
    let summary: String
    let url: URL
    let cover: URL>
    let type: ContentsTypeModel
    
    init(id: String, title: String, author: String, publisher: String, summary: String, url: URL, cover: URL?, type: ContentsTypeModel) {
        self.id = id
        self.title = title
        self.author = author
        self.publisher = publisher
        self.summary = summary
        self.url = url
        self.cover = cover
        self.type = type
    }
}
