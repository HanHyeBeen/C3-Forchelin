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
    
    @State private var selectedRate: Int
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
        VStack {
            //title, cancelbtn
            HStack {
                Text("리뷰 작성")
                    .font(.title)
                    .foregroundColor(.white)
                    .border(Color.red)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
                .border(Color.red)
            }
            .padding(.top, 44)
            .padding(.horizontal, 23)
            .border(Color.red)
            
            //divider line
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 394, height: 1)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .opacity(0.3)
            
            //rate, label
            VStack(alignment: .leading) {
                Text("별점")
                    .font(.title)
                    .foregroundColor(.white)
                    .border(Color.red)
                
                HStack {
                    ForEach(0..<5) { rating in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(selectedRate >= rating ? .yellow : .gray)
                            .onTapGesture {
                                selectedRate = rating
                            }
                    }
                }
                
                
                Text("라벨")
                    .font(.title)
                    .foregroundColor(.white)
                    .border(Color.red)
                    .padding(.top, 29)
                
                //label radio btn
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
                .padding(.top, 25)
                
                Spacer()
            }
            .padding(.horizontal, 23)
            
            //btn
            VStack {
                Button {
                    createReview()
                    dismiss()
                } label: {
                    Text("리뷰 쓰기")
                        .foregroundColor(.yellow)
                        .labelStyle(.titleAndIcon)
                        .controlSize(.regular)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0.55))
                .cornerRadius(10)
                .border(Color.red)
            }
            Spacer()
        }
        .background(Color(red: 0.1, green: 0.1, blue: 0.11))
    }
        
        
    private func createReview() {
        let labelMap: [String: Label] = [
            "밥약으로 가도 분위기 괜찮은 맛집": .RED,
            "각별한 선배와 밥약이나 교수님과 갈만한 맛집": .BLUE,
            "그냥 친구들이랑 가볍게 한 끼 먹기 좋은 식당": .GREEN,
            "술집에 가까운 식당 / 찐 술집": .YELLOW,
            "카페": .PURPLE
        ]
        
        guard let mappedLabel = labelMap[selectedLabel] else {
            print("❌ 라벨 매핑 실패")
            return
        }
        
        restaurant.label = mappedLabel
        
        guard selectedRate > 0  else {
            print("❌ 유효하지 않은 리뷰입니다.")
            return
        }
        
        let newReview = Review(
            rating: Float(selectedRate + 1),
            label: mappedLabel,
            restaurant: restaurant
        )
        
        do {
            
            modelContext.insert(newReview)
            try modelContext.save()
            print("✅ 리뷰 저장 완료: \(newReview.rating)점, \(newReview.label)")
            
        } catch {
            print("❌ 리뷰 저장 실패: \(error.localizedDescription)")
        }
    }
    
    init(restaurant: Restaurant, selectedRate: Int = 0) {
        self.restaurant = restaurant
        self._selectedRate = State(initialValue: selectedRate)
    }
}
