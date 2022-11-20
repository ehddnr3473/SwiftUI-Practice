//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/21.
//

import SwiftUI

// reusable Favorite button
// List에서 세부 정보로 이동하고 즐겨찾기 버튼을 누르면 List로 돌아올 때 변경사항이 유지됨.
// List와 Detail, 두 View 모두 environment에서 동일한 model object에 액세스하기 때문에 두 View는 일관성을 유지함.
struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            /* iconOnly label을 사용하는 경우, button label에 대해 제공하는 title string은 UI에 나타나지 않지만 VoiceOver는 접근성을 개선하기 위해 이를 사용함. */
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
