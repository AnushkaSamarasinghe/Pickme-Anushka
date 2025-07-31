//
//  CommonButton.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import SwiftUI

struct CommonButton: View {
    let title: String
    let action: (() -> Void)?
    @State var cornerRadius: CGFloat = 100
    @State var buttonColor: Color = .accentColor
    @State var textColor: Color = .gray
    
    var body: some View {
        VStack {
            Button {
                action?()
            } label: {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(textColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(buttonColor)
                            .frame(width: 343, height: 56)
                    )
            }
        }//: VStack
    }
}

#Preview {
    CommonButton(title: "Login", action: {})
}
