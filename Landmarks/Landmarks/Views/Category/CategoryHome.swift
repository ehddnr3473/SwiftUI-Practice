//
//  CategoryHome.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/24.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            List {
                // 즐겨찾기 한 랜드마크 사진
                // PageView는 UIKit 및 SwiftUI 뷰와 컨트롤러가 함께 작동하는 방법을 보여줌.
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            // toolbar modifier를 사용하여 내비게이션 바에 버튼을 추가
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            // toolbar button을 탭할 때 @State var인 showingProfile의 값이 바뀌면
            // ProfileHost 뷰에 대한 sheet를 띄움.
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
