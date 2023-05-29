//
//  CategoryMapper.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/29.
//

import Foundation

func categoryTranslater(category:String) -> String {
    if category == "vanity" {
        return "화장대"
    }
    if category == "bidet" {
        return "비데"
    }
    if category == "disabled" {
        return "장애인 화장실"
    }
    return ""
}
