//
//  ContentView.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @ObservedObject var kakaoAuthVM: KakaoAuthVM
    @ObservedObject var appleAuthVM: AppleAuthVM
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("로그인 상태: \(kakaoAuthVM.loginStatus)")
            
            Button("카카오 로그인") {
                kakaoAuthVM.kakaoLogin()
            }
            .frame(width: 280, height: 60)
            .border(.black, width: 1)
            
            Button("카카오 로그아웃") {
                kakaoAuthVM.kakaoLogout()
            }
            .frame(width: 280, height: 60)
            .border(.black, width: 1)
            
            LoginWithAppleButtonView()
                .frame(width: 280, height: 60)
                .onTapGesture {
                    appleAuthVM.appleLogin()
                }
            
            Button("애플 로그아웃") {
                appleAuthVM.appleLogout()
            }
            .frame(width: 280, height: 60)
            .border(.black, width: 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let kakaoAuthVM = KakaoAuthVM()
        let appleAuthVM = AppleAuthVM()
        LoginView(kakaoAuthVM: kakaoAuthVM, appleAuthVM: appleAuthVM)
    }
}
