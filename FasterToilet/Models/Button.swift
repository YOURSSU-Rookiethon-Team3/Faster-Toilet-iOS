//
//  Toilet.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import SwiftUI

struct CustomButton: View{
    let size: CGFloat
    let title: String
    let width: CGFloat
    let height: CGFloat
    
    init(title:String, size:CGFloat = 15, width:CGFloat = 150, height:CGFloat = 40) {
        self.title = title
        self.size = size
        self.width = width
        self.height = height
    }
    
    var body:some View {
        Text(title)
            .font(.system(size: size))
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .background(Color(0x1650A7))
            .cornerRadius(50)
    }
}
