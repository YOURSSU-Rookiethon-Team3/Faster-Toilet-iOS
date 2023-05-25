//
//  DetailScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import SwiftUI

struct DetailScreen: View {
    var restrooms:[RestroomDTO] = []
    struct ToiletComponent:View {
        let restroom : RestroomDTO
        
        init(restroom: RestroomDTO) {
            self.restroom = restroom
        }
        
        var body: some View {
            VStack {
                HStack {
                    Text(restroom.extra)
                    Text(restroom.location)
                }
                StarsView(rating: restroom.rating)
            }
        }
    }
    
    init() {
        restrooms.append(RestroomDTO.init(id: 50, location: "엘리베이터옆", isMale: true, rating: 5, congestion: 3, vanity: true, bidet: false, disabled: false, extra: "무야호", buildings: [], createdAt: "15465"))
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            List {
                ToiletComponent(restroom: restrooms[0])
            }
        }
    }
}
