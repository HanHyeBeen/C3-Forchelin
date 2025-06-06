//
//  FilterModalView.swift
//  F1T5
//
//  Created by Enoch on 6/5/25.
//

import SwiftUI

struct FilterModalView: View {
    @Environment(\.dismiss) var dismiss
    
    var onApply: (_ selectedLabel: String, _ selectedArea: String, _ selectedFoods: Set<String>) -> Void

    let areaColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let foodColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Binding var selectedLabel: String
    @Binding var selectedArea: String
    @Binding var selectedFoods: Set<String>
        
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
    
    @State var areaArray = [
        "효자", "유강", "SK뷰", "이동"
    ]
    
    @State var foodArray = ["한식", "중식", "일식", "양식", "아시안", "분식", "치킨", "피자", "햄버거", "고기/구이", "디저트"]
    
    let foodImgArray = ["korean", "chinese", "japanese", "western", "asian", "snack", "chicken", "pizza", "hamburger", "meat", "dessert"]
    
    var body: some View {
        VStack {
            //title, cancelbtn
            HStack {
                Text("리뷰 작성")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    onApply(selectedLabel, selectedArea, selectedFoods)
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 180)
            .padding(.bottom, 12)
            
            //divider line
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 394, height: 1)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .opacity(0.3)
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("라벨")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 29)
                    
                    //label radio btn
                    VStack {
                        labelArraySection
                    }
                    
                    Text("동네")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 29)
                    
                    
                    LazyVGrid(columns: areaColumns, spacing: 20) {
                        areaArraySection
                    }
                    
                    
                    Text("음식 종류")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 29)
                    
                    
                    LazyVGrid(columns: foodColumns, spacing: 20) {
                        foodArraySection
                    }
                }
                .padding(.bottom, 150)
            }
        }
        .padding(.horizontal, 23)
        .frame(width: 394, height: 1029)
        .background(Color(red: 0.1, green: 0.1, blue: 0.11))
        .onDisappear {
            // 사용자가 드래그로 모달을 내렸을 때도 값 전달
            onApply(selectedLabel, selectedArea, selectedFoods)
        }
    }
    
    var labelArraySection: some View {
        ForEach(labelobjectsArray, id: \.self) { label in
            let tagImageName = labelMap[label]?.rawValue.lowercased() ?? "default"
            
            HStack {
                Image("\(tagImageName)Label")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                
                Text(label)
                    .foregroundColor(selectedLabel == label ? .yellow : .gray)
                
                Spacer()
            }
            .padding(.vertical, 4)
            .foregroundColor(.clear)
            .frame(width: 353, height: 57)
            .background(Color(red: 0.12, green: 0.13, blue: 0.16))
            .cornerRadius(9)
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(selectedLabel == label ? Color.yellow : Color.clear, lineWidth: 0.5)
            )
            .onTapGesture {
                selectedLabel = label
            }
        }
    }
    
    var areaArraySection: some View {
        ForEach(Array(areaArray.enumerated()), id: \.element) { index, area in
            HStack {
                Text(area)
                    .foregroundColor(selectedArea == area ? .yellow : .gray)
            }
            .padding(.vertical, 29)
            .foregroundColor(.clear)
            .frame(width: 104, height: 36)
            .background(Color(red: 0.12, green: 0.13, blue: 0.16))
            .cornerRadius(9)
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(selectedArea == area ? Color.yellow : Color.clear, lineWidth: 0.5)
            )
            .onTapGesture {
                selectedArea = area
            }
        }
    }
    
    var foodArraySection: some View {
        ForEach(Array(zip(foodArray, foodImgArray)), id: \.0) { food, foodImg in
            VStack {
                Image(foodImg)
                    .resizable()
                    .frame(width: 34, height: 34)
                
                Text(food)
                    .foregroundColor(selectedFoods.contains(food) ? .yellow : .gray)
            }
            .padding(.vertical, 29)
            .foregroundColor(.clear)
            .frame(width: 82, height: 90)
            .background(Color(red: 0.1, green: 0.1, blue: 0.11))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(selectedFoods.contains(food) ? Color.yellow : Color.gray, lineWidth: 0.5)
            )
            .onTapGesture {
                if selectedFoods.contains(food) {
                    selectedFoods.remove(food)
                } else {
                    selectedFoods.insert(food)
                }
            }
            
        }
    }
}
