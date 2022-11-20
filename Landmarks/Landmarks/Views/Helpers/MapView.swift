//
//  MapView.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    /* @State attribute를 사용하여 둘 이상의 View에서 수정할 수 있는 앱의 데이터에 대한 source of truth를 설정할 수 있음. */
    @State private var region = MKCoordinateRegion()
    var body: some View {
        /* state 변수에 $를 접두사로 붙이면 underlying value에 대한 참조와 같은 바인딩이 전달됨. 사용자가 지도와 상호작용하면 지도는 현재 사용자 인터페이스에 표시되는 지도부분과 일치하도록 region 값을 업데이트함. */
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
