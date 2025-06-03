//
//  RecommendView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI
import SwiftData
import SwiftUIPager

struct RecommendView: View {
    @Query var restaurants: [Restaurant]
    var recommendations: [Restaurant] {
        recommendBasedOnUserRatings(from: restaurants)
    }
    
    @State private var sharedImage: UIImage? = nil
    
    @State private var page: Page = .first()
    
    static let gradientStart = Color.black
    static let gradientEnd = Color.clear
    
    var body: some View {
        GeometryReader { geometry in
            Pager(page: page, data: recommendations, id: \.id) { restaurant in
                //                sharedImage = recommendItem(restaurant).snapshot()
                recommendItem(restaurant)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
            }
            .vertical()
            .pagingPriority(.simultaneous)
            .interactive(scale: 0.95)
            .itemSpacing(10)
            .padding(.vertical, 10)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func recommendItem(_ restaurant: Restaurant) -> some View {
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
                            Text("포슐랭")
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
                            
                            Text("\(restaurant.area) • \(restaurant.category.rawValue)")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 17)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                                .padding(.top, 50)
                            Text(restaurant.name)
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 28)
                                        .weight(.heavy)
                                )
                                .foregroundColor(Color(red: 1, green: 0.58, blue: 0))
                            Text(restaurant.restaurantDescription)
                                .font(Font.custom("Apple SD Gothic Neo", size: 17))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text("영업시간 \(restaurant.weekdayHours)")
                                .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                .foregroundColor(.white)
                            
                            Button {
                                
                            } label: {
                                Text("상세보기")
                            }
                            .buttonStyle(CustomDetailButtonStyle())
                            .padding(.top, 12)
                            
                            
                        }
                        .padding(30)
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                restaurant.isFavorite = !restaurant.isFavorite
                            } label: {
                                if restaurant.isFavorite {
                                    Text(Image(systemName: "heart.fill"))
                                        .foregroundColor(Color.postechOrange)
                                } else {
                                    Text(Image(systemName: "heart"))
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(CustomMainButtonStyle())
                            
                            ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!) {
                                Text(Image(systemName: "arrowshape.turn.up.right.fill"))
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(CustomMainButtonStyle())
                        }
                        .padding(30)
                    }
                    .padding(.bottom, 70)
                }
            }
            .ignoresSafeArea()
            
        }
        
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
