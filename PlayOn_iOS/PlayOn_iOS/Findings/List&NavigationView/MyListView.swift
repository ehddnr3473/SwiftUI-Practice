//
//  MyListView.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/30.
//

import SwiftUI

struct MyListView: View {
    let model = FruitsModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(model.fruits, id: \.name) { fruit in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        FruitRow(fruit: fruit)
                    }
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

struct MyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
