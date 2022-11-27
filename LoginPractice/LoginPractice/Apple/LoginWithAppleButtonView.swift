//
//  LoginWithAppleButtonView.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/27.
//

import SwiftUI
import AuthenticationServices

// SwiftUI View는 애플 로그인 버튼을 제공하지 않음.
// UIView(애플 로그인 버튼)를 wrap하기 위해 protocol UIViewRepresentable 채택
struct LoginWithAppleButtonView: UIViewRepresentable {
    
    // View의 state가 변하지 않을 것이기 때문에 업데이트를 하지 않음.
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    // 보여줄 UIView 타입을 return, 여기에서는 애플 로그인 버튼
    // UIView에 대해 customization하여 return 가능
    func makeUIView(context: Context) -> UIView {
        return ASAuthorizationAppleIDButton()
    }
}
