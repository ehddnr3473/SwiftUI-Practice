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
    
    // 로그인 상태
    @Published var isLoggedIn: Bool = false
    
    var loginStatus: String {
        return isLoggedIn ? "ON" : "OFF"
    }
    
    // 메인 스레드에서 Task블록을 수행할 수 있게끔 만들어줌.
    @MainActor
    func kakaoLogin() {
        Task {
            // 카카오톡 간편 로그인이 가능한지 확인 == 카카오톡이 설치되어 있는지 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡 간편 로그인을 하고, 로그인 상태 설정
                isLoggedIn = await loginWithKakaoTalk()
            } else {
                // 카카오 계정으로 로그인하고, 로그인 상태 설정
                isLoggedIn = await loginWithKakaoAccount()
            }
        }
    }
    
    // 카카오톡 앱이 있는 경우, 카카오톡으로 로그인 가능.
    func loginWithKakaoTalk() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    Task {
                        if await self.printUserInformation() {
                            continuation.resume(returning: true)
                        }
                    }
//                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // 카카오톡 앱이 없는 경우, 카카오 계정으로 로그인 가능.
    @MainActor
    func loginWithKakaoAccount() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoAccount() success.")
                    
                    // do something
                    _ = oauthToken
                    
                    Task {
                        if await self.printUserInformation() {
                            continuation.resume(returning: true)
                        }
                    }
//                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // 유저 계정의 프로필 properties에 접근.
    func printUserInformation() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.me() { (user, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("me() success.")
                    
                    if let nickname = user?.kakaoAccount?.profile?.nickname as? String {
                        print(nickname)
                        continuation.resume(returning: true)
                    }
//                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await logout() {
                isLoggedIn = false
            }
        }
    }
    
    // 사용자 액세스 토큰과 리프레시 토큰을 모두 만료시켜, 더 이상 해당 사용자 정보로 카카오 API를 호출할 수 없도록 함.
    // 로그아웃은 요청 성공 여부와 상관없이 토큰을 삭제 처리.
    func logout() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
