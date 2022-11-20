//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks
    static var previews: some View {
        // 그룹화
        Group {
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        // List의 행과 비슷한 크기를 설정하려면 previewLayout()을 사용해서 확인해볼 수 있음.
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
