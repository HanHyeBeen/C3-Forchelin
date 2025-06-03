//
//  DetailView.swift
//  F1T5
//
//  Created by Enoch on 6/3/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backBtn : some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 394, height: 1)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                    .padding(.top, 369)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 393, height: 370)
                    .background(.black)
                    .background(
                        Image("PATH_TO_IMAGE")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 393, height: 370)
                            .clipped()
                    )
                
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 409, height: 172)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0.8), location: 0.65),
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0.81),
                                endPoint: UnitPoint(x: 0.5, y: 0.16)
                            )
                        )
                        .blur(radius: 5)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 393, height: 98)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0.8), location: 0.65),
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0.16),
                                endPoint: UnitPoint(x: 0.5, y: 0.81)
                            )
                        )
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        //                        restaurant.isFavorite.toggle()
                        //                        do{
                        //                            try modelContext.save()
                        //                            print("저장: \(restaurant.isFavorite)")
                        //                        } catch {
                        //                            print("저장 실패: \(error.localizedDescription)")
                        
                    } label: {
                        //                            Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                        //                                .foregroundColor(restaurant.isFavorite ? .red : .gray)
                        
                        Image(systemName: "heart")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    
                    .padding(10)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(.white.opacity(0.15))
                    .cornerRadius(12)
                    .shadow(color: Color(red: 0.28, green: 0.25, blue: 0.41).opacity(0.15), radius: 16, x: 0, y: 8)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    
                    .padding(10)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(.white.opacity(0.15))
                    .cornerRadius(12)
                    .shadow(color: Color(red: 0.28, green: 0.25, blue: 0.41).opacity(0.15), radius: 16, x: 0, y: 8)
                }
                .padding(.top, 300)
                .padding(.horizontal, 23)
                
            }
            .frame(width: 393, height: 370)
            
            
            VStack (alignment: .leading) {
                Text("(restaurant.area) • (restaurant.category.rawValue)")
                    .font(.caption)
                    .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                
                HStack {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: 7.81, height: 12.08)
                    
                    Text("가게 이름")
                        .foregroundColor(.blue)
                }
                
                Text("description")
                
                HStack {
                    Image(systemName: "map")
                    
                    Text("address")
                }
                
                HStack {
                    Image(systemName: "phone.bubble")
                    
                    Text("phoneNumber")
                }
                
                HStack {
                    Image(systemName: "clock")
                    
                    Text("영업시간 : (weekdayHours)")
                }
                
                HStack {
                    Image(systemName: "creditcard.circle")
                    
                    Text("예상가격 (minPrice) ~ (maxPrice)")
                }
                
                
                HStack {
                    Text("나의 리뷰")
                    
                    Image(systemName: "square.and.pencil")
                }
            }
            .padding(.horizontal, 23)
            
            Spacer()
        }
        .navigationTitle("상세보기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backBtn)
        .ignoresSafeArea(.container, edges: .top)
    }
    init() {
        
        //navigationTitle
        let appearance = UINavigationBarAppearance()
//                appearance.configureWithOpaqueBackground()
//                appearance.backgroundColor = UIColor.systemBackground  // 배경색
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 제목 색상
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red] // 큰 제목 색상
                UINavigationBar.appearance().standardAppearance = appearance
//                UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
