//
//  FilterScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/24.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var cleanValue: Double = 1
    @State private var congestionValue: Double = 1
    @State private var isShowerSelected :Bool = false
    @State private var isBidetSelected :Bool = false
    @State private var isDisableSelected: Bool = false
    @State private var isVanitySelected: Bool = false
    @State private var toiletCount: Int = 7
    
    var body: some View {
        ScrollView() {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                            .foregroundColor(.black)
                    }
                }
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.brown)
                Text("원하는 화장실 조건을 추가해볼까요?")
                    .font(.title2)
                
                VStack {
                    Divider()
                    Text("청결도")
                        .font(.title3)
                    Slider(value: $cleanValue, in: 0...2, step: 1)
                        .onChange(of: cleanValue) { newValue in
                            cleanValue = round(newValue)
                        }.padding(.horizontal, 20)
                    HStack {
                        Text("상관없음")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("보통")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("중요함")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                    }.padding(.horizontal, 10)
                }
                
                VStack {
                    Divider()
                    Text("혼잡도")
                        .font(.title3)
                    Slider(value: $congestionValue, in: 0...2, step: 1)
                        .onChange(of: congestionValue) { newValue in
                            congestionValue = round(newValue)
                        }.padding(.horizontal, 20)
                    HStack {
                        Text("상관없음")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("보통")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("중요함")
                            .font(.system(size: 14))
                            .frame(width: 60, alignment: .center)
                    }.padding(.horizontal, 10)
                }
                
                VStack {
                    Divider()
                    Text("부가 시설")
                        .font(.title3)
                    HStack {
                        Spacer()
                        Button(action:{
                            isShowerSelected.toggle()
                        }) {
                            CustomButton(title:"샤워실", isSelected: isShowerSelected)
                        }
                        Spacer()
                        Button( action: {
                            isBidetSelected.toggle()
                        }) {
                            CustomButton(title: "비데", isSelected: isBidetSelected)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action:{
                            isDisableSelected.toggle()
                        }) {
                            CustomButton(title:"장애인 화장실", isSelected: isDisableSelected)
                        }
                        Spacer()
                        Button(action:{
                            isVanitySelected.toggle()
                        }) {
                            CustomButton(title:"화장대", isSelected: isVanitySelected)
                        }
                        Spacer()
                    }
                }
                
                HStack(spacing: 0) {
                    Text("조건에 해당하는 ")
                        .font(.caption)
                    Text("화장실이 \(toiletCount)개")
                        .font(.caption)
                        .fontWeight(.heavy)
                    Text(" 있습니다")
                        .font(.caption)
                }.padding(.vertical, 20)
                
                HStack {
                    Spacer()
                    Button(action:{
                        cleanValue = 1
                        congestionValue = 1
                        isShowerSelected = false
                        isBidetSelected = false
                        isDisableSelected = false
                        isVanitySelected = false
                    }) {
                        Text("옵션 초기화")
                            .foregroundColor(.blue)
                            .underline(true)
                    }
                    Spacer()
                    Button(action: {
                        // TODO 조건 변경해서 적용하기
                        dismiss()
                    }) {
                        Text("적용하기")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color(0x1650A7))
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                Spacer()
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen()
    }
}
