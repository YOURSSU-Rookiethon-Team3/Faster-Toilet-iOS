//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI

struct BuildingScreen: View {
    
    var body: some View{
        VStack {
            VStack {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 100)
                Text("어떤 화장실로 가고싶나요?")
                    .font(.title2)
                Text("가고싶은 건물을 클릭해주세요")
                    .font(.subheadline)
            }.padding(.bottom, 10)
            ZStack {
                Rectangle()
                    .foregroundColor(.cyan)
                    .frame(width: UIScreen.main.bounds.width, height: 400)
                VStack {
                    Spacer()
                    NavigationLink(destination: FilterScreen()) {
                        CustomButton(title: "화장실 조건 추가")
                    }
                }

                NavigationLink(destination: DetailScreen()) {
                    CustomButton(title: "디테일 뷰")
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
