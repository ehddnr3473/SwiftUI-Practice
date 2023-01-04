//
//  AdvancedCharts.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2023/01/01.
//

import SwiftUI
import Charts

struct Country: Identifiable {
    let name: String
    let population: Int
    
    var id: String { name }
}

let countries: [Country] = [
    .init(name: "Korea", population: 51550000),
    .init(name: "China", population: 1425000000),
    .init(name: "Japan", population: 123950000),
    .init(name: "US", population: 338280000),
    .init(name: "Canada", population: 38780000),
    .init(name: "Ghana", population: 34120000)
]

struct AdvancedCharts: View {
    var body: some View {
        /* ForEach()가 차트에서 유일한 콘텐츠일 경우, Chart 이니셜라이저에 데이터를 직접 넣어도 됨.
         Chart{
             ForEach(countries) { element in
                 BarMark(
                     x: .value("Name", element.name),
                     y: .value("Population", element.population)
                 )
             }
         }
         */
        VStack {
            Text("Population")
                .font(.title)
            
            Chart(countries) { element in
                /* 데이터가 많아질 수록 차트에 Bar Mark가 늘어나고, x축의 레이블들이 서로 점점 가까워지며 공간이 부족해질 수 있음. 그때, x와 y를 교체할 수 있음.*/
                BarMark(x: .value("Population", element.population),
                        y: .value("Name", element.name)
                )
            }
        }
        .padding(LayoutConstants.offset)
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 20
}

struct AdvancedCharts_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCharts()
    }
}
