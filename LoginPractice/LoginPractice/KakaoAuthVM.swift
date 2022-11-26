//
//  KakaoAuthVM.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/27.
//

import Foundation
import KakaoSDKUser

/// 카카오 로그인 View Model Object
class KakaoAuthVM: ObservableObject {
    
    func login() {
        // 카카오톡 간편 로그인이 가능한지 확인 == 카카오톡이 설치되어 있는지 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    // 카카오톡 앱이 있는 경우, 카카오톡으로 로그인 가능.
    func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
                
                self?.printUserInformation()
            }
        }
    }
    
    // 카카오톡 앱이 없는 경우, 카카오 계정으로 로그인 가능.
    func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                // do something
                let token = oauthToken
                dump(token)
                
                self?.printUserInformation()
            }
        }
    }
    
    // 유저 계정의 프로필 properties에 접근.
    func printUserInformation() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                
                if let nickname = user?.kakaoAccount?.profile?.nickname as? String {
                    print(nickname)
                }
            }
        }
    }
    
    // 사용자 액세스 토큰과 리프레시 토큰을 모두 만료시켜, 더 이상 해당 사용자 정보로 카카오 API를 호출할 수 없도록 함.
    // 로그아웃은 요청 성공 여부와 상관없이 토큰을 삭제 처리.
    func logout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
}
