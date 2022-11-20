//
//  CircleImage.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/19.
//

import SwiftUI

// Custom ImageView
struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            // overlay(): View를 덮음.
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
