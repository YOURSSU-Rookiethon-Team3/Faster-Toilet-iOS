//
//  SplashScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import SwiftUI

struct SplashScreen: View {
    var body:some View {
        VStack(spacing: 10) {
            Image("poo")
                .resizable()
                .frame(width: 70, height: 60)
            
            Text("급할때 화장실")
                .font(.largeTitle)
            Text("지금까지 923명이 저에게 추천받았어요!")
                .foregroundColor(.gray)
                .font(.caption)
                .padding(.bottom, 30)
            
            NavigationLink(destination: BuildingScreen()) {
                CustomButton(title:"찾아보기")
            }
        }
    }
}
