//
//  MySceneDelegate.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import Foundation
import UIKit
import KakaoSDKAuth

// AppDelegate에서 SceneDelegate를 사용한다고 설정을 해야함.
class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
