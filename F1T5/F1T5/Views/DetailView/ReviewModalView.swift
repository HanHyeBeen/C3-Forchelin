//
//  ReviewModalView.swift
//  F1T5
//
//  Created by Enoch on 6/3/25.
//

import SwiftUI

struct ReviewModalView: View {
    var restaurant: Restaurant
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedLabel: String = ""
    @State var labelobjectsArray = [
        "밥약으로 가도 분위기 괜찮은 맛집",
        "각별한 선배와 밥약이나 교수님과 갈만한 맛집",
        "그냥 친구들이랑 가볍게 한 끼 먹기 좋은 식당",
        "술집에 가까운 식당 / 찐 술집",
        "카페"]
        
    private let labelColors: [Color] = [
        .red,
        .blue,
        .green,
        .yellow,
        .purple
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
                .border(Color.red)
            }
            
            Button{
                
                
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
    
}

