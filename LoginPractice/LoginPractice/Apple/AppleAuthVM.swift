//
//  AppleAuthVM.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/27.
//

import Foundation
import AuthenticationServices

class AppleAuthVM: ObservableObject {
    
    @Published var isLoggedIn = false
    
    var loginStatus: String {
        isLoggedIn ? "ON" : "OFF"
    }
    
    func appleLogin() {
        // 로그인 요청에는 ASAuthorizationAppleIDRequest가 필요
        let request = ASAuthorizationAppleIDProvider().createRequest()
        
        // 사용자 데이터 타입을 지정
        request.requestedScopes = [.fullName, .email]
        
        // 로그인 대화 상자를 표시할 컨트롤러를 생성
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
        /* 필요한 사용자 데이터만 요청해야 함. 따라서 이메일을 수집하는 유일한 목적이 고유 식별자를 갖는 것이라면, 필요하지 않으므로 요청하지 말것.*/
//        authorizationController.performRequests()
    }
    
    func appleLogout() {
        
    }
}
