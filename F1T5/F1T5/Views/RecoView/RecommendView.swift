//
//  RecommendView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI

struct RecommendView: View {
    static let gradientStart = Color.black
    static let gradientEnd = Color.clear

    
    var body: some View {
        ZStack {
            Image("recobackground")
                .resizable()
                .frame(height: 900)
            
            VStack {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.black.opacity(0.0), location: 0.0),
                            .init(color: Color.black, location: 0.5)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 230)
                    
                    VStack {
                        Text("앱이름의")
                            .foregroundColor(Color.white)
                            .font(.headline)
                        Text("성준님을 위한 추천 식당이에요!")
                            .foregroundColor(Color.white)
                    }
                }
                .ignoresSafeArea()
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(
                              gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                              startPoint: .init(x: 0.5, y: 0.9),
                              endPoint: .init(x: 0.5, y: 0)
                            ))
                        .frame(height: 150)
                }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    RecommendView()
}
