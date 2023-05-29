//
//  EmptyData.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/29.
//

import Foundation

let emptyRestroom:Restroom = Restroom(id: 0, floor: 0, alias: "", location: "", isMale: true, rating: 4, congestion: 4, vanity: true, bidet: true, disabled: true, extra: "", createdAt: "", facilities: [])

let emptyBuilding = Building(id: 50, name: "형남", floors: [-1,1,2], restrooms: [], recommendRestroom: emptyRestroom)
