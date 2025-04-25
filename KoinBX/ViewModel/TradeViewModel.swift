//
//  TradingViewModel.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import Foundation
import SwiftUI

class TradeViewModel: ObservableObject {
    
    @Published var selectedTradeType: TradeType = .buy
    @Published var selectedOrderType: OrderType = .limit
    
    @Published var price: Double = 26796.75
    @Published var amount: Double = 0
    @Published var total: Double = 0
    
    @Published var buyRecords: [TradeEntry] = []
    @Published var sellRecords: [TradeEntry] = []
    
    @Published var availableBalance: Double = 10.73299743
    
    private let precision: Double = 0.00001
    
    // MARK: - Actions
    func incrementPrice() {
        price += precision
        resetAmountAndTotal()
    }
    
    func decrementPrice() {
        price = max(0, price - precision)
        resetAmountAndTotal()
    }
    
    func incrementAmount() {
        amount += precision
        calculateTotal()
    }
    
    func decrementAmount() {
        amount = max(0, amount - precision)
        calculateTotal()
    }
    
    func updateAmount(_ newAmount: Double) {
        amount = newAmount
        total = price * amount
    }
    
    func updateTotal(_ newTotal: Double) {
        total = newTotal
        amount = price == 0 ? 0 : total / price
    }
    
    func resetAmountAndTotal() {
        amount = 0
        total = 0
    }
    
    func submitTrade() {
        let newEntry = TradeEntry(price: price, amount: amount, type: selectedTradeType)
        
        switch selectedTradeType {
        case .buy:
            buyRecords.insert(newEntry, at: 0)
            if buyRecords.count > 5 { buyRecords.removeLast() }
        case .sell:
            sellRecords.insert(newEntry, at: 0)
            if sellRecords.count > 5 { sellRecords.removeLast() }
        }
        
        resetAmountAndTotal()
    }
}

// MARK: - Double Extension

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
