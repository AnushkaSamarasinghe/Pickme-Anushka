//
//  PasswordField.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import SwiftUI

struct PasswordField: View {
    @State var headerText: String = "Password"
    @State var textFieldName: String = ""
    @State var isShowPassword: Bool = false
    @Binding var password: String
    
    var cornerRadius: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
           Text(headerText)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black)
            
            HStack {
                SecureField("", text: $password)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                
                Button(action: {
                    isShowPassword.toggle()
                }, label: {
                    if isShowPassword {
                        Image(systemName: "eye.slash")
                    } else {
                        Image(systemName: "eye")
                    }
                })//: Button
            }//: HStack
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .frame(height: 48)
            .foregroundStyle(.black)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(cornerRadius)
        }//: VStack
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
    }
}

#Preview {
    PasswordField(password: .constant("test"))
}
