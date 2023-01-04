//
//  PopulationProgressLineCharts.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2023/01/01.
//

import SwiftUI
import Charts

struct Series: Identifiable {
    let country: String
    let populationSummary: [PopulationSummary]
    
    var id: String { country }
}

let seriesData: [Series] = [
    .init(country: "Korea", populationSummary: koreaData),
    .init(country: "Japan", populationSummary: japanData)
]

struct PopulationProgressLineCharts: View {
    var body: some View {
        Chart(seriesData) { series in
            ForEach(series.populationSummary) { element in
                LineMark(x: .value("Year", element.year),
                         y: .value("Population", element.population)
                )
                // country에 따라 자동으로 색상을 구분해줌.
                .foregroundStyle(by: .value("Country", series.country))
                // PointMark를 중첩하는 효과
                .symbol(by: .value("Country", series.country))
                // 꺾은선을 곡선으로
                .interpolationMethod(.catmullRom)
            }
        }
        .padding(LayoutConstants.offset)
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 20
}

struct PopulationProgressLineCharts_Previews: PreviewProvider {
    static var previews: some View {
        PopulationProgressLineCharts()
    }
}
