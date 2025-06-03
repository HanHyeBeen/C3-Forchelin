//
//  recommendRestaurants.swift
//  F1T5
//
//  Created by 진아현 on 6/3/25.
//

import Foundation

func recommendBasedOnUserRatings(from restaurants: [Restaurant]) -> [Restaurant] {
    // 1. 평점이 있는 식당만 필터링
    let ratedRestaurants = restaurants.filter { $0.rating != nil && $0.rating! > 0 }

    // 2. 라벨과 카테고리별 평점 평균 계산
    var labelScores: [Label: [Float]] = [:]
    var categoryScores: [Category: [Float]] = [:]

    for restaurant in ratedRestaurants {
        labelScores[restaurant.label, default: []].append(restaurant.rating!)
        categoryScores[restaurant.category, default: []].append(restaurant.rating!)
    }

    // 3. 평균 평점 계산
    let labelAverages = labelScores.mapValues { $0.reduce(0, +) / Float($0.count) }
    let categoryAverages = categoryScores.mapValues { $0.reduce(0, +) / Float($0.count) }

    // 4. 추천 점수 계산
    func score(for restaurant: Restaurant) -> Float {
        let labelScore = labelAverages[restaurant.label] ?? 0
        let categoryScore = categoryAverages[restaurant.category] ?? 0
        return labelScore * 0.6 + categoryScore * 0.4
    }

    // 5. 추천 정렬 (아직 평점을 안 준 식당들 중에서만 추천)
    let unratedRestaurants = restaurants.filter { $0.rating == nil || $0.rating == 0 }
    return unratedRestaurants.sorted {
        score(for: $0) > score(for: $1)
    }
    
}
