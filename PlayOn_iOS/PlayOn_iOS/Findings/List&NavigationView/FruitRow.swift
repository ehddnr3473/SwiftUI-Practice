//
//  FruitRow.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/30.
//

import SwiftUI

struct FruitRow: View {
    let fruit: Fruit
    var body: some View {
        HStack {
            fruit.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(fruit.name)
                .font(.largeTitle)
            Spacer()
        }
    }
}

struct FruitRow_Previews: PreviewProvider {
    static var previews: some View {
        FruitRow(fruit: Fruit(name: "Orange", image: Image("Orange")))
    }
}
