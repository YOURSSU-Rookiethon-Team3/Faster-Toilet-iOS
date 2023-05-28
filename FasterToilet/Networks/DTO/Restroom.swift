//
//  Restroom.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import SwiftUI
import Moya

struct Restroom: Codable {
    let id: Int
    let floor: Int
    let location: String
    let isMale: Bool
    let rating: Float
    let congestion: Int
    let vanity: Bool
    let bidet: Bool
    let disabled: Bool
    let extra: String?
    let building: Building?
    let createdAt: String
    let facilities: [String]
}
