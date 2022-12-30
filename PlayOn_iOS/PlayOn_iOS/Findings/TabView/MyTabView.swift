//
//  TabBarView.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/30.
//

import SwiftUI

struct MyTabView: View {
    // control
    @State private var selection = Tab.second
    // Hashable
    enum Tab {
        case first
        case second
    }
    var body: some View {
        TabView(selection: $selection) {
            FirstTabView()
                .tabItem {
                    Label("First", systemImage: "1.circle")
                }
                .tag(Tab.first)
            SecondTabView()
                .tabItem {
                    Label("Second", systemImage: "2.circle")
                }
                .tag(Tab.second)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
