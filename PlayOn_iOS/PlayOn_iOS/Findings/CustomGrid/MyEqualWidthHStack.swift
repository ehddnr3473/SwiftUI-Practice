//
//  MyEqualWidthHStack.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/03.
//

import SwiftUI

// 수평으로 정렬된 모든 버튼에 맞는 컨테이너의 크기를 모두 같은 너비로 반환하기 위한 Layout
// HStack은 가능한 모든 공간을 사용하므로 그것이 불가능.
struct MyEqualWidthHStack: Layout {
    // Layout 컨테이너의 크기를 계산하고 보고함.
    // proposal: 자체 컨테이너 뷰에서 제안된 크기
    // subviews:
    /// Layout 컨테이너의 크기를 계산하고 보고함.
    /// - Parameters:
    ///   - proposal: 자체 컨테이너 뷰에서 제안된 크기
    ///   - subviews: 레이아웃의 하위 뷰에 크기를 제안할 수 있음.
    ///   - cache: 메서드 호출 간에 중간 계산 결과를 공유하는 데 사용할 수 있는 양방향 캐시. 간단한 레이아웃의 경우 캐시는 필요없음.
    ///   Instruments를 사용하여 앱을 프로파일링한 결과 레이아웃 코드의 효율성을 개선해야 한다고 표시되면, 문서를 참고하여 추가할것.
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
        return CGSize(
            width: maxSize.width * CGFloat(subviews.count) + CGFloat(totalSpacing),
            height: maxSize.height)
    }
    
    func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }
        return maxSize
    }
    
    func spacing(subviews: Subviews) -> [Int] {
        let spacing = subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return Int(subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal))
        }
        
        return spacing
    }
    
    /// 하위 뷰에 표시할 위치를 알려줌.
    /// - Parameters:
    ///   - bounds: 하위 뷰를 배치해야 하는 영역을 나타내는 범위, sizeThatFits 구현에서 요청한 CGSize의 사각형(.size.width, .size.height)
    ///   - proposal: 자체 컨테이너 뷰에서 제안된 크기
    ///   - subviews: 레이아웃의 하위 뷰에 크기를 제안할 수 있음.
    ///   - cache: 메서드 호출 간에 중간 계산 결과를 공유하는 데 사용할 수 있는 양방향 캐시
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        // 원하는 크기를 기준으로 size proposal 생성
        // 모든 버튼 크기가 같기를 원하기 때문에 하나의 제안만 필요함.
        let sizeProposal = ProposedViewSize(
            width: maxSize.width,
            height: maxSize.height)
        // 첫 번째 하위뷰의 수평(x축)에서 시작 위치를 찾음.
        // 원점을 0으로 설정하지 않고 minX 값으로 시작.
        var  x = bounds.minX + maxSize.width / 2
        
        // 루프를 돌 때마다 뷰의 너비와 다음 뷰 쌍의 간격으로 수평 위치를 업데이트하여 다음 반복을 준비
        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: x, y: bounds.midY),
                anchor: .center,
                proposal: sizeProposal)
            x += maxSize.width + CGFloat(spacing[index])
        }
    }
}
