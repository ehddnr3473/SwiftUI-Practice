//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/23.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        // 배지가 포함된 뷰(super view, containing view)의 크기를 사용할 수 있도록
        // GeometryReader로 Path를 wrapping
        GeometryReader { geometry in
            // Path를 사용하여 선, 곡선 및 기타 기본 요소를 결합하여
            // 배지의 육각형 배경과 같은 복잡한 Shape을 형성
            Path { path in
                // "width: CGFloat = 100"의 경우, 크기가 100 X 100 픽셀(px)인 컨테이너를 가정하여
                // 경로(path)에 시작점을 추가
                // geometry의 두 치수 중 작은 치수를 사용하면 containing view가
                // 정사각형이 아닌 경우 배지의 종횡비가 유지됨.
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                // xScale을 사용하여 x축에서 모양의 크기를 조정
                // xOffset을 사용하여 geometry 내에서 shape을 중앙에 맞춤.
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                // move(to:) 메서드는 가상의 펜이나 연필이 해당 영역 위를 맴돌며
                // 그리기 시작하기를 기다리는 것처럼 도형의 경계 내에서 drawing 커서를 이동함.
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagoneParameters.adjustment)
                    )
                )
                
                HexagoneParameters.segments.forEach { segment in
                    // addLine(to:) 메서드는 단일 점을 가져와서 그림.
                    // addLine에 대한 연속 호출은 (이전 지점 -> 새 지점)으로 그림
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    // addQuadCurve(to:control:) 메서드를 사용하여
                    // 배지 모서리의 곡선을 그림
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
