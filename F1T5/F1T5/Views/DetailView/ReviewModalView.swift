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
        "각별한 선배, 교수님과 갈만한 맛집",
        "친구들이랑 가볍게 먹기 좋은 식당",
        "술집에 가까운 식당 / 찐 술집",
        "분위기 좋은 카페"
    ]
    
    let labelMap: [String: Label] = [
        "밥약으로 가도 분위기 괜찮은 맛집": .RED,
        "각별한 선배, 교수님과 갈만한 맛집": .GREEN,
        "친구들이랑 가볍게 먹기 좋은 식당": .BLUE,
        "술집에 가까운 식당 / 찐 술집": .PURPLE,
        "분위기 좋은 카페": .YELLOW
    ]
    
    private let labelColors: [Color] = [
        .red, .green, .blue, .purple, .yellow
    ]
    
    var body: some View {
        VStack {
            //title, cancelbtn
            HStack {
                Text("리뷰 작성")
                  .font(
                    Font.custom("Apple SD Gothic Neo", size: 24)
                      .weight(.bold)
                  )
                  .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 18.18019, height: 18.18028)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 28)
            .padding(.top, 45)
            .padding(.bottom, 16)
            
            //divider line
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 394, height: 1)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .opacity(0.3)
            
            //rate, label
            VStack(alignment: .leading) {
                Text("별점")
                  .font(
                    Font.custom("Apple SD Gothic Neo", size: 17)
                      .weight(.bold)
                  )
                  .foregroundColor(.white)
                  .padding(.top, 16)
                  .padding(.horizontal, 4)
                
                HStack {
                    ForEach(0..<5) { rating in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30.21736, height: 29.15143)
                            .foregroundColor(selectedRate >= rating ? Color(red: 1, green: 0.58, blue: 0) : Color(red: 0.6, green: 0.6, blue: 0.6))
                            .onTapGesture {
                                selectedRate = rating
                            }
                    }
                }
                .padding(.bottom, 24)
                
                Text("라벨")
                  .font(
                    Font.custom("Apple SD Gothic Neo", size: 17)
                      .weight(.bold)
                  )
                  .foregroundColor(.white)
                  .padding(.top, 16)
                  .padding(.horizontal, 4)
                
                //label radio btn
                VStack {
                    ForEach(Array(labelobjectsArray.enumerated()), id: \.element) { index, label in
                        let tagImageName = labelMap[label]?.rawValue.lowercased() ?? "default"
                        
                        HStack {
                            Image("\(tagImageName)Label")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 35)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                            
                            Text(label)
                                .font(Font.custom("Apple SD Gothic Neo", size: 17))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(selectedLabel == label ? .postechOrange : Color(red: 0.5, green: 0.5, blue: 0.5))
                                .opacity(selectedLabel == label ? 1 : 0.4)
                                .padding(.leading, -8)
                            
                            Spacer()
                        }
                        .foregroundColor(.clear)
                        .frame(width: 353, height: 57)
                        .background(Color(red: 0.12, green: 0.13, blue: 0.16))
                        .cornerRadius(9)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(selectedLabel == label ? .postechOrange : Color.clear, lineWidth: 1)
                        )
                        .padding(.top, 0)
                        .onTapGesture {
                            selectedLabel = label
                        }
                    }
                }
                
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
                      .font(
                        Font.custom("Apple SD Gothic Neo", size: 15)
                          .weight(.bold)
                      )
                      .foregroundColor(.postechOrange)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0.55))
                .cornerRadius(10)
            }
            Spacer()
        }
        .background(Color(red: 0.1, green: 0.1, blue: 0.11))
    }
        
        
    private func createReview() {
        let labelMap: [String: Label] = [
            "밥약으로 가도 분위기 괜찮은 맛집": .RED,
            "각별한 선배, 교수님과 갈만한 맛집": .GREEN,
            "친구들이랑 가볍게 먹기 좋은 식당": .BLUE,
            "술집에 가까운 식당 / 찐 술집": .PURPLE,
            "분위기 좋은 카페": .YELLOW
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
