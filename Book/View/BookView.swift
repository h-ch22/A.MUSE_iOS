//
//  BookView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            EmptyView()
        }, detail: {
            ZStack{
                Color.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack{
                        
                    }.padding(20)
                }
            }
        })
    }
}

#Preview {
    BookView()
}
