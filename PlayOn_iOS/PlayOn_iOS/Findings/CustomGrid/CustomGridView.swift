//
//  CustomGridView.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/03.
//

import SwiftUI

struct CustomGridView: View {
    @State private var pets: [Pet] = Pet.exampleData
    var body: some View {
        VStack {
            Grid(alignment: .leading) {
                ForEach(pets) { pet in
                    GridRow {
                        Text(pet.type)
                        ProgressView(
                            value: Double(pet.votes),
                            total: Double(Pet.totalVotes))
                        Text("\(pet.votes)")
                            .gridColumnAlignment(.trailing)
                    }
                    Divider()
                }
            }
//            .environment(\.dynamicTypeSize, .accessibility3)
            ViewThatFits {
                MyEqualWidthHStack {
                    Buttons(pets: $pets)
                }
            }
//            .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}

struct Buttons: View {
    @Binding var pets: [Pet]
    
    var body: some View {
        ForEach($pets) { $pet in
            Button {
                pet.votes += 1
            } label: {
                Text(pet.type)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView()
    }
}
