//
//  PageView.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI


// UIViewControllerRepresentable 뷰를 보여주기 위한 custom 뷰
/* custom UIPageControl 추가를 준비하려면 PageView 내에서 현재 페이지를 추적하는 방법이 필요함.
 그러려면 PageView에서 @State property를 선언하고 이 속성에 대한 바인딩을 PageViewController view로 전달.
 PageViewController는 보이는 페이지와 일치하도록 바인딩을 업데이트함.
 */
struct PageView<Page: View>: View {
    var pages: [Page]
    // 초기값을 변경하여 PageViewController에 대한 바인딩을 통해 값이 흐르는지 테스트할 수 있음.
    // @State private var currentPage = 1
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // child PageViewController를 생성할 때 속성에 대한 바인딩을 전달.
            // $ syntax를 사용하여 상태(state)로 저장된 값에 대한 바인딩을 생성.
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
