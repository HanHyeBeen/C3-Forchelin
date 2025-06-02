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
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 420, height: 230)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 0.71),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 1.52),
                                endPoint: UnitPoint(x: 0.5, y: 0.03)
                            )
                        )
                        .offset(y: -20)
                        .blur(radius: 5)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("앱이름")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 32)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color.postechOrange)
                            
                            Text("의")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                        }
                        
                        Text("성준님을 위한 추천 식당이에요!")
                            .font(
                                Font.custom("Apple SD Gothic Neo", size: 22)
                                .weight(.bold)
                            )
                            .foregroundColor(Color.white)
                    }
                    .padding(25)
                    
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 420, height: 421)
                      .background(
                        LinearGradient(
                          stops: [
                            Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 0.57),
                          ],
                          startPoint: UnitPoint(x: 0.5, y: 0.35),
                          endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                      )
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("효곡동 • 고기/구이")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                    .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                            Text("일로식당 포항 본점")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                    .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                            Text("라멘/규동 맛집. 소규모로 가기 좋음...")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                    .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                            Text("영업시간 09:00 ~ 18:00")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                    .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                            
                        }
                        
                        
                        VStack {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)

                        }
                    }
                }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    RecommendView()
}
