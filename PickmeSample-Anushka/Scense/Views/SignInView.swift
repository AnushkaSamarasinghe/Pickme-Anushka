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
                    
                    CommonButton(title: "Sign in", action: {
                       Task {
                            await loginAPICall()
                        }
                    })
                    .disabled( vm.email == "" || vm.password == "")
                    
                }//: VStack
                .padding(.horizontal, 16)
                .navigationTitle("Sign In")
                .navigationDestination(isPresented: $vm.isNavigateToHome) {
                    HomeView()
                }
            }//: ZStack
        }
    }
}

#Preview {
    SignInView()
}

extension SignInView {
    private func loginAPICall() async {
       Task {
           await vm.proseedLogin() { Success,_  in
               if Success {
                   vm.isNavigateToHome = true
                   print("Success login")
               }
           }
        }
    }
}
