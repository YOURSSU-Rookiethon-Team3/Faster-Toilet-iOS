//
//  DetailScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import SwiftUI

struct DetailScreen: View {
    @Environment(\.dismiss) var dismiss
    var building:Building
    var restrooms:[Restroom] = []
    var floors:[Int]=[]
    
    @State var floorImage:String = "형남공학관_B1"
    @State var currentFloor:Int = 1
    @State var currentRestrooms:[Restroom] = []
    
    
    init(building:Building) {
        self.building = building
        self.restrooms = building.restrooms
        self.floors = building.floors
        self._floorImage = State(initialValue: floorImageConverter(buildingName: building.name, floor: currentFloor))
        self._currentFloor = State<Int>(initialValue: 1)
        self._currentRestrooms = State<[Restroom]>(initialValue: restrooms.filter { $0.floor == currentFloor })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Group {
                    if floorImage != "에러" {
                        Image(floorImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                            .background(Color(0xEFEFEF))
                        
                    } else {
                        Image(systemName: "error")
                    }
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 0) {
                            Text(building.name)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 5)
                                .background(Color(0xD9D9D9))
                                .cornerRadius(10)
                            Text("추천 화장실 : \(floorConverter(floor:building.recommendRestroom.floor))층 \(building.recommendRestroom.alias ?? "A")")
                                .padding(.vertical, 3)
                                .padding(.horizontal, 5)
                                .background(Color(0xD9D9D9))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        .onTapGesture {
                            currentFloor = building.recommendRestroom.floor
                            floorImage =  floorImageConverter(buildingName: building.name, floor: currentFloor)
                            self.currentRestrooms = restrooms.filter { $0.floor == currentFloor
                            }
                        }
                        
                    }
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }.padding()
                        Spacer()
                    }
                    Spacer()
                }
            }
            .background(Color(0xEFEFEF))
            
            VStack {
                List {
                    Section(header: Menu {
                        ForEach(floors, id:\.self) { floor in
                            Button(action: {
                                self.currentFloor = floor
                                floorImage =  floorImageConverter(buildingName: building.name, floor: currentFloor)
                                self.currentRestrooms = restrooms.filter { $0.floor == floor
                                }
                            }, label: {Text("\(floorConverter(floor:floor))층")})
                        }
                    } label: {
                        Label(title:{
                            Text("\(floorConverter(floor:currentFloor))층")
                                .font(.system(size:30))
                                .foregroundColor(textColor)
                        }, icon: {Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(textColor)
                            .padding(.horizontal, 10)})
                    }) {
                        ForEach(currentRestrooms, id: \.id) { restroom in
                            ToiletComponent(restroom: restroom)
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                .background(
                    Color.white
                        .shadow(color: Color.gray, radius: 3, x: 0, y: 0)
                        .mask(Rectangle().padding(.top, -10))
                )
                
                HStack {
                    VStack(alignment: .leading ,spacing: 0) {
                        Text("해결 되셨나요? 식사 메뉴 고민은")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        HStack(spacing: 0) {
                            Text("숨쉴때뭐먹지")
                                .foregroundColor(primaryColor)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("로 해결해보세요!")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                        HStack(alignment: .center) {
                            Text("자세히 보기")
                                .foregroundColor(Color(0x555555))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 7, height: 10)
                                .foregroundColor(Color(0x5F5F5F))
                        }.padding(.top, 5)
                    }
                    Spacer()
                    Image("따봉")
                        .frame(height: 40)
                }
                .onTapGesture {
                    if let url = URL(string: "https://eat.soomsil.de/") {
                        UIApplication.shared.open(url)
                    }
                }
                .padding(.leading, 20)
                .padding(.vertical, 5)
                .background(Color(0xE9E9E9))
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ToiletComponent:View {
    let restroom : Restroom
    
    struct Categories: View {
        private let category: String
        private let nothing: Bool
        
        init(category:String) {
            if category == "" {
                self.category = "기타시설 없음"
                nothing = true
            } else {
                self.category = category
                nothing = false
            }
        }
        
        var body:some View {
            Text(category)
                .font(.system(size: 12))
                .foregroundColor(primaryColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke( (nothing) ? Color(0x535353) : primaryColor, lineWidth: 1)
                )
        }
    }
    
    init(restroom: Restroom) {
        self.restroom = restroom
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(restroom.alias ?? "A") 화장실")
                    .font(.system(size: 20))
                Text("\(restroom.location) ")
                    .font(.system(size: 14))
                // TODO 남자/여자 화장실 구분
//                Text("\((restroom.isMale) ? "남자화장실" : "여자화장실")")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
            }
            StarsView(rating: restroom.rating)
            if !restroom.facilities.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if restroom.facilities.isEmpty {
                            Categories(category: "")
                        } else {
                            ForEach(restroom.facilities, id:\.self) { facility in
                                Categories(category: categoryTranslater(category: facility))
                            }
                        }
                    }
                    .padding(.vertical, 1)
                    .padding(.horizontal, 1)
                }
                .padding(.top, 5)
            }
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let restrooms:[Restroom] = []
                
        let building = Building(id: 1547, name: "중앙도서관",floors: [-1,1,2,3,4], restrooms: restrooms, recommendRestroom: emptyRestroom)
        
        return DetailScreen(building: building)
    }
}
