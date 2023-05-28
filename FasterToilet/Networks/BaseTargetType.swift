//
//  BaseTargetType.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/28.
//

import Foundation
import Moya

protocol BaseTargetType:TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: URLConst.base)!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer "
        ]
        return header
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
