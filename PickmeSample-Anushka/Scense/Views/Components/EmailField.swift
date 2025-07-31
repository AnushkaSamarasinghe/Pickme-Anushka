//
//  EmailField.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import SwiftUI

struct EmailField: View {
    @State var headerText: String = "Username"
    @State var textFieldName: String = ""
    @Binding var email: String
    
    var cornerRadius: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
           Text(headerText)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black)
            
            HStack {
                TextField("", text: $email, prompt: Text(textFieldName))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
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
    EmailField(email: .constant(""))
}
