//
//  ContentView.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Combine Views Using Stacks.
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            // default alignment: .center
            VStack(alignment: .leading) {
                Text("Tutle Rock")
                    .font(.title)
                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }
                // view modifier
                // HStack 내의 Views에게 공통으로 적용됨.
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About Turtle Rock")
                    .font(.title2)
                Text("Descriptive text goes here.")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
