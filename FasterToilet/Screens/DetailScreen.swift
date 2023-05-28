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
    @State var floorImage:String = "HyeongNam_B1"
    
    @State var currentFloor:Int = -1
    
    func floorConverter(floor:Int)->String {
        if floor == -1 {
            return "B1"
        }
        return String(floor)
    }
    
    func floorImageConverter(buildingName:String, floor: Int)->String {
        if buildingName == "형남공학관" {
            return "HyeongNam_B1"
        }
        if buildingName == "정보과학관" {
            if floor < 2 {
                return "InfoScience_\(floorConverter(floor: floor))"
            }
            return "InfoScience_2"
        }
        if buildingName == "중앙도서관" {
            if floor <= 1 {
                return "Library_1"
            }
            return "Library_2"
        }
        return "에러"
    }
    
    
    
    init(building:Building) {
        self.building = building
        self.restrooms = building.restrooms
        self.floors = building.floors
        self.floorImage = floorImageConverter(buildingName: building.name, floor: currentFloor)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Group {
                    if floorImage != "에러" {
                        Image(floorImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.height/2-40)
                            .edgesIgnoringSafeArea(.all)
                            .background(Color(0xEFEFEF))
                        
                    } else {
                        Image(systemName: "error")
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack( alignment: .trailing, spacing: 0) {
                            Text(building.name)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 5)
                                .background(Color(0xD9D9D9))
                                .cornerRadius(10)
                            Text("추천 화장실 : 6충 B")
                                .padding(.vertical, 3)
                                .padding(.horizontal, 5)
                                .background(Color(0xD9D9D9))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        .padding(.trailing, 20)
                    }
                }
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
            
            VStack {
                List {
                    Section(header: Menu {
                        ForEach(floors, id:\.self) { floor in
                            Button(action: {
                                self.currentFloor = floor
                                floorImage =  floorImageConverter(buildingName: building.name, floor: currentFloor)
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
                        ForEach(restrooms, id: \.id) { restroom in
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
                    Image(systemName: "hand.thumbsup.fill")
                }
                .padding(.horizontal, 20)
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
        let category: String
        
        init(category:String) {
            self.category = category
        }
        
        var body:some View {
            Text(category)
                .font(.system(size: 12))
                .foregroundColor(primaryColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(primaryColor, lineWidth: 1)
                )
        }
    }
    
    init(restroom: Restroom) {
        self.restroom = restroom
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(restroom.extra ?? "임시")
                    .font(.system(size: 20))
                Text(restroom.location)
                    .font(.system(size: 14))
            }
            StarsView(rating: restroom.rating)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if restroom.bidet {
                        Categories(category: "비데")
                    }
                    if restroom.vanity {
                        Categories(category: "화장대")
                    }
                    if restroom.disabled {
                        Categories(category: "장애인 화장실")
                    }
                }
                .padding(.vertical, 1)
                .padding(.horizontal, 1)
            }
            
            .padding(.top, 5)
            
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let building = Building(id: 1547, name: "중앙도서관",floors: [-1,1,2,3,4], restrooms: [])
        
        
        return DetailScreen(building: building)
    }
}
