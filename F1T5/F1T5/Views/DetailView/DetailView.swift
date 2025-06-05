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
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                restaurant.isFavorite.toggle()
                                do{
                                    try modelContext.save()
                                    print("저장: \(restaurant.isFavorite)")
                                } catch {
                                    print("저장 실패: \(error.localizedDescription)")
                                }
                            } label: {
                                Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(restaurant.isFavorite ? .red : .gray)
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
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 394, height: 1)
                          .background(Color(red: 0.33, green: 0.33, blue: 0.33))
                          .padding(.top, 370)
                    }
                    .frame(width: 393, height: 370)
                    
                    
                    VStack (alignment: .leading) {
                        Text("\(restaurant.area) • \(restaurant.category.rawValue)")
                            .font(.caption)
                            .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                        
                        HStack {
                            Image("\(restaurant.label.rawValue.lowercased())Label")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28, height: 35)
                            
                            if restaurant.branch == "-" {
                                Text(restaurant.name)
                                    .foregroundColor(.white)
                            } else {
                                Text("\(restaurant.name) \(restaurant.branch)")
                                    .foregroundColor(.white)
                            }
                            
                        }
                        Text(restaurant.restaurantDescription)
                            .foregroundColor(.white)
                        
                        HStack {
                            Image(systemName: "map")
                                .foregroundColor(.white)
                            
                            Text(restaurant.address)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Image(systemName: "phone.bubble")
                                .foregroundColor(.white)
                            
                            Text(restaurant.phoneNumber)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "clock")
                                    
                                    if isWeekend() {
                                        Text("영업시간 : \(restaurant.weekdayHours)")

                                    } else {
                                        Text("영업시간 : \(restaurant.weekendHours)")
                                    }
                                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                }
                                .foregroundColor(.white)
                            }

                            if isExpanded {
                                VStack(alignment: .leading) {
                                    Text("평일 : \(restaurant.weekdayHours)")
                                    Text("주말 : \(restaurant.weekendHours)")
                                    if restaurant.hoursNote != "-" {
                                        Text("비고 : \(restaurant.hoursNote)")
                                    }
                                }
                                .padding(.leading, 30)
                                .foregroundColor(.white)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                        
                        HStack {
                            Image(systemName: "creditcard.circle")
                                .foregroundColor(.white)
                            
                            Text("예상가격 \(restaurant.minPrice) ~ \(restaurant.maxPrice)")
                                .foregroundColor(.white)
                            
                        }
                        
                        
                        HStack {
                            Text("나의 리뷰")
                                .foregroundColor(.white)
                            
                            
                            Button {
                                self.showModal = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 9.41692, height: 9.40323)
                                    .foregroundColor(.white)
                            }
                            .padding(5)
                            .frame(width: 20, height: 20, alignment: .center)
                            .background(.white.opacity(0.15))
                            .cornerRadius(6)
                            .shadow(color: Color(red: 0.28, green: 0.25, blue: 0.41).opacity(0.15), radius: 8, x: 0, y: 4)
                            .sheet(isPresented: self.$showModal) {
                                ReviewModalView(restaurant: restaurant, selectedRate: -1)
                                    .presentationDragIndicator(.visible)
                                    .presentationDetents([.height(674)])
                            }
                        }
                        
                        HStack {
                            HStack {
                                if let reviews = restaurant.reviews, !reviews.isEmpty {
                                    VStack {
                                        ForEach(reviews.sorted(by: {$0.createdAt > $1.createdAt}), id: \.id) { review in
                                            HStack {
                                                ForEach(0..<Int(review.rating), id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.yellow)
                                                }
                                                ForEach(0..<5-Int(review.rating), id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                                
                                                Text(formatDate(review.createdAt))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                } else {
                                    Text("리뷰를 남겨주세요")
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .padding(.trailing, 10)
                            
                            
                            Spacer()
                        }
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
}
