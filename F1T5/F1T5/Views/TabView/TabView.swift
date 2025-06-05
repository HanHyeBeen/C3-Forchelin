//
//  TabView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI

struct TabsView : View {
    var body: some View {
        TabView {
            RecommendView()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("추천")
                }
            InformationView()
                .tabItem {
                    Image(systemName: "scroll.fill")
                    Text("검색")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("즐겨찾기")
                }
        }
        .font(.headline)
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
    }
}

#Preview {
    TabsView()
}
