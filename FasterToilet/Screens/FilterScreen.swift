//
//  FilterScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/24.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.dismiss) var dismiss
    @Binding private var cleanValue: Double
    @Binding private var congestionValue: Double
    @Binding private var isShowerSelected :Bool
    @Binding private var isBidetSelected :Bool
    @Binding private var isDisableSelected: Bool
    @Binding private var isVanitySelected: Bool
    
    private var restrooms:[Restroom]
    @Binding private var filteredRestrooms:[Restroom]
    
    init(restrooms:[Restroom], filteredRestrooms:Binding<[Restroom]>, cleanValue:Binding<Double>, congestionValue:Binding<Double>, isShowerSelected:Binding<Bool>,isBidetSelected:Binding<Bool>,isDisableSelected:Binding<Bool>,isVanitySelected:Binding<Bool>) {
        self.restrooms = restrooms
        self._filteredRestrooms = filteredRestrooms
        self._cleanValue = cleanValue
        self._congestionValue = congestionValue
        self._isShowerSelected = isShowerSelected
        self._isBidetSelected = isBidetSelected
        self._isDisableSelected = isDisableSelected
        self._isVanitySelected = isVanitySelected
    }
    
    
    
    func filterCategory() {
        self.filteredRestrooms = self.restrooms
        
        if !isShowerSelected && !isBidetSelected && !isDisableSelected && !isVanitySelected && cleanValue == 1 && congestionValue == 1 {
            return
        }
        
        self.filteredRestrooms = []
        
        if congestionValue == 2 {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter{ $0.congestion > 3 }
        } else if congestionValue == 1 {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter{ $0.congestion > 2 }
        } else {
            self.filteredRestrooms = self.restrooms
        }
        
        if !isShowerSelected && !isBidetSelected && !isDisableSelected && !isVanitySelected {
            return
        }
        
        if isShowerSelected {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter { $0.facilities.contains("shower") }
        }
        if isBidetSelected {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter{ $0.bidet }
        }
        if isDisableSelected {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter{ $0.disabled }
        }
        if isVanitySelected {
            self.filteredRestrooms = self.filteredRestrooms + self.restrooms.filter{ $0.vanity }
        }
        var restroomIds:[Int] = []
        var tempRestrooms:[Restroom] = []
        for restroom in filteredRestrooms {
            if !restroomIds.contains(restroom.id) {
                tempRestrooms.append(restroom)
                restroomIds.append(restroom.id)
            }
        }
        self.filteredRestrooms = tempRestrooms
    }
    
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
                Image("Smiling")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("원하는 화장실 조건을 추가해볼까요?")
                    .font(.title2)
                
                VStack {
                    Divider()
                    Text("청결도")
                        .font(.title3)
                    Slider(value: $cleanValue, in: 0...2, step: 1)
                        .onChange(of: cleanValue) { newValue in
                            cleanValue = round(newValue)
                            filterCategory()
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
                            filterCategory()
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
                            filterCategory()
                        }) {
                            CustomButton(title:"샤워실", isSelected: isShowerSelected)
                        }
                        Spacer()
                        Button( action: {
                            isBidetSelected.toggle()
                            filterCategory()
                        }) {
                            CustomButton(title: "비데", isSelected: isBidetSelected)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action:{
                            isDisableSelected.toggle()
                            filterCategory()
                        }) {
                            CustomButton(title:"장애인 화장실", isSelected: isDisableSelected)
                        }
                        Spacer()
                        Button(action:{
                            isVanitySelected.toggle()
                            filterCategory()
                        }) {
                            CustomButton(title:"화장대", isSelected: isVanitySelected)
                        }
                        Spacer()
                    }
                }
                
                HStack(spacing: 0) {
                    Text("조건에 해당하는 ")
                        .font(.caption)
                    Text("화장실이 \(filteredRestrooms.count)개")
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
                        self.filteredRestrooms = self.restrooms
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
        FilterScreen(restrooms: [], filteredRestrooms: .constant([]), cleanValue: .constant(1), congestionValue: .constant(1), isShowerSelected: .constant(false), isBidetSelected: .constant(false), isDisableSelected: .constant(false), isVanitySelected: .constant(false))
    }
}
