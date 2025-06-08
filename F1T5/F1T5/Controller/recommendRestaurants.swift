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
    let unratedRestaurants = restaurants.filter { $0.rating == nil || $0.rating == 0 }

    let reviewCount = ratedRestaurants.count

    // 전기: 리뷰 5개 미만 - 무작위 추천
    if reviewCount < 5 {
        return unratedRestaurants.shuffled()
    }

    // 중기: 리뷰 5~9개 - 라벨/카테고리 위주 필터링 + 랜덤
    if reviewCount < 10 {
        // 사용자가 리뷰한 라벨/카테고리 추출
        let reviewedLabels = Set(ratedRestaurants.map { $0.label })
        let reviewedCategories = Set(ratedRestaurants.map { $0.category })

        // 일치하는 식당들만 필터링
        let filtered = unratedRestaurants.filter {
            reviewedLabels.contains($0.label) || reviewedCategories.contains($0.category)
        }

        // 없으면 그냥 전체에서 랜덤 추천
        return (filtered.isEmpty ? unratedRestaurants : filtered).shuffled()
    }

    // 후기: 리뷰 10개 이상 - 기존 추천 알고리즘 사용
    // 라벨/카테고리별 평균 평점 계산
    var labelScores: [Label: [Float]] = [:]
    var categoryScores: [Category: [Float]] = [:]

    for restaurant in ratedRestaurants {
        labelScores[restaurant.label, default: []].append(restaurant.rating!)
        categoryScores[restaurant.category, default: []].append(restaurant.rating!)
    }

    let labelAverages = labelScores.mapValues { $0.reduce(0, +) / Float($0.count) }
    let categoryAverages = categoryScores.mapValues { $0.reduce(0, +) / Float($0.count) }

    func score(for restaurant: Restaurant) -> Float {
        let labelScore = labelAverages[restaurant.label] ?? 0
        let categoryScore = categoryAverages[restaurant.category] ?? 0
        return labelScore * 0.6 + categoryScore * 0.4
    }

    return unratedRestaurants.sorted { score(for: $0) > score(for: $1) }
}
