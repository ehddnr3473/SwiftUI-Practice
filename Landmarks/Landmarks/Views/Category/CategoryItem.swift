//
//  CategoryItem.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/24.
//

import SwiftUI

struct CategoryItem: View {
    var landmarks: Landmark
    
    var body: some View {
        VStack(alignment: .leading) {
            landmarks.image
                // NavigationLink의 label로 전달되는 이미지는 template image로 렌더링될 수 있음.
                // renderingMode()로 이를 방지
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmarks.name)
                // NavigationLink의 label로 전달되는 Text는 environment의 accent color를 사용하여 렌더링됨.
                // color를 지정해줘서 이를 방지
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmarks: ModelData().landmarks[0])
    }
}
