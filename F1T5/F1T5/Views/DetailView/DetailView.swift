//
//  DetailView.swift
//  F1T5
//
//  Created by Enoch on 6/3/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.modelContext) private var modelContext
    
    var restaurant: Restaurant
    
    @State private var Details = false
    @State private var isExpanded = false
    
    @State private var showModal = false
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 393, height: 370)
                        .background(
                            Image("image_\(restaurant.id)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 393, height: 370)
                                .clipped()
                        )
                    
                    
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 409.00003, height: 212.99997)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.1, green: 0.06, blue: 0), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0.96),
                                    endPoint: UnitPoint(x: 0.5, y: 0.27)
                                )
                            )
                        
                        Spacer()
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 393, height: 98)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
                                        Gradient.Stop(color: .black, location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0.09),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 394, height: 1)
                        .background(Color(red: 0.33, green: 0.33, blue: 0.33))
                        .padding(.top, 368)
                
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            restaurant.isFavorite.toggle()
                        } label: {
                            Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(.white)
                        }
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(restaurant.isFavorite ? .postechOrange : Color(red: 0.39, green: 0.39, blue: 0.39))
                        .cornerRadius(12)
                        .shadow(color: Color(red: 0.28, green: 0.25, blue: 0.41).opacity(0.15), radius: 16, x: 0, y: 8)
                    
                    }
                    .padding(.top, 300)
                    .padding(.horizontal, 23)
                }
                
                VStack (alignment: .leading) {
                    Text("\(restaurant.area)•\(restaurant.category.rawValue)")
                        .font(
                            Font.custom("Apple SD Gothic Neo", size: 17)
                                .weight(.bold)
                        )
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    HStack {
                        Image("\(restaurant.label.rawValue.lowercased())Label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 35)
                        
                        Text(restaurant.name)
                            .font(
                                Font.custom("Apple SD Gothic Neo", size: 28)
                                    .weight(.heavy)
                            )
                            .foregroundColor(.white)
                        
                        if restaurant.branch != "-" {
                            Text(restaurant.branch)
                                .font(
                                  Font.custom("Apple SD Gothic Neo", size: 17)
                                    .weight(.bold)
                                )
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, -4)
                    
                    Text(restaurant.restaurantDescription)
                        .font(Font.custom("Apple SD Gothic Neo", size: 17))
                        .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .padding(.bottom, 16)
                    
                    
                    HStack {
                        Image(systemName: "map")
                            .frame(width: 16.25, height: 15.41406)
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        
                        Text(restaurant.address)
                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .padding(.leading, 4)
                    }
                    .padding(.bottom, 12)
                    
                    HStack {
                        Image(systemName: "phone.bubble")
                            .frame(width: 16.25, height: 15.41406)
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        
                        Text(restaurant.phoneNumber)
                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .padding(.leading, 4)
                    }
                    .padding(.bottom, 12)
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "clock")
                                    .frame(width: 16.25, height: 15.41406)
                                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                
                                if isWeekend() {
                                    Text("영업시간 : \(restaurant.weekdayHours)")
                                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                        .padding(.leading, 4)
                                    
                                } else {
                                    Text("영업시간 : \(restaurant.weekendHours)")
                                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                        .frame(alignment: .topLeading)
                                        .padding(.leading, 4)
                                }
                                
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                    .frame(width: 7.69922, height: 13.2832)
                                    .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    .frame(width: 5, alignment: .topLeading)
                                    .padding(.leading, 4)
                            }
                        }
                        
                        if isExpanded {
                            VStack(alignment: .leading) {
                                Text("평일 : \(restaurant.weekdayHours)")
                                    .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                    .padding(.bottom, 2)
                                
                                Text("주말 : \(restaurant.weekendHours)")
                                    .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                
                                if restaurant.hoursNote != "-" {
                                    Text("비고 : \(restaurant.hoursNote)")
                                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                                        .padding(.top, 1)
                                }
                            }
                            .padding(.leading, 30)
                            .foregroundColor(.white)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    }
                    .padding(.bottom, 12)
                    
                    HStack {
                        Image(systemName: "creditcard.circle")
                            .frame(width: 16.25, height: 15.41406)
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        
                        Text("예상가격 \(restaurant.minPrice) ~ \(restaurant.maxPrice)")
                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .padding(.leading, 4)
                        
                    }
                    .padding(.bottom, 40)
                    
                    
                    HStack {
                        Text("나의 리뷰")
                            .font(
                                Font.custom("Apple SD Gothic Neo", size: 20)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                        
                        Button {
                            self.showModal = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                                .padding(.bottom, 4)
                        }
                        .padding(7.5)
                        .frame(width: 30, height: 30, alignment: .center)
                        .background(.white.opacity(0.15))
                        .cornerRadius(9)
                        .shadow(color: Color(red: 0.28, green: 0.25, blue: 0.41).opacity(0.15), radius: 12, x: 0, y: 6)
                        .sheet(isPresented: self.$showModal) {
                            ReviewModalView(restaurant: restaurant, selectedRate: -1)
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.height(674)])
                        }
                    }
                    .padding(.bottom, 8)
                    
                    StarRatingViewSection
                }
                .padding(.horizontal, 23)
                
                Spacer()
            }
        }
        .background(.black)
        .ignoresSafeArea(.container, edges: .top)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("상세보기")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                backBtn
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
    }
    
    var backBtn : some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    
    func isWeekend() -> Bool {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        
        return weekday == 1 || weekday == 7
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    var StarRatingViewSection : some View {
            HStack {
                if let reviews = restaurant.reviews, !reviews.isEmpty {
                    VStack {
                        ForEach(reviews.sorted(by: {$0.createdAt > $1.createdAt}), id: \.id) { review in
                            HStack {
                                ForEach(0..<Int(review.rating), id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(Color(red: 1, green: 0.58, blue: 0))
                                        .padding(.trailing, 2)
                                }
                                
                                ForEach(0..<5-Int(review.rating), id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        .padding(.trailing, 2)
                                }
                                
                                
                                Text(String(review.rating))
                                    .font(
                                        Font.custom("Apple SD Gothic Neo", size: 13)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.white)
                                    .padding(.leading, 16)
                                
                                Spacer()
                                
                                Text(formatDate(review.createdAt))
                                    .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                                    .frame(width: 75, height: 22, alignment: .trailing)
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 4)
                } else {
                    Text("리뷰를 남겨주세요")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
}


