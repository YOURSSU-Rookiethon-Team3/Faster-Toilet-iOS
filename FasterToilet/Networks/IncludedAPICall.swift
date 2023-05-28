//
//  IncludedAPICall.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/28.
//

import Foundation
import Moya

// 1. API 엔드포인트를 설정하는 enum 생성
enum BuildingsAPI {
    case getBuildings
}

extension BuildingsAPI: TargetType {
    var baseURL: URL { return URL(string: "https://yourssu-faster-toilet-api.hyuns.dev")! }
    
    var path: String {
        switch self {
        case .getBuildings:
            return "/buildings"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBuildings:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getBuildings:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}

// Building and Restroom struct are as you defined

// New struct for the response
struct BuildingsResponse: Codable {
    let buildings: [Building]
}

class BuildingService {
    let provider = MoyaProvider<BuildingsAPI>()

    func getBuildings(completion: @escaping (Result<BuildingsResponse, Error>) -> Void) {
        provider.request(.getBuildings) { result in
            switch result {
            case let .success(response):
                do {
                    let buildingsResponse = try JSONDecoder().decode(BuildingsResponse.self, from: response.data)
                    completion(.success(buildingsResponse))
                } catch {
                    completion(.failure(error))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
