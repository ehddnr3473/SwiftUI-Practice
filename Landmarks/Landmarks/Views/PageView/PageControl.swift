//
//  PageControl.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    // 새 coordinator를 만들고 반환
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        // 사용자가 UIPageControl의 값을 변경했을 때, target-action
        control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        
        return control
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let pageView = uiView as? UIPageControl {
            pageView.currentPage = currentPage
        }
    }
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        // UIPageControl과 같은 UIControl 하위 클래스는 delegation 대신 target-action 패턴을 사용하므로
        // 이 coordinator는 @objc 메서드를 구현하여 현재 페이지 바인딩을 업데이트함.
        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
