//
//  TradeService.swift
//  KoinBX
//
//  Created by Guru on 28/04/25.
//

import Foundation

final class TradeService {
    
    static func fetchOrderBook(marketPair: String, depth: Int) async throws -> OrderBookResponse {
        let request = APIRequest(
            path: "/orderbook",
            queryItems: [
                URLQueryItem(name: "market_pair", value: marketPair),
                URLQueryItem(name: "depth", value: "\(depth)")
            ]
        )
        
        return try await RestAPIService.shared.request(request)
    }
}
