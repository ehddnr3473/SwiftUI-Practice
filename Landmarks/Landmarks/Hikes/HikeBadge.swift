//
//  HikeBadge.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/25.
//

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack {
            // 배지의 drawing logic은 배지가 랜더링하는 프레임의 크기에 따라 결과를 생성함.
            // 원하는 모양을 유지하려면 300 x 300 포인트 프레임으로 렌더링
            // 최종 그래픽에서 원하는 크기를 얻으려면 렌더링된 결과의 크기를 조정하고 비교적 작은 프레임에 배치함.
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            // 배지는 단지 그래픽일 뿐이므로 HikeBadge의 텍스트와 AccessibilityLabel(_:) modifier는
            // 배지의 의미를 다른 사용자에게 더 명확하게 만듦.
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
