//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/25.
//

import SwiftUI

// 편집 내용을 확인하기 전에(예: 사용자가 이름을 입력하는 동안) 전역 앱 상태 업데이트를 방지하기 위해
// 편집 뷰는 복사본에서 작동
struct ProfileHost: View {
    /* SwiftUI는 @Environment property wrapper를 사용하여 액세스할 수 있는 값에 대한
    저장소를 환경 내에서 제공함. editMode 값에 액세스하여 편집 범위를 읽거나 씀. */
    // 환경의 \.editMode를 keys off하는 Environment view property
    @Environment(\.editMode) var editMode
    
    // 환경에서 사용자의 프로필 데이터를 읽어 데이터 제어를 ProfileHost에 전달.
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .inactive {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                // 환경의 editMode 값을 on and off하는 편집 버튼
                EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    // Editor를 올바른 프로필 데이터로 채우고 사용자가 Done 버튼을 누를 때 영구 프로필을 업데이트
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            // ProfileHost View는 @EnvironmentObject attribute property를 사용하지 않지만,
            // 하위 뷰인 ProfileSummary는 사용함.
            // 따라서 modifier가 없으면 preview 실패.
            .environmentObject(ModelData())
    }
}
