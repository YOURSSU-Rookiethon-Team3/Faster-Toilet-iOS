//
//  SplashScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import SwiftUI

struct SplashScreen: View {
    var body:some View {
        VStack(spacing: 20){
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
            
            Text("급할때 화장실")
                .font(.largeTitle)
            Text("지금까지 923명이 저에게 추천받았어요!")
                .padding(.bottom, 30)
            
            NavigationLink(destination: BuildingScreen()) {
                Text("찾아보기")
                    .foregroundColor(.white)
                    .frame(width: 160, height: 40)
                    .background(Color.blue)
                    .cornerRadius(50)
            }
            
        }
    }
}
