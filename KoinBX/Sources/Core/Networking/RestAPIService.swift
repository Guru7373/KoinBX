//
//  RestAPIService.swift
//  KoinBX
//
//  Created by Guru on 28/04/25.
//

import Foundation

final class RestAPIService {
    static let shared = RestAPIService()
    private init() {}
    
    private let baseURL = URL(string: "https://api.koinbx.com")!
    
    func request<T: Decodable>(_ apiRequest: APIRequest) async throws -> T {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(apiRequest.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = apiRequest.queryItems
        
        guard let finalURL = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = apiRequest.method.rawValue
        request.httpBody = apiRequest.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
