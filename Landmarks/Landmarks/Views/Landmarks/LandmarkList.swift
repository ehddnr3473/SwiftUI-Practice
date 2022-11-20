//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import SwiftUI

struct LandmarkList: View {
    // modelData protperty는 environmentObject(_:) modifier가 parent에 적용되는 한 자동으로 값을 가져옴.
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
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
            List {
                // $ 접두사를 사용하여 상태 변수에 대한 바인딩에 접근
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                /* List에서 정적 및 동적 View를 결합하거나 둘 이상의 서로 다른 동적 View 그룹을 결합하려면 데이터 컬렉션을 List에 전달하는 대신 ForEach 타입을 사용. Toggle을 추가하며 List에 전달하던 것을 수정함. */
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
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
                .environmentObject(ModelData())
        }
    }
}
