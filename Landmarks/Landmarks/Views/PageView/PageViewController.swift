//
//  PageViewController.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/26.
//

import Foundation
import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    // SwiftUI는 makeUIViewController(context:) 전에 이 makeCoordinator() 메서드를 호출하므로
    // 뷰 컨트롤러를 구성(configure)할 때 coordinator 객체에 액세스 할 수 있음.
    // 이 coordinator를 사용하여 delegate, data source 및 target-action을 통한 사용자 이벤트 응답과 같은 일반적인 Cocoa 패턴을 구현할 수 있음.
    // 여기에서는 makeUIViewController(context:)에서 데이터소스를 설정.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // SwiftUI는 뷰를 표시할 준비가 되었을 때 이 메서드를 한 번 호출한 다음 뷰 컨트롤러의 라이프 사이클을 관리함.
    // 원하는 구성으로 UIPageViewController를 생성
    func makeUIViewController(context: Context) -> some UIViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        // coordinator를 UIPageViewController의 데이터소스로 추가
        pageViewController.dataSource = context.coordinator
        // coordinator를 UIPageViewController의 대리자(delegate)로 할당
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    // 보여줄 뷰 컨트롤러를 제공하기 위한 메서드
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let pageViewController = uiViewController as? UIPageViewController {
            pageViewController.setViewControllers(
                [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
        } else {
            print("error occured at updateUIViewController")
        }
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            // 페이지(view) 배열을 사용하여 coordanator에서 컨트롤러 배열을 초기화
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        // 아래의 두가지 메서드는 UIPageViewControllerDataSource의 필수 메서드
        // 뷰 컨트롤러 간의 관계를 설정하므로 뷰 컨트롤러 간에 앞뒤로 스와이프할 수 있음.
        // 회전목마(carousel)처럼 구현
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        // 페이지 전환 애니메이션이 완료될 때마다 SwiftUI가 이 메서드를 호출하기 때문에
        // 현재 뷰 컨트롤러의 인덱스를 찾고
        // 바인딩을 업데이트
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
