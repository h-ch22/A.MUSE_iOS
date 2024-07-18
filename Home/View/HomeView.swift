//
//  HomeView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic
import SwiftUIPager

struct HomeView: View {
    @StateObject private var bannersHelper = BannersHelper()
    @StateObject private var page: Page = .first()
    
    @State private var showBanner = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack{
                        if showBanner {
                            Pager(page: page,
                                  data: bannersHelper.bannerList,
                                  id: \.self){
                                BannerListModel(data: $0)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15).fill(Color.Neumorphic.main).softOuterShadow()
                                    )
                            }.itemAspectRatio(1.0)
                                .itemSpacing(10)
                                .interactive(scale: 0.8)
                                .frame(height: 300)
                        } else {
                            DotProgressView()
                        }
                        
                    }.padding(20)
                    
                }
                .navigationTitle(Text("Home"))
                .onAppear {
                    bannersHelper.getBanners(completion: { result in
                        guard let result = result else {return}
                        
                        if result { showBanner = true }
                    })
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
