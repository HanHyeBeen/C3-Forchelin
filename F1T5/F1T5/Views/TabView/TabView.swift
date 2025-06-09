//
//  TabView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI

enum Tab {
    case recommend
    case restaurants
    case favorite
}

struct CustomTabView: View {
    
    @Binding var selectedTab: Tab

    var body: some View {
        HStack(spacing: 80) {
            Button {
                selectedTab = .recommend
            } label: {
                VStack(spacing: 8) {
                    if selectedTab == .recommend {
                        Image(systemName: "sparkles")
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.postechOrange)
                    } else {
                        Image(systemName: "sparkles")
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    }
                    
                    Text(" 추천 ")
                        .foregroundColor(selectedTab == .recommend ? Color.postechOrange : Color(red: 0.6, green: 0.6, blue: 0.6))
                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                }
//                .offset(x: -5)
            }
//            .padding(.horizontal, UIScreen.main.bounds.width/4 - 30)
            
            Button {
                selectedTab = .restaurants
            } label: {
                VStack(spacing: 8) {
                    if selectedTab == .restaurants {
                        Image(systemName: "scroll.fill")
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.postechOrange)
                    } else {
                        Image(systemName: "scroll.fill")
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    }
                    
                    Text("식당 목록")
                        .foregroundColor(selectedTab == .restaurants ? Color.postechOrange : Color(red: 0.6, green: 0.6, blue: 0.6))
                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                }
//                .offset(x: 5)
            }
//            .padding(.horizontal, UIScreen.main.bounds.width/4 - 30)
            
            Button {
                selectedTab = .favorite
            } label: {
                VStack(spacing: 8) {
                    if selectedTab == .favorite {
                        Image("favIconAc")
                            .frame(width: 15, height: 15)
                    } else {
                        Image("favIconUnAc")
                            .frame(width: 15, height: 15)
                    }
                    
                    Text("즐겨찾기")
                        .foregroundColor(selectedTab == .favorite ? Color.postechOrange : Color(red: 0.6, green: 0.6, blue: 0.6))
                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                }
//                .offset(x: -5)
            }
//            .padding(.horizontal, UIScreen.main.bounds.width/4 - 30)
        }
        .frame(width: 400, height: 85)
        .background(Color.black)
    }
}

struct TabbarView: View {
    
    @State var selectedTab: Tab = .recommend
    
    var body: some View {
        
        VStack(spacing: 0) {
            switch selectedTab {
            case .recommend:
                RecommendView()
            case .restaurants:
                InformationView()
            case .favorite:
                FavoriteView()
            }
            CustomTabView(selectedTab: $selectedTab)
                .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}

//struct TabsView : View {
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            RecommendView()
//                .tabItem {
//                    Image(systemName: "sparkles")
//                        .frame(width: 12, height: 12)
//                    
//                    Text("추천")
//                        .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
//                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
//                }
//                .tag(0)
//            
//            InformationView()
//                .tabItem {
//                    Image(systemName: "scroll.fill")
//                        .frame(width: 12, height: 12)
//                    
//                    Text("식당 목록")
//                        .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
//                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
//                }
//                .tag(1)
//            
//            FavoriteView()
//                .tabItem {
//                    VStack {
//                        if selectedTab == 2 {
//                            ScaledImage(name: "favIconAc", size: CGSize(width: 26, height: 26))
//                            
//                        } else {
//                            ScaledImage(name: "favIconUnAc", size: CGSize(width: 26, height: 26))
//                        }
//                        
//                        Text("즐겨찾기")
//                            .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
//                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
//                    }
//                    .padding(.top, 30)
//                }
//                .tag(2)
//        }
//        .onAppear() {
//            UITabBar.appearance().barTintColor = .black
//        }
//        .accentColor(Color.postechOrange)
//        .font(.headline)
//    }
//    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.black
//    }
//}

struct ScaledImage: View {
    let name: String
    let size: CGSize
    
    var body: Image {
        let uiImage = resizedImage(named: self.name, for: self.size) ?? UIImage()
        
        return Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
    }
    
    func resizedImage(named: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

#Preview {
//    TabsView()
}
