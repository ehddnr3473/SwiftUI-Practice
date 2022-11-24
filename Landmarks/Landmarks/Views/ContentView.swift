//
//  ContentView.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // model object를 environment에 추가하면 객체를 모든 subview에서 사용할 수 있음.
            // subview가 environment의 model object를 필요로 하지만 미리보기에
            // environmentObject(_:) modifier가 없는 경우 미리보기를 실패함.
            .environmentObject(ModelData())
    }
}
