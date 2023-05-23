//
//  BuildingScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/23.
//

import SwiftUI

struct BuildingScreen:View {
    func filterButton() -> some View {
        VStack {
            Image(systemName: "minus")
        }
    }
    
    var body: some View{
        VStack {
            filterButton()
            Image(systemName: "plus")
        }
        .navigationBarHidden(true)
    }
}
