//
//  AFWrapper.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import Alamofire
import Foundation
import SwiftUI

struct Constant {
    static let getBaseURL = "https://reqres.in/api"
    static let endpoint = "/login"
}

struct APIErrorResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
}

enum AFWrapperError: Error {
    case requestFailed(String)
    case decodingFailed
    case invalidResponse
    
    var errorMessage: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .decodingFailed:
            return "Decoding failed."
        case .invalidResponse:
            return "Invalid response received."
        }
    }
}

final class AFWrapper: Sendable {
    
    static let shared = AFWrapper()
    
    private init() {} // Private initializer to ensure Singleton usage
    
    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let requestURL = Constant.getBaseURL.appending(endpoint)
        print("🔹Request URL: \(requestURL)\n🔹")
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = AF.request(
                requestURL,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
            .validate(statusCode: 200..<300)
            .responseData { [weak self] response in
                
                switch response.result {
                case .failure(let error):
                    self?.handleError(response: response, error: error, continuation: continuation)
                    
                case .success(let data):
                    self?.handleSuccess(data: data, continuation: continuation)
                }
            }
            
            DispatchQueue.main.async {
                print("REQUEST = \(request.debugLog())")
            }
        }
    }
    
    private func handleError<T: Decodable>(
        response: AFDataResponse<Data>,
        error: AFError,
        continuation: CheckedContinuation<T, Error>
    ) {
        guard let data = response.data else {
            let message = "Request failed: \(error.localizedDescription)"
            continuation.resume(throwing: AFWrapperError.requestFailed(message))
            return
        }
        
        guard let decodingError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) else {
            let message = "Request failed: \(error.localizedDescription)"
            continuation.resume(throwing: AFWrapperError.requestFailed(message))
            return
        }
        
        let errorMessage = decodingError.message ?? "Unknown error occurred"
        continuation.resume(throwing: AFWrapperError.requestFailed(errorMessage))
    }
    
    private func handleSuccess<T: Decodable>(
        data: Data,
        continuation: CheckedContinuation<T, Error>
    ) {
        do {
            let result = try decode(data: data, to: T.self)
            continuation.resume(returning: result)
        } catch {
            continuation.resume(throwing: error)
        }
    }
    
    private func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        
        guard let result = try? decoder.decode(type, from: data) else {
            throw AFWrapperError.decodingFailed
        }
        
        return result
    }
}

extension Request {
    public func debugLog() -> Self {
#if DEBUG
        cURLDescription(calling: { curl in
            debugPrint("=======================================")
            print(curl)
            debugPrint("=======================================")
        })
#endif
        return self
    }
}
