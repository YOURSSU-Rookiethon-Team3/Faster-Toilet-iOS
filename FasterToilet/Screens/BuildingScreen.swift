//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI
import Moya

struct BuildingScreen: View {
    @State private var buildings:[Building] = [Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: []),Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: []),Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: [])]
    
    @State private var restrooms:[Restroom] = []
    @State private var isInit = true
    
    @State private var filteredRestrooms:[Restroom] = []
    @State private var cleanValue: Double = 1
    @State private var congestionValue: Double = 1
    @State private var isShowerSelected :Bool = false
    @State private var isBidetSelected :Bool = false
    @State private var isDisableSelected: Bool = false
    @State private var isVanitySelected: Bool = false
    
    var body: some View{
        GeometryReader {geometry in
        VStack {
            VStack {
                Image("toilet").resizable()
                    .frame(width: geometry.size.width * 0.21,height: geometry.size.height * 0.12)
                Text("어떤 화장실로 가고싶나요?")
                    .font(.title2)
                Text("가고싶은 건물을 클릭해주세요")
                    .font(.subheadline)
            }.padding(.bottom, 10)
            
            ZStack {
                Image("building_map")
                    .resizable()
                    .frame(width: geometry.size.width)
                
                VStack(spacing: geometry.size.height * 0.05) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.white.opacity(0.5))
                            .frame(width: 145, height: 112)
                            .offset(x: 100, y:-60)
                        Text("중앙도서관")
                            .offset(x: 100, y: -90)
                        HStack{
                            Image("star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:105, y:-70)
                            Text("4.0")
                                .offset(x:100, y:-70)
                            Text("/")
                                .offset(x:100, y:-70)
                            Image("stoilet")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:100, y:-70)
                            Text("4.0")
                                .offset(x:95, y:-70)
                            
                            
                        }
                        CustomButton1(title: "이동하기   ")
                            .offset(x:100, y:-40)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.white.opacity(0.5))
                            .frame(width: 145, height: 112)
                            .offset(x: -30, y: -50)
                        Text("형남공학관")
                            .offset(x: -30, y: -80)
                        HStack{
                            Image("star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:-25, y:-60)
                            Text("4.0")
                                .offset(x:-30, y:-60)
                            Text("/")
                                .offset(x:-30, y:-60)
                            Image("stoilet")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:-30, y:-60)
                            Text("4.0")
                                .offset(x:-35, y:-60)
                        }
                        CustomButton2(title: "이동하기   ")
                            .offset(x:-30, y:-30)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.white.opacity(0.5))
                            .frame(width: 145, height: 112)
                            .offset(x: 80, y: 0)
                        Text("정보과학관")
                            .offset(x: 80, y: -30)
                        HStack{
                            Image("star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:85, y:-10)
                            Text("4.0")
                                .offset(x:80, y:-10)
                            Text("/")
                                .offset(x:80, y:-10)
                            Image("stoilet")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x:80, y:-10)
                            Text("4.0")
                                .offset(x:75, y:-10)
                        }
                        CustomButton3(title: "이동하기   ")
                            .offset(x:80, y:20)
                    }
                }
                .frame(width: geometry.size.width)
                
                
                VStack {
                    Spacer()
                    NavigationLink(destination: FilterScreen(restrooms: self.restrooms, filteredRestrooms: $filteredRestrooms, cleanValue: $cleanValue, congestionValue: $congestionValue, isShowerSelected: $isShowerSelected, isBidetSelected: $isBidetSelected, isDisableSelected: $isDisableSelected, isVanitySelected: $isVanitySelected)) {
                        CustomButton(title: "화장실 조건 추가")
                    }
                }
            }
                
                NavigationLink(destination: DetailScreen(
                building: buildings[2])) {
                    CustomButton(title: "디테일 뷰")
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
            if isInit {
                let buildingService = BuildingService()
                buildingService.getBuildings { [self] result in
                    switch result {
                    case .success(let buildingsResponse):
                        self.buildings = buildingsResponse.buildings
                        self.restrooms = []
                        
                        for building in self.buildings {
                            self.restrooms = self.restrooms + building.restrooms
                        }
                        self.filteredRestrooms = self.restrooms
                        
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
                isInit = false
            }
        }
                    
    }
    
}


struct CustomButton0: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // 버튼이 클릭되었을 때 수행할 액션
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
}
struct CustomButton1: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // 버튼이 클릭되었을 때 수행할 액션
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .frame(width: 100, height: 30)
                .cornerRadius(20)
        }
    }
}
struct CustomButton2: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // 버튼이 클릭되었을 때 수행할 액션
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .frame(width: 100, height: 30)
                .cornerRadius(20)
        }
    }
}
struct CustomButton3: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // 버튼이 클릭되었을 때 수행할 액션
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .frame(width: 100, height: 30)
                .cornerRadius(20)
        }
    }
}

struct BuildingScreen_Previews: PreviewProvider {
    static var previews: some View {
        BuildingScreen()
    }
}
