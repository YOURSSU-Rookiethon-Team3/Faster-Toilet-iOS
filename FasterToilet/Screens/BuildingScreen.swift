//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI
import Moya

struct BuildingScreen: View {
    @State var buildings:[Building] = [Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: []),Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: []),Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: [])]
    
    
    var body: some View{
        VStack {
            VStack {
                Image("toilet").resizable()
                    .frame(width: 80, height: 85)
                Text("어떤 화장실로 가고싶나요?")
                    .font(.title2)
                Text("가고싶은 건물을 클릭해주세요")
                    .font(.subheadline)
            }.padding(.bottom, 10)
            ZStack {
                Image("building_map")
                    .resizable()
                
                VStack {
                    Spacer()
                    NavigationLink(destination: FilterScreen()) {
                        CustomButton(title: "화장실 조건 추가")
                    }
                }
                
                NavigationLink(destination: DetailScreen(
                building: buildings[0])) {
                    CustomButton(title: "디테일 뷰")
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
                    let buildingService = BuildingService()
                    buildingService.getBuildings { [self] result in
                        switch result {
                        case .success(let buildingsResponse):
                            buildings = buildingsResponse.buildings
                            
                            print(buildingsResponse.buildings)
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                }
    }
}


struct BuildingScreen_Previews: PreviewProvider {
    static var previews: some View {
        BuildingScreen()
    }
}
