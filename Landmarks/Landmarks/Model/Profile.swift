//
//  Profile.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/25.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    // 선호 시즌
    var seasonalPhoto = Season.winter
    // 랜드마크 방문 목표 날짜
    var goalDate = Date()
    
    static let `default` = Profile(username: "yeolmok")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌹"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "❄️"
        
        var id: String { rawValue }
    }
}
