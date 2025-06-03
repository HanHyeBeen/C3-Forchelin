//
//  InfoView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI
import SwiftData

struct InformationView: View {
    @Query var restaurants: [Restaurant]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    VStack {
                        HStack {
//                            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                            } placeholder: {
//                                Color.gray
//                            }
//                            .frame(width: 78, height: 78)
//                            .cornerRadius(8.9)
                            Rectangle()
                                .frame(width: 78, height: 78)
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text(restaurant.area)
                                    Text("•")
                                    Text(restaurant.category.rawValue)
                                }
                                
                                HStack{
                                    Text(restaurant.name)
                                    Text(restaurant.label.rawValue)
                                }
                                
                                Text(restaurant.restaurantDescription)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Button {
                                restaurant.isFavorite.toggle()
                                do{
                                    try modelContext.save()
                                } catch {
                                    print("저장 실패: \(error.localizedDescription)")
                                }
                            } label: {
                                Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(restaurant.isFavorite ? .red : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // 버튼이 List에서 충돌 안 나게
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    InformationView()
//}
