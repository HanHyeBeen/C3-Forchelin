//
//  RecommendItemView.swift
//  F1T5
//
//  Created by 진아현 on 6/4/25.
//

import SwiftUI

//struct RecommendItemView: View {
//    var body: some View {
//        ZStack {
//            Image("recobackground")
//                .resizable()
//                .frame(height: 900)
//            
//            VStack {
//                ZStack(alignment: .leading) {
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 420, height: 230)
//                        .background(
//                            LinearGradient(
//                                stops: [
//                                    Gradient.Stop(color: .black.opacity(0), location: 0.00),
//                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 0.71),
//                                ],
//                                startPoint: UnitPoint(x: 0.5, y: 1.52),
//                                endPoint: UnitPoint(x: 0.5, y: 0.03)
//                            )
//                        )
//                        .offset(y: -20)
//                        .blur(radius: 5)
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        HStack {
//                            Text("포슐랭")
//                                .font(
//                                    Font.custom("Apple SD Gothic Neo", size: 32)
//                                        .weight(.bold)
//                                )
//                                .foregroundColor(Color.postechOrange)
//                            
//                            Text("의")
//                                .font(
//                                    Font.custom("Apple SD Gothic Neo", size: 22)
//                                        .weight(.bold)
//                                )
//                                .foregroundColor(Color.white)
//                        }
//                        .padding(.top, 50)
//                        
//                        Text("성준님을 위한 추천 식당이에요!")
//                            .font(
//                                Font.custom("Apple SD Gothic Neo", size: 22)
//                                    .weight(.bold)
//                            )
//                            .foregroundColor(Color.white)
//                    }
//                    .padding(25)
//                    
//                }
//                
//                Spacer()
//                
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 420, height: 421)
//                        .background(
//                            LinearGradient(
//                                stops: [
//                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
//                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 0.57),
//                                ],
//                                startPoint: UnitPoint(x: 0.5, y: 0.1),
//                                endPoint: UnitPoint(x: 0.5, y: 1)
//                            )
//                        )
//                    
//                    HStack(alignment: .bottom){
//                        VStack(alignment: .leading, spacing: 3) {
//                            
//                            Text("\(restaurant.area) • \(restaurant.category.rawValue)")
//                                .font(
//                                    Font.custom("Apple SD Gothic Neo", size: 17)
//                                        .weight(.bold)
//                                )
//                                .foregroundColor(.white)
//                                .padding(.top, 50)
//                            HStack {
//                                Rectangle()
//                                    .frame(width:25, height: 25)
//                                Text(restaurant.name)
//                                    .font(
//                                        Font.custom("Apple SD Gothic Neo", size: 28)
//                                            .weight(.heavy)
//                                    )
//                                    .foregroundColor(Color.white)
//                            }
//                            Text(restaurant.restaurantDescription)
//                                .font(Font.custom("Apple SD Gothic Neo", size: 17))
//                                .foregroundColor(.white)
//                                .lineLimit(1)
//                            Text("영업시간 \(restaurant.weekdayHours) (주중)")
//                                .font(Font.custom("Apple SD Gothic Neo", size: 13))
//                                .foregroundColor(.white)
//                            
//                            Button {
//                                
//                            } label: {
//                                Text("상세보기")
//                                    .fontWeight(.bold)
//                            }
//                            .buttonStyle(CustomDetailButtonStyle())
//                            .padding(.top, 12)
//                            
//                            
//                        }
//                        .padding(30)
//                        
////                        Spacer()
//                        
//                        VStack {
//                            Button {
//                                restaurant.isFavorite = !restaurant.isFavorite
//                            } label: {
//                                if restaurant.isFavorite {
//                                    Text(Image(systemName: "heart.fill"))
//                                        .foregroundColor(Color.postechOrange)
//                                } else {
//                                    Text(Image(systemName: "heart"))
//                                        .foregroundColor(.white)
//                                }
//                            }
//                            .buttonStyle(CustomMainButtonStyle())
//                            
//                            
////                            if let sharedImage = sharedImage,
////                               let url = saveImageToTemporaryDirectory(sharedImage) {
////                                ShareLink(item: url) {
////                                    Text(Image(systemName: "arrowshape.turn.up.right.fill"))
////                                        .foregroundColor(.white)
////                                }
////                                .buttonStyle(CustomMainButtonStyle())
////                            }
//                        }
//                        .padding(30)
//                    }
//                    .padding(.bottom, 70)
//                }
//            }
//            .ignoresSafeArea()
//        }
//    }
//}
//
//
//
//#Preview {
//    RecommendItemView()
//}
