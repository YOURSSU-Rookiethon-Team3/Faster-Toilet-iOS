//
//  Restroom.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

import SwiftUI
import Moya

struct RestroomDTO: Codable {
    let id: Int
    let location: String
    let isMale: Bool
    let rating: Float
    let congestion: Int
    let vanity: Bool
    let bidet: Bool
    let disabled: Bool
    let extra: String
    let buildings: [BuildingDTO]
    let createdAt: String
}

enum MyAPI {
    case getUsers
    // Add more cases for other API endpoints
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
