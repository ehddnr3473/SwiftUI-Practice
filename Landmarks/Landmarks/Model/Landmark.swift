//
//  Landmark.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import Foundation
// For Image()
import SwiftUI
// For CLLocationCoordinate
import CoreLocation

// Landmark Model
struct Landmark: Hashable, Codable, Identifiable {
    // Identifiable 프로토콜에 필요한 property: id
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    // Landmark structure 사용자는 이미지 자체에만 관심이 있으므로 private
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    // nested Coordinates type
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
