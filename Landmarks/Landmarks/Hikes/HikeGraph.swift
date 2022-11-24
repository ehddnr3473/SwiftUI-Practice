/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The elevation, heart rate, and pace of a hike plotted on a graph.
*/

import SwiftUI

extension Animation {
    static func ripple(_ index: Int) -> Animation {
        // HikeGraph.swift에서 작업할 때,
        // HikeView.swift의 preview를 pin하여 작업하면서 preview를 볼 수 있음.
        Animation.spring(dampingFraction: 0.5)
            // 각 막대가 새 위치로 이동하는 데 걸리는 시간을 단축하기 위해 애니메이션 속도를 높일 수 있음.
            .speed(2)
            // index를 기반으로 각 애니메이션에 delay 추가
            .delay(0.03 * Double(index))
    }
}

struct HikeGraph: View {
    var hike: Hike
    var path: KeyPath<Hike.Observation, Range<Double>>

    var color: Color {
        switch path {
        case \.elevation:
            return .gray
        case \.heartRate:
            return Color(hue: 0, saturation: 0.5, brightness: 0.7)
        case \.pace:
            return Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
        default:
            return .black
        }
    }

    var body: some View {
        let data = hike.observations
        let overallRange = rangeOfRanges(data.lazy.map { $0[keyPath: path] })
        let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
        let heightRatio = 1 - CGFloat(maxMagnitude / magnitude(of: overallRange))

        return GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, observation in
                    GraphCapsule(
                        index: index,
                        color: color,
                        height: proxy.size.height,
                        range: observation[keyPath: path],
                        overallRange: overallRange
                    )
                    .animation(.ripple(index))
                }
                .offset(x: 0, y: proxy.size.height * heightRatio)
            }
        }
    }
}

func rangeOfRanges<C: Collection>(_ ranges: C) -> Range<Double>
    where C.Element == Range<Double> {
    guard !ranges.isEmpty else { return 0..<0 }
    let low = ranges.lazy.map { $0.lowerBound }.min()!
    let high = ranges.lazy.map { $0.upperBound }.max()!
    return low..<high
}

func magnitude(of range: Range<Double>) -> Double {
    range.upperBound - range.lowerBound
}

struct HikeGraph_Previews: PreviewProvider {
    static var hike = ModelData().hikes[0]

    static var previews: some View {
        Group {
            HikeGraph(hike: hike, path: \.elevation)
                .frame(height: 200)
            HikeGraph(hike: hike, path: \.heartRate)
                .frame(height: 200)
            HikeGraph(hike: hike, path: \.pace)
                .frame(height: 200)
        }
    }
}
