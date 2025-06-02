//
//  InfoView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI

struct Store: Identifiable {
    var id: UUID
    var label: String
    var name: String
    var imageURL: String
    var address: String
//    var phoneNumber: String
    var restaurantDescription: String
    var isFavorite: Bool
//    var rating: Float?
//    var weekdayHours: String
//    var weekendHours: String
//    var hoursNote: String
    var category: String
//    var minPrice: Int
//    var maxPrice: Int
}

struct InformationView: View {
    @State private var dummyStores: [Store] = [
        Store(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
              label:"BLUE",
              name:"효자 아지매 순대국밥",
              imageURL:"https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160715_1%2F1468565863818UVRwN_JPEG%2F176665558763.jpg",
              address:"효자동",
              restaurantDescription:"청암에서 가까운 국밥집. 국밥이 만원이나 하지만 그만한 맛이 난다. 혼밥도 ok",
              isFavorite:false,
              category:"한식"),
        
        Store(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
              label:"PURPLE",
              name:"오춘봉 막창",
              imageURL:"https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191229_86%2F1577615726004zydm4_JPEG%2FtxX8rNxBqAss9v-v1M7H-XLo.jpg",
              address:"효자동",
              restaurantDescription:"아저씨들이 많을 것 같이 생긴 막창집. 친구들끼리 한 잔 하긴 좋은데 밥약으로는 좀…",
              isFavorite:false,
              category:"고기/구이"),
        
        Store(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
              label:"BLUE",
              name:"해오름",
              imageURL:"https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240724_226%2F1721812145243791Ua_JPEG%2FKakaoTalk_20240723_154405798_01.jpg",
              address:"효자동",
              restaurantDescription:"칼국수/만두전골 맛집. 혼자는 못가고 여럿이 모이면 한번쯤 가볼만함",
              isFavorite:false,
              category:"한식")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dummyStores.indices, id: \.self) { index in
                    let store = dummyStores[index]
                    
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: store.imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 78, height: 78)
                        .cornerRadius(8.9)
                        
                        VStack(alignment: .leading){
                            HStack {
                                Text(store.address)
                                Text("•")
                                Text(store.category)
                            }
                            
                            HStack{
                                Text(store.name)
                                Text(store.label)
                            }
                            
                            Text(store.restaurantDescription)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Button {
                            dummyStores[index].isFavorite.toggle()
                        } label: {
                            Image(systemName: store.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(store.isFavorite ? .red : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // 버튼이 List에서 충돌 안 나게
                    }
                }
            }
        }
    }
}

//#Preview {
//    InformationView()
//}
