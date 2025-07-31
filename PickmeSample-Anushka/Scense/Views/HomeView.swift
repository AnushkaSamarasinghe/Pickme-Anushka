//
//  HomeView.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import SwiftUI

struct HomeView: View {
    
    @Bindable var vm = HomeVM()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(.homePage)
            }
            VStack(spacing: 30) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hi Kasun,")
                        .font(.custom("Inter-Medium", size: 16))
                    Text("Good Morning")
                        .font(.custom("Inter-Bold", size: 24))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                ForEach (vm.homeSection, id: \.self) { section in
                    VStack(spacing: 10) {
                        Image(section.Image)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        Text(section.title)
                    }//: VStack
                    
                    
                }
            }//: HStack
            
            Spacer()
        }//: VStack
    }//: ZStack
    }
}

#Preview {
    HomeView()
}
