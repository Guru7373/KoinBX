//
//  RestAPIRequest.swift
//  KoinBX
//
//  Created by Guru on 28/04/25.
//
import Foundation

struct APIRequest {
    let path: String
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]? = nil
    var body: Data? = nil
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
