//
//  ContentView.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        setupDefaultFont()
    }
    
    @State var isLoading:Bool = true
    var body: some View {
        NavigationStack {
            SplashScreen()
        }.background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
