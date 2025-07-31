//
//  SignInVM.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import Foundation
import Observation

@Observable
class SignInVM {
    var email: String = ""
    var password: String = ""
    var isNavigateToHome: Bool = false
    
    var user: UserModel?
}

extension SignInVM {
    @MainActor
    func proseedLogin() async {
        let endpoint = Constant.endpoint
        
        let parameters: [String: Any] = [
            email: email,
            password: password
            ]
        
        do {
//            let userResponse = try await AFWrapper.shared.request(endpoint, method: .post, parameters: parameters)
            
//            self.user = userResponse
            
        } catch let error as AFWrapper {
            print("failed: \(error)")
        }
        
    }
}
