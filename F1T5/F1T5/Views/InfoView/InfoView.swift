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
                            Rectangle()
                                .frame(width: 78, height: 78)
                            
                            VStack(alignment: .leading){
                                Spacer()
                                
                                HStack {
                                    Text("\(restaurant.area) • \( restaurant.category.rawValue)")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                                }
                                
                                HStack{
                                    Text(restaurant.name)
                                    //                                    Text(restaurant.label.rawValue)
                                    if restaurant.label.rawValue == "BLUE" {
                                        Text("􀉟")
                                            .foregroundColor(.blue)
                                    }
                                    else if restaurant.label.rawValue == "RED" {
                                        Text("􀉟")
                                            .foregroundColor(.red)
                                    }
                                    else if restaurant.label.rawValue == "GREEN" {
                                        Text("􀉟")
                                            .foregroundColor(.green)
                                    }
                                    else if restaurant.label.rawValue == "YELLOW" {
                                        Text("􀉟")
                                            .foregroundColor(.yellow)
                                    }
                                    else if restaurant.label.rawValue == "PURPLE" {
                                        Text("􀉟")
                                            .foregroundColor(.purple)
                                    }
                                } 
                                
                                Spacer()
                                
                                Text(restaurant.restaurantDescription)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            
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
                            .buttonStyle(BorderlessButtonStyle()) // 버튼이 List에서 충돌 안 나게
                        }
                    }
                }
            }
        }
    }
}
