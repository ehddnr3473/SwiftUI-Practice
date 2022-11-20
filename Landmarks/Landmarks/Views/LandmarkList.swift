//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            /* List는 identifiable data로 work.
             두 가지 방법 중 하나로 data를 identifiable하게 만들 수 있음.
             1. 각 요소를 고유하게 식별하는 속성에 대한 key path를 data와 함께 전달
             ex)
             List(landmarks, id: \.id) { landmark in
             LandmarkRow(landmark: landmark)
             }
             2. Identifiable 프로토콜을 준수하는 data 타입 사용
             */
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        /* ForEach는 List와 동일한 방식으로 collection에서 작동하므로 stack, list, group과 같이 child view를 사용할 수 있는 모든 곳에서 사용할 수 있음. 데이터의 elements가 여기에서 사용하는 문자열과 같은 단순한 값 유형인 경우 \.self를 식별자에 대한 key path로 사용할 수 있음. */
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                // 다양한 장치로 실험하여 캔버스에서 View의 rendering을 비교할 수 있음.
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
