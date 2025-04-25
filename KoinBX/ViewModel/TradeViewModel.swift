//
//  TradeViewModel.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import Foundation

enum Field: Equatable {
    case price, amount, total
}

final class TradeViewModel: ObservableObject {
    /// The currently selected trade type (buy or sell).
    @Published var selectedTradeType: TradeType = .buy
    /// The currently selected order type (limit or market).
    @Published var selectedOrderType: OrderType = .limit
    
    /// The current price for the trade input. Updated when incremented, decremented, or manually changed.
    @Published var price: Double = 26796.75
    /// The fallback price used when order type is market during trade submission.
    @Published var currencyPrice: Double = 0.0198
    
    /// The amount being traded. Updates `total` automatically if `amount` is the active editing field.
    @Published var amount: Double = 0.0 {
        didSet {
            if isEditing == .amount {
                total = (price * amount).rounded(toPlaces: 5)
            }
        }
    }
    
    /// The total value of the trade. Updates `amount` automatically if `total` is the active editing field.
    @Published var total: Double = 0.0 {
        didSet {
            if isEditing == .total && price > 0 {
                amount = (total / price).rounded(toPlaces: 5)
            }
        }
    }

    /// List of recorded buy trades. Shows only the five most recent, sorted by price descending.
    @Published var buyRecords: [TradeEntry] = []
    /// List of recorded sell trades. Shows only the five most recent, sorted by price descending.
    @Published var sellRecords: [TradeEntry] = []

    /// Simulated user balance for validating and subtracting trade totals.
    var availableBalance: Double = 1000.0
    /// The precision step used for incrementing and rounding numeric inputs.
    private let precision: Double = 0.00001

    /// Tracks which input field (price, amount, or total) is currently being edited.
    private var isEditing: Field? = nil

    init() {
        loadInitialData()
    }
    
    /// Loads static initial buy and sell records for demonstration or testing.
    private func loadInitialData() {
        buyRecords = [TradeEntry(price: 26798.15, amount: 0.03264, type: .buy),
                      TradeEntry(price: 26798.13, amount: 0.00728, type: .buy),
                      TradeEntry(price: 26797.95, amount: 0.092166, type: .buy),
                      TradeEntry(price: 26797.2, amount: 0.0228, type: .buy)]

        sellRecords = [TradeEntry(price: 26801.34, amount: 0.15046, type: .sell),
                      TradeEntry(price: 26800.5, amount: 0.0161, type: .sell),
                      TradeEntry(price: 26799.9, amount: 0.19425, type: .sell),
                       TradeEntry(price: 26799.15, amount: 0.03852, type: .sell)]
    }

    /// Increments the price by the defined precision and rounds it.
    func incrementPrice() {
        beginEditing(.price)
        price = (price + precision).rounded(toPlaces: 5)
    }

    /// Decrements the price by the defined precision and ensures it doesn't go below zero.
    func decrementPrice() {
        beginEditing(.price)
        price = max(0, price - precision).rounded(toPlaces: 5)
    }

    /// Increments the amount by the defined precision and rounds it.
    func incrementAmount() {
        beginEditing(.amount)
        amount = (amount + precision).rounded(toPlaces: 5)
    }

    /// Decrements the amount by the defined precision and ensures it doesn't go below zero.
    func decrementAmount() {
        beginEditing(.amount)
        amount = max(0, amount - precision).rounded(toPlaces: 5)
    }

    /// Updates the price to a new value and rounds it. Sets editing context to `.price`.
    func updatePrice(_ newValue: Double) {
        beginEditing(.price)
        price = newValue.rounded(toPlaces: 5)
    }
    
    /// Updates the total to a new value, recalculates amount based on current price. Temporarily disables editing state to avoid recursion.
    func updateTotal(_ newValue: Double) {
        let temp = isEditing
        isEditing = nil
        total = newValue.rounded(toPlaces: 5)
        amount = (total / price).rounded(toPlaces: 5)
        isEditing = temp
    }

    /// Creates a new trade entry based on user input and order type. Adds it to the respective list and resets the input fields.
    func submitTrade() {
        let entry = TradeEntry(price: price, amount: selectedOrderType == .market ? currencyPrice : amount, type: selectedTradeType)

        switch selectedTradeType {
        case .buy:
            buyRecords.insert(entry, at: 0)
            buyRecords = Array(buyRecords.prefix(5).sorted(by: { $0.price > $1.price }))
        case .sell:
            sellRecords.insert(entry, at: 0)
            sellRecords = Array(sellRecords.prefix(5).sorted(by: { $0.price > $1.price }))
        }
        availableBalance -= total
        // Reset inputs
        amount = 0.0
        total = 0.0
        isEditing = nil
    }
    
    /// Marks the field currently being edited and clears dependent fields.
    func beginEditing(_ field: Field?) {
        isEditing = field
        guard field != nil else { return }
        clearExcept(field)
    }
    
    /// Clears all fields except the one currently being edited to ensure only one source of truth for input.
    private func clearExcept(_ field: Field?) {
        switch field {
        case .price:
            amount = 0
            total = 0
        default:
            break
        }
    }
}
