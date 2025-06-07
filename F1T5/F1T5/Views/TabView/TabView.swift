//
//  TabView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI

struct TabsView : View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RecommendView()
                .tabItem {
                    Image(systemName: "sparkles")
                        .frame(width: 12, height: 12)
                    
                    Text("추천")
                        .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                }
                .tag(0)
            
            InformationView()
                .tabItem {
                    Image(systemName: "scroll.fill")
                        .frame(width: 12, height: 12)
                    
                    Text("검색")
                        .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                }
                .tag(1)
            
            FavoriteView()
                .tabItem {
                    VStack {
                        if selectedTab == 2 {
                            ScaledImage(name: "favIconAc", size: CGSize(width: 26, height: 26))
                            
                        } else {
                            ScaledImage(name: "favIconUnAc", size: CGSize(width: 26, height: 26))
                        }
                        
                        Text("즐겨찾기")
                            .font(Font.custom("Apple SD Gothic Neo", size: 12.70896))
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    }
                    .padding(.top, 30)
                }
                .tag(2)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .black
        }
        .accentColor(Color.postechOrange)
        .font(.headline)
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
    }
}

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
    TabsView()
}
