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
        /*
         - Grid는 모든 View를 한 번에 로드하므로 열과 행 모두에서 셀의 크기를
         자동으로 조정하고 정렬할 수 있음.
         - 가장 큰 View를 유지하는 데 필요한 만큼의 공간을 각 행과 열에 할당.
         - ProgressView와 같은 유연한 View는 그리드가 제공하는 만큼의 공간을 차지하며,
         이 경우 텍스트 열에 공간을 할당한 후 남은 공간을 차지함.
         
         Grid {
         GridRow {
         Text("Cat")
         ProgressView(value: 0.5)
         Text("25")
         }
         GridRow  {
         Text("Goldfish")
         ProgressView(value: 0.2)
         Text("9")
         }
         GridRow {
         Text("Dog")
         ProgressView(value: 0.3)
         Text("16")
         }
         }
         */
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
                    /*
                     GridRow {
                     // view modifier를 사용하지 않으면 Divider는 유연한 뷰이므로 첫 번째 열이 더 많은 공간을 차지하게 됨.
                     Divider().gridCellColumns(3)
                     }
                     */
                }
            }
            MyEqualWidthHStack {
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
    }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView()
    }
}
