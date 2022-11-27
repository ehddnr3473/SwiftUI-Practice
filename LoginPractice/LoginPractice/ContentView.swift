//
//  ContentView.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var kakaoAuthVM = KakaoAuthVM()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("로그인 상태: \(kakaoAuthVM.loginStatus)")
            
            Button("카카오 로그인") {
                kakaoAuthVM.login()
            }
            .frame(width: 200, height: 50)
            .border(.black, width: 1)
            
            Button("카카오 로그아웃") {
                kakaoAuthVM.kakaoLogout()
            }
            .frame(width: 200, height: 50)
            .border(.black, width: 1)
            
//            Button("애플 로그인") {
//
//            }
//            .frame(width: 200, height: 50)
//            .border(.black, width: 1)
//
//            Button("애플 로그아웃") {
//
//            }
//            .frame(width: 200, height: 50)
//            .border(.black, width: 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
