/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

// slide를 static property로 추출
// view의 transition modifier에서 새로운 property에 액세스할 수 있음.
// 추후 custom transition을 확장할 때 코드가 깨끗하게 유지됨.
extension AnyTransition {
    static var moveAndFade: AnyTransition {
//        AnyTransition.slide
//        AnyTransition.move(edge: .trailing)
        
        // asymmetric() modifier를 사용하여 view가 나타나고 사라질 때
        // 비대칭적으로 또는 다양한 전환을 제공할 수 있음.
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = true

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    // 함수에 대한 호출을 wrap
                    // 다음과 같이 Animation with delay 가능
//                    withAnimation(.easeInOut(duration: 4)) {
//                        showDetail.toggle()
//                    }
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        // 아래의 코드를 통해 rotationEffect()에 대한 애니메이션을 끌 수 있음.
//                        .animation(nil, value: showDetail)
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                        // equatable view에서 animation(_:) modifier를 사용할 때 SwiftUI는
                        // view의 애니메이션 가능한 properties에 대한 모든 변경 사항을 애니메이션화할 수 있음.
                        // view의 색상(color), 불투명도(opacity), 회전(rotation), 크기(size) 및 기타 properties는 모두 애니메이션 가능
                        // view가 equatable하지 않은 경우 animation(_:value:) modifier를 사용하여
                        // 지정된 값이 변경될 때 애니메이션을 시작할 수 있음.
                        
                        // 애니메이션 속도를 조정하거나 시작되기 전에 delay를 지정하거나 애니메이션이 반복되도록 지정할 수 있음.
//                        .animation(.spring(), value: showDetail)
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    // 기본적으로 view는 fading in and out으로 전환
                    // transition(_:) modifier를 사용하여 transition을 custom할 수 있음.
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikes[0])
                .padding()
            Spacer()
        }
    }
}
