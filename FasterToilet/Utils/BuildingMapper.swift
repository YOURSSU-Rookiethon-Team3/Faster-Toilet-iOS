//
//  BuildingMapper.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/28.
//

import Foundation

func floorConverter(floor:Int)->String {
    if floor == -1 {
        return "B1"
    }
    return String(floor)
}

func floorImageConverter(buildingName:String, floor: Int)->String {
    if buildingName == "형남공학관" {
        return "형남공학관_B1"
    }
    if buildingName == "정보과학관" {
        return "정보과학관_\( (floor < 2) ? floorConverter(floor: floor): "2")"
    }
    if buildingName == "중앙도서관" {
        return "중앙도서관_\( (floor == 1) ? 1 : 2 )"
    }
    return "에러"
}
