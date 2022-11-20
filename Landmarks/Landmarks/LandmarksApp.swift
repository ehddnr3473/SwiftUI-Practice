//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/19.
//

import SwiftUI

// @main attribute는 앱의 entry point를 식별하도록 함.
@main
struct LandmarksApp: App {
    // model 인스턴스를 만들고 environmentObject(_:) modifier를 사용하여 ContentView에 제공.
    // @StateObject attribute를 사용하여 앱 life time동안 한 번만 지정된 property에 대한 model object를 초기화
    // 앱 인스턴스에서 attribute를 사용할 때와 View에서 attribute를 사용할 때 모두 마찬가지.
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
