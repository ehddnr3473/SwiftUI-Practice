//
//  MyAppDelegate.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

// AppDelegate에서 초기화해줘야 한다면 다음과 같이 만들어줄 수 있음.
class MyAppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        guard let appKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else { return false }
        KakaoSDK.initSDK(appKey: appKey)
        
        return true
    }
    
    // iOS 13 미만으로 생성된 프로젝트라면 AppDelegate에 다음 내용 추가
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }
    // AppDelegate에서 SceneDelegate를 사용한다고 설정
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
        sceneConfiguration.delegateClass = MySceneDelegate.self
        
        return sceneConfiguration
    }
}
