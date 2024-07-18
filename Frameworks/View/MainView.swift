//
//  MainView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic

struct MainView: View {
    @State private var navigationIcons = [
        "house.fill",
        "book.fill",
        "movieclapper.fill",
        "fireworks",
        "ellipsis.circle.fill"
    ]
    
    @State private var navigationTitles = [
        "Home",
        "Book",
        "Movie",
        "Culture",
        "More"
    ]
    
    @State private var currentIndex = 0
    
    @EnvironmentObject var userManagement: UserManagement
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            TabView {
                HomeView()
                    .tabItem {
                        Label(navigationTitles[0], systemImage: navigationIcons[0])
                    }
                
                BookView()
                    .tabItem {
                        Label(navigationTitles[1], systemImage: navigationIcons[1])
                    }
                
                MovieView()
                    .tabItem {
                        Label(navigationTitles[2], systemImage: navigationIcons[2])
                    }
                
                CultureView()
                    .tabItem {
                        Label(navigationTitles[3], systemImage: navigationIcons[3])
                    }
                
                MoreView()
                    .tabItem {
                        Label(navigationTitles[4], systemImage: navigationIcons[4])
                    }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            NavigationSplitView(sidebar: {
                ZStack{
                    Color.backgroundColor.ignoresSafeArea()
                    
                    VStack{
                        ForEach(0..<navigationIcons.count, id: \.self){ idx in
                            Button(action: {
                                currentIndex = idx
                            }){
                                HStack{
                                    Image(systemName: navigationIcons[idx])
                                    Text(navigationTitles[idx])
                                    
                                    Spacer()
                                }
                            }.buttonStyle(
                                SoftDynamicButtonStyle(
                                    RoundedRectangle(cornerRadius: 15),
                                    mainColor: currentIndex == idx ? Color.accentColor : Color.Neumorphic.main,
                                    textColor: currentIndex == idx ? Color.white: Color.Neumorphic.secondary,
                                    darkShadowColor: Color.Neumorphic.darkShadow,
                                    lightShadowColor: Color.Neumorphic.lightShadow,
                                    pressedEffect: SoftButtonPressedEffect.hard,
                                    padding: 16
                                )
                            )
                            
                            Spacer().frame(height: 20)
                        }
                        
                        Spacer()
                    }.padding(20)
                        .navigationTitle(Text("__A__.MUSE"))
                }

            }, detail: {
                switch currentIndex {
                case 0: HomeView()
                case 1: BookView()
                case 2: MovieView()
                case 3: CultureView()
                case 4: MoreView()
                default: HomeView()
                }
            })
        }
    }
}

#Preview {
    MainView()
        .environmentObject(UserManagement())
}
