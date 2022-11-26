//
//  LoginPracticeApp.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct LoginPracticeApp: App {
    
    // AppDelegate로 초기화해주는 경우
//    @UIApplicationDelegateAdaptor var appDelegate: MyAppDelegate
    
    init() {
        guard let appKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else { return }
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: appKey)
    }
    
    var body: some Scene {
        WindowGroup {
            // onOpenURL()을 사용해 커스텀 URL 스킴 처리
            ContentView().onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
