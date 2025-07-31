//
//  AFWrapper.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import Foundation
import Alamofire

struct Constant {
    static let baseURL = ""
    static let endpoint = ""
}

final class AFWrapper: Sendable {
    static let shared = AFWrapper()
    
    private init() {}
    
    func request<T: Decodable>(
        _ route: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
            
            let requestURL = Constant.baseURL.appending(route)
            
            return try await withCheckedThrowingContinuation { continuation in
                let request = AF.request(requestURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
                
                request.responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        self.handleSuccess(data: value as! Data, continuation: continuation)
                    case .failure(let error):
                        self.handleFailure(error: error, continuation: continuation)
                    }
                }
            }
            
        }
            
            private func handleSuccess<T: Decodable> (
                data: Data,
                continuation: CheckedContinuation<T, Error>
            ) {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
    
    private func handleFailure<T: Decodable>(
        error: Error,
        continuation: CheckedContinuation<T, Error>
    ) {
        continuation.resume(throwing: error)
    }
    
}
