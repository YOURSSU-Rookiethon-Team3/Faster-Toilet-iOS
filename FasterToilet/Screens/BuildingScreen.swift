//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI
import Moya

struct BuildingScreen: View {
    @State private var buildings:[Building] = [emptyBuilding,emptyBuilding,emptyBuilding]
    
    @State private var restrooms:[Restroom] = []
    @State private var isInit = true
    
    @State private var filteredRestrooms:[Restroom] = []
    @State private var cleanValue: Double = 1
    @State private var congestionValue: Double = 1
    @State private var isShowerSelected :Bool = false
    @State private var isBidetSelected :Bool = false
    @State private var isDisableSelected: Bool = false
    @State private var isVanitySelected: Bool = false
    
    @State private var libraryCount:Int = 0
    @State private var libraryRating:Double = 0.0
    @State private var hyeongnamCount:Int = 0
    @State private var hyeongnamRating:Double = 0.0
    @State private var infoscienceCount:Int = 0
    @State private var infoscienceRating:Double = 0.0
    
    func filterRestroomsInBuilding(buildingName:String, restrooms:[Restroom]) -> [Restroom] {
        return restrooms.filter{ $0.buildingName == buildingName}
    }
    
    func averageCalculator(buildingName: String, restrooms: [Restroom]) -> Double {
        let filteredList = filterRestroomsInBuilding(buildingName: buildingName, restrooms: restrooms)
        let count = filteredList.count
        let sum = filteredList.reduce(0) { $0 + $1.rating }
        
        return count > 0 ? sum / Double(count) : 0
    }

    func restroomCounter(buildingName: String, restrooms: [Restroom]) -> Int {
        let filteredCount = filterRestroomsInBuilding(buildingName: buildingName, restrooms: restrooms).count
        return filteredCount
    }
    
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
                                .background(Color.white.opacity(0.8))
                                .frame(width: 145, height: 100)
                                .offset(x: 100, y:-60)
                            Text("중앙도서관")
                                .offset(x: 100, y: -90)
                            HStack(alignment: .center){
                                Image("star")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:105, y:-70)
                                Text(String(averageCalculator(buildingName: "중앙도서관", restrooms: self.filteredRestrooms)))
                                    .offset(x:100, y:-70)
                                Text("/")
                                    .offset(x:100, y:-70)
                                Image("stoilet")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:100, y:-70)
                                Text(String(restroomCounter(buildingName: "중앙도서관", restrooms:self.filteredRestrooms)))
                                    .offset(x:95, y:-70)
                            }
                            
                            NavigationLink(destination: DetailScreen(
                                building: buildings.first(where: { $0.name == "중앙도서관" }) ?? emptyBuilding )) {
                                    CustomButton(title: "이동하기", width: 100, height:30)
                                }.offset(x:100, y:-40)
                            
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                                .background(Color.white.opacity(0.8))
                                .frame(width: 145, height: 100)
                                .offset(x: -30, y: -50)
                            Text("형남공학관")
                                .offset(x: -30, y: -80)
                            HStack{
                                Image("star")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:-25, y:-60)
                                                                
                                Text(String(averageCalculator(buildingName: "형남공학관", restrooms: self.filteredRestrooms)))
                                    .offset(x:-30, y:-60)
                                Text("/")
                                    .offset(x:-30, y:-60)
                                Image("stoilet")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:-30, y:-60)
                                Text(String(restroomCounter(buildingName: "형남공학관", restrooms:self.filteredRestrooms)))
                                    .offset(x:-35, y:-60)
                            }
                            NavigationLink(destination: DetailScreen(
                                building: buildings.first(where: { $0.name == "형남공학관" }) ?? emptyBuilding )) {
                                    CustomButton(title: "이동하기", width: 100, height:30)
                                }.offset(x:-30, y:-30)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                                .background(Color.white.opacity(0.8))
                                .frame(width: 145, height: 100)
                                .offset(x: 80, y: 0)
                            Text("정보과학관")
                                .offset(x: 80, y: -30)
                            HStack{
                                Image("star")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:85, y:-10)
                                Text(String(averageCalculator(buildingName: "정보과학관", restrooms: self.filteredRestrooms)))
                                    .offset(x:80, y:-10)
                                Text("/")
                                    .offset(x:80, y:-10)
                                Image("stoilet")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(x:80, y:-10)
                                Text(String(restroomCounter(buildingName: "정보과학관", restrooms:self.filteredRestrooms)))
                                    .offset(x:75, y:-10)
                            }
                            NavigationLink(destination: DetailScreen(
                                building: buildings.first(where: { $0.name == "정보과학관" }) ?? emptyBuilding )) {
                                    CustomButton(title: "이동하기", width: 100, height:30)
                                }.offset(x:80, y:20)
                        }
                    }
                    .frame(width: geometry.size.width)
                    
                    
                    VStack {
                        Spacer()
                        NavigationLink(destination: FilterScreen(restrooms: self.restrooms, filteredRestrooms: $filteredRestrooms, cleanValue: $cleanValue, congestionValue: $congestionValue, isShowerSelected: $isShowerSelected, isBidetSelected: $isBidetSelected, isDisableSelected: $isDisableSelected, isVanitySelected: $isVanitySelected)) {
                            CustomButton(title: "화장실 조건 추가")
                        }.padding(.bottom, 10)
                    }
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
                            var modifiedRestrooms = building.restrooms
                            for index in modifiedRestrooms.indices {
                                modifiedRestrooms[index].buildingName = building.name
                            }
                            self.restrooms.append(contentsOf: modifiedRestrooms)
                        }
                        
                        for building in self.buildings {
                            self.restrooms = self.restrooms + building.restrooms
                        }
                        self.filteredRestrooms = self.restrooms
                        
                        self.libraryCount = restroomCounter(buildingName: "중앙도서관", restrooms: self.restrooms)
                        self.libraryRating = averageCalculator(buildingName: "중앙도서관", restrooms: self.restrooms)
                        self.hyeongnamCount = restroomCounter(buildingName: "형남공학관", restrooms: self.restrooms)
                        self.hyeongnamRating = averageCalculator(buildingName: "형남공학관", restrooms: self.restrooms)
                        self.infoscienceCount = restroomCounter(buildingName: "정보과학관", restrooms: self.restrooms)
                        self.infoscienceRating = averageCalculator(buildingName: "정보과학관", restrooms: self.restrooms)
                        
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
                isInit = false
            }
        }
        
    }
    
}

struct BuildingScreen_Previews: PreviewProvider {
    static var previews: some View {
        BuildingScreen()
    }
}
