//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI
import Moya

struct BuildingScreen: View {
    var building:Building
    var restrooms:[Restroom] = []
    @State var buildings:[Building] = []
    
    init() {
        restrooms.append(Restroom.init(id: 50,floor: 4, location: "엘리베이터옆", isMale: true, rating: 5, congestion: 3, vanity: true, bidet: false, disabled: false, extra: "무야호", buildings: [], createdAt: "15465"))
        restrooms.append(Restroom.init(id: 40,floor: 4, location: "엘리베이터옆", isMale: true, rating: 5, congestion: 3, vanity: true, bidet: false, disabled: false, extra: "무야호", buildings: [], createdAt: "15465"))
        restrooms.append(Restroom.init(id: 20,floor: 4, location: "엘리베이터옆", isMale: true, rating: 5, congestion: 3, vanity: true, bidet: false, disabled: false, extra: "무야호", buildings: [], createdAt: "15465"))
        restrooms.append(Restroom.init(id: 10,floor: 4, location: "엘리베이터옆", isMale: true, rating: 5, congestion: 3, vanity: true, bidet: false, disabled: false, extra: "무야호", buildings: [], createdAt: "15465"))
        building = Building.init(id: 1547, name: "정보과학관",floors: [-1,1,2,3,4] , restrooms: restrooms)
        
        
    }
    
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

                NavigationLink(destination: DetailScreen(
                building: building)) {
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
