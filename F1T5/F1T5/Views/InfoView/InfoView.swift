//
//  InfoView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import SwiftUI
import SwiftData

struct InformationView: View {
    @Query var restaurants: [Restaurant]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showFilterModal = false
    
    @State private var selectedLabel: Label? = nil
    @State private var selectedArea: String = ""
    @State private var selectedFoods: Set<String> = []
    
    let labelMap: [String: Label] = [
        "밥약으로 가도 분위기 괜찮은 맛집": .RED,
        "각별한 선배, 교수님과 갈만한 맛집": .GREEN,
        "친구들이랑 가볍게 먹기 좋은 식당": .BLUE,
        "술집에 가까운 식당 / 찐 술집": .PURPLE,
        "분위기 좋은 카페": .YELLOW
    ]
    
    var filteredRestaurants: [Restaurant] {
        restaurants.filter { restaurant in
            let matchesLabel = selectedLabel == nil || restaurant.label == selectedLabel
            let matchesArea = selectedArea.isEmpty || restaurant.area == selectedArea
            let matchesFood = selectedFoods.isEmpty || selectedFoods.contains(restaurant.category.rawValue)
            
            return matchesLabel && matchesArea && matchesFood
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 타이틀
                Text("리스트 보기")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                // 필터 버튼 + 필터 태그
                filterSection
                
                List {
                    ForEach(filteredRestaurants) { restaurant in
                        RestaurantList(for: restaurant)
                    }
                }
                
            }
            .sheet(isPresented: $showFilterModal) {
                FilterModalView(
                    onApply: { labelString, area, foods in
                        selectedLabel = labelMap[labelString]
                        selectedArea = area
                        selectedFoods = foods
                    },
                    selectedLabel: Binding(
                        get: {
                            if let label = selectedLabel {
                                return key(for: label) ?? ""
                            } else {
                                return ""
                            }
                        },
                        set: { selectedLabel = labelMap[$0] }
                    ),

                    selectedArea: $selectedArea,
                    selectedFoods: $selectedFoods
                )
                .presentationDetents([.height(788)])
                .presentationDragIndicator(.visible)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.black.ignoresSafeArea())
        }
        
    }
    
    var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button {
                    showFilterModal = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                }
                .foregroundColor(.clear)
                .frame(width: 28, height: 28)
                .cornerRadius(8.37681)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.37681)
                        .inset(by: 0.5)
                        .stroke(.white, lineWidth: 1)
                )
                .padding(.bottom, 24)
                
                if let selectedLabel = selectedLabel,
                   let labelString = key(for: selectedLabel) {
                    labelFilterTagView(label: labelString) {
                        self.selectedLabel = nil
                    }
                }
                
                if !selectedArea.isEmpty {
                    filterTagView(filter: selectedArea) { selectedArea = "" }
                }
                
                foodFilterTags
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .clipShape(Capsule())
        }
        .padding(.top, 4)
    }
    
    var foodFilterTags: some View {
        Group {
            if !selectedFoods.isEmpty {
                let first = selectedFoods.first ?? ""
                let count = selectedFoods.count - 1
                let label = count > 0 ? "\(first) 외 \(count)" : first
                
                filterTagView(filter: label) {
                    selectedFoods.removeAll()
                }
            }
        }
    }
    
    @ViewBuilder
    private func labelFilterTagView(label: String, onRemove: @escaping () -> Void) -> some View {
        HStack(spacing: 4) {
            let imageName = labelMap[label]?.rawValue.lowercased() ?? "default"
            

            Image("\(imageName)Label")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.caption2)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.4))
        .clipShape(Capsule())
    }
    
    @ViewBuilder
    private func filterTagView(filter: String, onRemove: @escaping () -> Void) -> some View {
        HStack(spacing: 4) {
            Text(filter)
                .foregroundColor(.white)
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.caption2)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.4))
        .clipShape(Capsule())
    }
    
    func key(for label: Label) -> String? {
        return labelMap.first(where: { $0.value == label })?.key
    }
    
    @ViewBuilder
    private func RestaurantList(for restaurant: Restaurant) -> some View {
        ZStack {
            VStack {
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
                        
                        HStack {
                            Text("\(restaurant.area) • \( restaurant.category.rawValue)")
                                .font(.caption)
                                .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                        }
                        
                        HStack{
                            Image("\(restaurant.label.rawValue.lowercased())Label")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            
                            if restaurant.branch == "-" {
                                Text(restaurant.name)
                            } else {
                                Text("\(restaurant.name) \(restaurant.branch)")
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
            
            NavigationLink {
                DetailView(restaurant: restaurant)
                
            } label: {
                
            }.opacity(0.0)
        }
    }
}
