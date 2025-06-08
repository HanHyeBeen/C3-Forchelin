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
            print("데이터베이스 초기화 시작...")
            modelContainer = try ModelContainer(for: Restaurant.self)
            print("데이터베이스 초기화 완료")
            
            print("데이터 로딩 시작...")
            RestaurantDataLoader.loadData(modelContext: modelContainer.mainContext)
            print("데이터 로딩 완료")
        } catch {
            print("데이터베이스 초기화 중 오류 발생: \(error)")
            fatalError("데이터베이스 초기화 실패")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabsView()
        }
        .modelContainer(modelContainer)
    }
}
