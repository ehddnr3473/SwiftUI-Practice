//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/25.
//

import SwiftUI

/* 사용자가 편집 모드를 종료할 때까지 편집 내용이 적용되지 않도록 편집하는 동안 프로필의 초안 사본을 사용한 다음
 사용자가 편집을 확인(Done)한 경우에만 초안 사본을 실제 사본에 할당*/
struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                // label과 문자열 바인딩을 제공
                TextField("Username", text: $profile.username)
            }
            
            // 랜드마크 관련 이벤트에 대한 알림 수신에 대한 사용자 기본 설정에 해당하는 토글
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notification").bold()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Seasonal Photo").bold()
                
                Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                    ForEach(Profile.Season.allCases) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date").bold()
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
