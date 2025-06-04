//
//  ReviewModalView.swift
//  F1T5
//
//  Created by Enoch on 6/3/25.
//

import SwiftUI
import SwiftData

struct ReviewModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var restaurant: Restaurant
    
    @State private var selectedLabel: String = ""
    
    @State var labelobjectsArray = [
        "밥약으로 가도 분위기 괜찮은 맛집",
        "각별한 선배와 밥약이나 교수님과 갈만한 맛집",
        "그냥 친구들이랑 가볍게 한 끼 먹기 좋은 식당",
        "술집에 가까운 식당 / 찐 술집",
        "카페"
    ]
        
    private let labelColors: [Color] = [
        .red, .blue, .green, .yellow, .purple
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("별점")
                .font(.title)
                .foregroundColor(.white)
            
            Text("라벨")
                .font(.title)
                .foregroundColor(.white)
            
            VStack {
                ForEach(Array(labelobjectsArray.enumerated()), id: \.element) { index, label in
                    HStack {
                        Image(systemName: selectedLabel == label ? "bookmark.fill" : "bookmark")
                            .foregroundColor(labelColors[index])
                            .font(.system(size: 17))
                        
                        Text(label)
                            .foregroundColor(selectedLabel == label ? .yellow : .gray)
                    }
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        selectedLabel = label
                    }
                }
            }
            
            Button{
                updatesRestaurantLabel()
                dismiss()
            } label: {
                Text("리뷰 쓰기")
                    .labelStyle(.titleAndIcon)
                    .controlSize(.regular)
            }
            
            Spacer()
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 23)
        .background(Color(red: 0.1, green: 0.1, blue: 0.11))
    }
    
    private func updatesRestaurantLabel() {
        let labelMap: [String: Label] = [
            "밥약으로 가도 분위기 괜찮은 맛집": .RED,
            "각별한 선배와 밥약이나 교수님과 갈만한 맛집": .BLUE,
            "그냥 친구들이랑 가볍게 한 끼 먹기 좋은 식당": .GREEN,
            "술집에 가까운 식당 / 찐 술집": .YELLOW,
            "카페": .PURPLE
        ]
        
        if let newLabel = labelMap[selectedLabel] {
            restaurant.label = newLabel
            do {
                try modelContext.save()
                print("\(restaurant.label)로 업데이트됨")
            } catch {
                print("업데이트 실패")
            }
        } else {
            print("매핑 실패")
        }
    }
}

