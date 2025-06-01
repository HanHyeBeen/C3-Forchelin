//
//  F1T5App.swift
//  F1T5
//
//  Created by Enoch on 5/29/25.
//

import SwiftUI
import SwiftData

@main
struct F1T5App: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Restaurant.self)
            // 데이터 로드
            print("데이터 로딩 시작...")
            RestaurantDataLoader.loadData(modelContext: modelContainer.mainContext)
            print("데이터 로딩 완료")
        } catch {
            print("데이터 로딩 중 오류 발생: \(error)")
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
