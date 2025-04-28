//
//  TradeRecord.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import Foundation

/// Represents a trade entry with price, amount, and type (buy/sell).
/// Conforms to `Identifiable` for use in lists and views.
struct TradeEntry: Identifiable {
    let id = UUID()
    let price: Double
    let amount: Double
    let type: TradeType
}

/// Represents the type of trade: `buy` or `sell`.
enum TradeType {
    case buy, sell
}

/// Represents the type of order: limit or market.
/// Used for determining how the trade is executed.
enum OrderType: String, CaseIterable, Identifiable {
    case limit = "Limit"
    case market = "Market"
    
    var id: String { rawValue }
}
