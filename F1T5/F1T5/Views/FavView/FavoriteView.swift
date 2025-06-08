//
//  FavoriteView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Query var restaurants: [Restaurant]
    
    @Environment(\.modelContext) private var modelContext
    
    var favoriteRestaurants: [Restaurant] {
        restaurants.filter { $0.isFavorite }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 타이틀
                Text("즐겨찾기")
                    .font(
                      Font.custom("Apple SD Gothic Neo", size: 28)
                        .weight(.heavy)
                    )
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(favoriteRestaurants) { restaurant in
                            VStack {
                                RestaurantList(for: restaurant)
                            }
                            .background(Color.black)
                            .padding(.vertical, 12)
                            
                            Divider()
                                .background(Color.gray.opacity(0.4))
                        }
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.black.ignoresSafeArea())
        }
    }
    
    @ViewBuilder
    private func RestaurantList(for restaurant: Restaurant) -> some View {
        NavigationLink(destination: DetailView(restaurant: restaurant)) {
            HStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 80)
                    .background(
                        Image("image_\(restaurant.id)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                    )
                    .cornerRadius(8)
                
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text("\(restaurant.area)•\(restaurant.category.rawValue)")
                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                        .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 15, height: 20)
                            .background(
                                Image("\(restaurant.label.rawValue.lowercased())Label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                        
                        Text(restaurant.branch == "-" ? restaurant.name : "\(restaurant.name) \(restaurant.branch)")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 200, alignment: .topLeading)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Text(restaurant.restaurantDescription)
                        .font(Font.custom("Apple SD Gothic Neo", size: 13))
                        .foregroundColor(.white)
                        .frame(width: 220, alignment: .topLeading)
                        .opacity(0.4)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.horizontal, 4)
                
                Spacer()
                
                Button {
                    restaurant.isFavorite.toggle()
                    do {
                        try modelContext.save()
                        print("저장: \(restaurant.isFavorite)")
                    } catch {
                        print("저장 실패: \(error.localizedDescription)")
                    }
                } label: {
                    Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(restaurant.isFavorite ? Color(red: 1, green: 0.58, blue: 0) : .white)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal, 16)
        }
    }
}
