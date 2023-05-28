//
//  Building.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import Foundation

// MARK: - Building
struct Building: Codable {
    let id:Int
    let name:String
    let floors:[Int]
    let restrooms: [Restroom]
}
