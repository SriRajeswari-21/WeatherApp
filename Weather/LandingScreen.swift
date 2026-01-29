//
//  LandingScreen.swift
//  Weather
//
//  Created by rentamac on 1/22/26.
//

import Foundation
import SwiftUI

struct LandingScreen: View {
    var body: some View {
       VStack {
            Spacer()
           Image("Umbrella")   // your asset image name
               .resizable()
               .scaledToFit()
               .frame(width: 1200, height: 200)
           Text("Breeze")
                           .font(.largeTitle)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
           Text("Weather App")
                          .foregroundColor(.white.opacity(0.8))

                      Spacer()
        NavigationLink(destination: CityListView()) {
                           Image(systemName: "arrow.right")
                               .font(.title)
                               .foregroundColor(.white)
                               .padding()
                               .background(Color.blue)
                               .clipShape(Circle())
                      }

                       Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BGcolor"))
            .ignoresSafeArea()

    }
}
#Preview {
    NavigationStack {
            LandingScreen()
        }
}
