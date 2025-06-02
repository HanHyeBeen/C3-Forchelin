//
//  itemLlist.swift
//  F1T5
//
//  Created by 제이미 로맥 on 1/6/25.
//

import Foundation
import SwiftData

enum Label: String, Codable, CaseIterable {
    case BLUE, RED, GREEN, YELLOW, PURPLE
}

enum Category: String, Codable, CaseIterable {
    case 한식, 일식, 중식, 양식, 고기구이, 아시안, 피자, 햄버거, 디저트, 분식
}

@Model
final class Restaurant: Identifiable {
    var id: Int
    var label: Label
    var name: String
    var area: String
    var address: String
    var phoneNumber: String
    var restaurantDescription: String
    var isFavorite: Bool
    var rating: Float?
    var weekdayHours: String
    var weekendHours: String
    var hoursNote: String
    var category: Category
    var minPrice: Int
    var maxPrice: Int
    var latitude: Double
    var longitude: Double
    
    init(id: Int, label: Label, name: String, area: String, address: String, phoneNumber: String, description: String, isFavorite: Bool, rating: Float?, weekdayHours: String, weekendHours: String, hoursNote: String, category: Category, minPrice: Int, maxPrice: Int, latitude: Double, longitude: Double) {
        self.id = id
        self.label = label
        self.name = name
        self.area = area
        self.address = address
        self.phoneNumber = phoneNumber
        self.restaurantDescription = description
        self.isFavorite = isFavorite
        self.rating = rating
        self.weekdayHours = weekdayHours
        self.weekendHours = weekendHours
        self.hoursNote = hoursNote
        self.category = category
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.latitude = latitude
        self.longitude = longitude
    }
}

class RestaurantDataLoader {
    static func loadData(modelContext: ModelContext) {
        print("\n=== 데이터베이스 로딩 시작 ===")
        guard let csvPath = Bundle.main.path(forResource: "database", ofType: "csv") else {
            print("❌ CSV 파일을 찾을 수 없습니다.")
            return
        }
        print("📂 CSV 파일 경로: \(csvPath)")
        
        do {
            let csvString = try String(contentsOfFile: csvPath, encoding: .utf8)
            let rows = csvString.components(separatedBy: .newlines)
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
            
            print("📊 총 \(rows.count)개의 행을 찾았습니다.")
            print("📋 헤더: \(rows[0])")
            
            var successCount = 0
            var errorCount = 0
            
            // 첫 번째 행은 헤더이므로 건너뜁니다
            for (index, row) in rows.dropFirst().enumerated() {
                let columns = row.components(separatedBy: ",")
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                
                // 필수 데이터 검증
                guard columns.count >= 17 else {
                    errorCount += 1
                    print("❌ [\(index + 1)] 데이터 열 수 부족: \(columns.count)개")
                    continue
                }
                
                // 데이터 변환 시도
                guard let id = Int(columns[0]) else {
                    errorCount += 1
                    print("❌ [\(index + 1)] ID 변환 실패: \(columns[0])")
                    continue
                }
                
                let label = Label(rawValue: columns[1]) ?? .BLUE
                let name = columns[2]
                let area = columns[3]
                let address = columns[4]
                let phoneNumber = columns[5]
                let description = columns[6]
                let isFavorite = columns[7].lowercased() == "true"
                
                // rating 변환 시도
                let rating: Float?
                if columns[8].lowercased() == "null" {
                    rating = nil
                } else if let ratingValue = Float(columns[8]) {
                    rating = ratingValue
                } else {
                    errorCount += 1
                    print("❌ [\(index + 1)] 별점 변환 실패: \(columns[8])")
                    continue
                }
                
                let weekdayHours = columns[9]
                let weekendHours = columns[10]
                let hoursNote = columns[11]
                let category = Category(rawValue: columns[12]) ?? .한식
                
                // 가격 변환 시도
                guard let minPrice = Int(columns[13]),
                      let maxPrice = Int(columns[14]) else {
                    errorCount += 1
                    print("❌ [\(index + 1)] 가격 변환 실패: \(columns[13]), \(columns[14])")
                    continue
                }
                
                // 위도/경도 변환 시도
                guard let latitude = Double(columns[15]),
                      let longitude = Double(columns[16]) else {
                    errorCount += 1
                    print("❌ [\(index + 1)] 좌표 변환 실패: \(columns[15]), \(columns[16])")
                    continue
                }
                
                let restaurant = Restaurant(
                    id: id,
                    label: label,
                    name: name,
                    area: area,
                    address: address,
                    phoneNumber: phoneNumber,
                    description: description,
                    isFavorite: isFavorite,
                    rating: rating,
                    weekdayHours: weekdayHours,
                    weekendHours: weekendHours,
                    hoursNote: hoursNote,
                    category: category,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    latitude: latitude,
                    longitude: longitude
                )
                
                modelContext.insert(restaurant)
                successCount += 1
                print("✅ [\(index + 1)] 레스토랑 추가: \(name) (\(category.rawValue))")
            }
            
            try modelContext.save()
            print("\n=== 데이터베이스 로딩 완료 ===")
            print("📈 성공: \(successCount)개")
            print("📉 실패: \(errorCount)개")
            print("📊 총계: \(successCount + errorCount)개")
            
        } catch {
            print("\n❌ 데이터 로드 중 오류 발생: \(error)")
        }
    }
}
