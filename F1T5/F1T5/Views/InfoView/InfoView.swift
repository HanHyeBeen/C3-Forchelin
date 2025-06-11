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
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 28)
                            .weight(.heavy)
                    )
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                // 필터 버튼 + 필터 태그
                filterSection
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                
                //                List {
                //                    ForEach(filteredRestaurants) { restaurant in
                //                        RestaurantList(for: restaurant)
                //                            .listRowBackground(Color.black) // 셀 배경을 검정색으로 설정
                //                            .listRowSeparatorTint(.gray)   // 구분선 색상 설정
                //                    }
                //                    .listRowSeparator(.hidden)
                //                    .listRowBackground(Color.black)
                //                }
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredRestaurants) { restaurant in
                            VStack() {
                                RestaurantList(for: restaurant)
                            }
                            .background(Color.black)
                            .padding(.vertical, 12)
                            
                            // ✅ 구분선
                            Divider()
                                .background(Color.gray.opacity(0.4))
                        }
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                
            }
            //            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.black)
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
                
                
                if let selectedLabel = selectedLabel,
                   let labelString = key(for: selectedLabel) {
                    labelFilterTagView(label: labelString) {
                        self.selectedLabel = nil
                    }
                        .padding(.leading, 2)
                }
                
                if !selectedArea.isEmpty {
                    filterTagView(filter: selectedArea) { selectedArea = "" }
                        .padding(.leading, 4)
                }
                
                foodFilterTags
                    .padding(.leading, 4)
                
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 12)
        }
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
                .frame(height: 17)
                .padding(.trailing, 4)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 12)
        .foregroundColor(.clear)
        .background(.black)
        .frame(height: 28)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
              .stroke(.white, lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func filterTagView(filter: String, onRemove: @escaping () -> Void) -> some View {
        HStack(spacing: 4) {
            Text(filter)
                .font(Font.custom("Apple SD Gothic Neo", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.trailing, 4)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 12)
        .foregroundColor(.clear)
        .background(.black)
        .frame(height: 28)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
              .stroke(.white, lineWidth: 1)
        )
    }
    
    func key(for label: Label) -> String? {
        return labelMap.first(where: { $0.value == label })?.key
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
                        
                        Text("\(restaurant.area)•\( restaurant.category.rawValue)")
                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                            .foregroundColor(Color(red: 1, green: 0.7, blue: 0))
                    
                        
                        HStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 15, height: 20)
                                .background(
                                    Image("\(restaurant.label.rawValue.lowercased())Label")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                )
                            
                            if restaurant.branch == "-" {
                                Text(restaurant.name)
                                    .font(
                                        Font.custom("Apple SD Gothic Neo", size: 18)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.white)
                                    .frame(width: 200, alignment: .topLeading)
                                    .lineLimit(1)
                                
                                
                            } else {
                                Text("\(restaurant.name) \(restaurant.branch)")
                                    .font(
                                        Font.custom("Apple SD Gothic Neo", size: 18)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.white)
                                    .frame(width: 200, alignment: .topLeading)
                                    .lineLimit(1)
                            }
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
                        do{
                            try modelContext.save()
                            print("저장: \(restaurant.isFavorite)")
                        } catch {
                            print("저장 실패: \(error.localizedDescription)")
                        }
                    } label: {
                        Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(restaurant.isFavorite ? .postechOrange : .white)
                        //background black으로 적용 후 gray를 white로 바꿔야 함
                    }
                    .buttonStyle(BorderlessButtonStyle()) // 버튼이 List에서 충돌 안 나게
                }
                .padding(.horizontal, 16)
            }
            
            NavigationLink {
                DetailView(restaurant: restaurant)
                
            } label: {
                
            }.opacity(0.0)
        }
    }

