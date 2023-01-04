//
//  PopulationProgressCharts.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2023/01/01.
//

import SwiftUI
import Charts

enum Countries {
    case korea
    case japan
}

struct PopulationSummary: Identifiable {
    let year: Date
    let population: Int
    
    var id: Date { year }
}

// 출처: 통계청
let koreaData: [PopulationSummary] = [
    .init(year: DateCreator.date("1983"), population: 3991),
    .init(year: DateCreator.date("1993"), population: 4419),
    .init(year: DateCreator.date("2003"), population: 4789),
    .init(year: DateCreator.date("2013"), population: 5042),
    .init(year: DateCreator.date("2023"), population: 5155)
]

// 출처: data.worldbank.org
// 23년 인구수는 통계청 자료, 일본 22년 인구수를 편의상 23년으로 표기
let japanData: [PopulationSummary] = [
    .init(year: DateCreator.date("1983"), population: 11930),
    .init(year: DateCreator.date("1993"), population: 12482),
    .init(year: DateCreator.date("2003"), population: 12771),
    .init(year: DateCreator.date("2013"), population: 12744),
    .init(year: DateCreator.date("2023"), population: 12395)
]

struct PopulationProgressCharts: View {
    @State var country = Countries.korea
    
    var data: [PopulationSummary] {
        switch country {
        case .korea:
            return koreaData
        case .japan:
            return japanData
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("인구 추이")
                    .font(.system(.title, weight: .semibold))
                Text("단위: 만")
                    .foregroundColor(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            }
            
            Picker("Country", selection: $country.animation(.easeInOut)) {
                Text("한국").tag(Countries.korea)
                Text("일본").tag(Countries.japan)
            }
            .pickerStyle(.segmented)
            
            Chart(data) { element in
                BarMark(
                    x: .value("Year", element.year),
                    y: .value("Population", element.population)
                )
                .annotation {
                    Text("\(element.population)")
                }
            }
        }
    }
}

struct PopulationProgressCharts_Previews: PreviewProvider {
    static var previews: some View {
        PopulationProgressCharts()
    }
}
