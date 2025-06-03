//
//  RecommendView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI
import SwiftData

struct RecommendView: View {
    @Query var restaurants: [Restaurant]
    
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
                    
                    VStack(alignment: .leading, spacing: 5) {
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
                        .padding(.top, 50)
                        
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
                          startPoint: UnitPoint(x: 0.5, y: 0.1),
                          endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                      )
                    
                    HStack (alignment: .bottom){
                        VStack(alignment: .leading, spacing: 3) {
                            
                            Text("\(restaurants.first?.area ?? "nil") • \(restaurants.first?.category.rawValue ?? "nil")")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 17)
                                    .weight(.bold)
                                )
                                .foregroundColor(.white)
                                .padding(.top, 50)
                            Text(restaurants.first?.name ?? "nil")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 28)
                                    .weight(.heavy)
                                )
                                .foregroundColor(Color(red: 1, green: 0.58, blue: 0))
                            Text(restaurants.first?.restaurantDescription ?? "nil")
                                .font(Font.custom("Apple SD Gothic Neo", size: 17))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text("영업시간 \( restaurants.first?.weekdayHours ?? "nil")")
                                .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                .foregroundColor(.white)
                            
                            
                            
                            Button {
                                
                            } label: {
                                Text("상세보기")
                            }
                            .buttonStyle(CustomDetailButtonStyle())
                            .padding(.top, 12)
                            
                            
                        }
                        

                        
                        Spacer()
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Text(Image(systemName: "heart"))
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(CustomMainButtonStyle())
                            
                            Button {
                                
                            } label: {
                                Text(Image(systemName: "arrowshape.turn.up.right.fill"))
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(CustomMainButtonStyle())

                        }
                        
                    
                    }
                    .padding(30)
                }
                
            }
        }
        .ignoresSafeArea()

    }
}

struct CustomDetailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 38)
                .cornerRadius(10)
                .foregroundColor(Color.gray)
            
            configuration.label
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
                .foregroundColor(Color.postechOrange)
        }
    }
}

struct CustomMainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 40, height: 40)
                .cornerRadius(12)
                .foregroundColor(Color.gray)
            
            configuration.label
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
        }
    }
}


#Preview {
    RecommendView()
}
