//
//  BannerListModel.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic

struct BannerListModel: View {
    let data: BannerDataModel
    
    var body: some View {
        HStack{
            AsyncImage(url: data.url, content: {
                $0
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }, placeholder: {
                DotProgressView()
            }).frame(height: 150)
                .aspectRatio(contentMode: .fit)
            
            Spacer().frame(width: 10)
            
            VStack{
                HStack{
                    Text("\(data.title) | \(data.author)")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                }

                Spacer().frame(height: 10)
                
                HStack{
                    Text(data.sentence)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }

            }
        }.padding(10)
            .frame(height: 200)
            
    }
}

#Preview {
    BannerListModel(data: BannerDataModel(id: 0, url: URL(string: "")!, title: "Title", author: "Author", sentence: "Sentence"))
}
