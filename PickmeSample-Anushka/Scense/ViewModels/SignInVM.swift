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

public typealias CompletionHandler = (_ status: Bool, _ message: String) -> ()

extension SignInVM {
    @MainActor
    func proseedLogin(completion: @escaping CompletionHandler) async {
        let endpoint = Constant.endpoint
        
        
        
        let parameters: [String: Any] = [
            email: email,
            password: password
            ]
        
        do {
            let userResponse: UserModel = try await AFWrapper.shared.request(
                endpoint,
                method: .post,
                parameters: parameters
            )
            
            self.user = userResponse
            print(user?.token ?? "")
            
            if user?.token != "" {
                isNavigateToHome = true
            }
            
            completion(true, "User Data get Success.")
            
        } catch let error as AFWrapperError {
            print(error.errorMessage)
            completion(false, error.errorMessage)
        } catch {
            print("Failed to create user")
            completion(false, "Failed to create user")
        }
    }
}
