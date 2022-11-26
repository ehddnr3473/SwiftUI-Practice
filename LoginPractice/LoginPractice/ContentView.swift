//
//  ContentView.swift
//  LoginPractice
//
//  Created by 김동욱 on 2022/11/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("카카오 로그인") {
                kakaoAuthVM.login()
            }
            Button("카카오 로그아웃") {
                kakaoAuthVM.logout()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
