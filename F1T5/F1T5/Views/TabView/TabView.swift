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
          Image(systemName: "1.square.fill")
          Text("First")
        }
      InfomationView()
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
      FavoriteView()
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
    }
    .font(.headline)
  }
}

#Preview {
    TabsView()
}
