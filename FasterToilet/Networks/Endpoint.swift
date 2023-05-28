//
//  Endpoint.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/25.
//

enum URLConst {
    // MARK: - baseURL
    static let base = "https://yourssu-faster-toilet-api.hyuns.dev"

    // MARK: - Building
    // 건물 리스트 조회
    static let queryBuilding = "/buildings"
    
    // 건물의 화장실 조회
    static let queryRestroomInBuilding = "/auth/sign-up"
    
    // MARK: - Restroom
    // 화장실 조회
    static let queryRestrooms = "/restrooms"
    
    // MARK: - Visitor
    // 방문자 수 조회
    static let queryVisitor = "/visitors"
    
}
