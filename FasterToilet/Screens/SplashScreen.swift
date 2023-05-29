//
//  SplashScreen.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import SwiftUI
import Moya

struct SplashScreen: View {
    @State var count:Int = 0
    @State var isLoading: Bool = true
    
    var body:some View {
        VStack(spacing: 10) {
            Image("poo")
                .resizable()
                .frame(width: 70, height: 60)
            
            Text("급할때 화장실")
                .font(.largeTitle)
            Group {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    Text("지금까지 \(count)명이 저에게 추천받았어요!")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.bottom, 30)
                }
            }
            
            
//            Button(action: {
//
////                let deviceId = UIDevice.current.identifierForVendor?.uuidString
////                print(deviceId)
//            }) {
//                Text("버튼")
//            }
            
            NavigationLink(destination: BuildingScreen()) {
                CustomButton(title:"찾아보기")
            }
            
        }
        .onAppear {
            let provider = MoyaProvider<CountAPI>()
            isLoading = true
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            
            let request = CountAPI.sendVisitorCount(visitorToken: deviceId ?? "")
            provider.request(request) { result in
                switch result {
                case .success(let response):
                    do {
                        let visitorsResponse = try response.map(VisitorsResponse.self)
                        count = visitorsResponse.visitorsCount
                    } catch {
                        print("Error parsing response: \(error)")
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                }
                
                isLoading = false

            }
        }
    }
}


