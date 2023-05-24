//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI

struct BuildingScreen: View {
    func filterButton() -> some View {
        Button {
            
        } label: {
            VStack {
                Image(systemName: "slider.horizontal.3")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                Text("화장실 조건 추가")
                    .font(.caption2)
                    .foregroundColor(.black)
            }
        }
    }
    
    
    var body: some View{
        VStack(alignment: .leading) {
            ZStack(alignment: .center) {
                VStack {
                    HStack {
                        Spacer()
                        filterButton()
                    }
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 100)
                    Text("어떤 화장실로 가고싶나요?")
                        .font(.title2)
                    Text("가고싶은 건물을 클릭해주세요")
                        .font(.subheadline)
                    
                }
            }.frame(height: 200)
            ZStack {
                Rectangle()
                    .foregroundColor(.cyan)
                    .frame(width: UIScreen.main.bounds.width, height: 400)
                Button{} label: {
                    Text("화장실 조건 추가")
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
