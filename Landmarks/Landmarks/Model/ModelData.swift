//
//  ModelData.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import Foundation
import Combine

// SwiftUI는 observable object를 subscribe하고 데이터가 변경될 때 새로 고쳐야 하는 모든 View를 업데이트.
// observable object는 subscriber가 변경 사항을 선택할 수 있도록 데이터 변경 사항을 Publish해야 함.
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
