//
//  Building.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import Foundation

struct BuildingDTO: Codable {
    let id:Int
    let name:String
    let restrooms: [RestroomDTO]
}
