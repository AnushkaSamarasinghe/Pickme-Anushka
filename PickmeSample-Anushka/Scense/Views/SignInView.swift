//
//  SignInView.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import SwiftUI

struct SignInView: View {
    @Bindable var vm = SignInVM()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    //Email field
                    EmailField(email: $vm.email)
                    
                    //Password field
                    PasswordField(password: $vm.password)
                    
                    Spacer()
                    
                    CommonButton(title: "Login", action: {
                       Task {
                            await loginAPICall()
                        }
                    })
                }//: VStack
                .padding(.horizontal, 16)
                .navigationTitle("Sign In")
            }//: ZStack
//            .navigationDestination(for: vm.isNavigateToHome) { user in
//                HomeView()
//            }
        }
    }
}

#Preview {
    SignInView()
}

extension SignInView {
    private func loginAPICall() async {
       Task {
           await vm.proseedLogin()
        }
    }
}
