//
//  SimplePopulationCharts.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2023/01/01.
//

import SwiftUI
import Charts

struct SimplePopulationCharts: View {
    var body: some View {
        VStack {
            Text("East Asian population")
                .font(.title)
            
            Chart {
                BarMark(
                    x: .value("Name", "Korea"),
                    y: .value("Population", 51550000)
                )
                BarMark(
                    x: .value("Name", "China"),
                    y: .value("Population", 1425000000)
                )
                BarMark(x: .value("Name", "Japan"),
                        y: .value("Population", 123950000))
            }
        }
    }
}

struct MyCharts_Previews: PreviewProvider {
    static var previews: some View {
        SimplePopulationCharts()
    }
}
