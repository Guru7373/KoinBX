//
//  OrderBookView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct OrderBookView: View {
    let buyRecords: [TradeEntry]
    let sellRecords: [TradeEntry]
    let currentPrice: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Header
            HStack {
                Text("Price")
                    .foregroundStyle(.secondary)
                    .bold()
                Spacer()
                Text("Amount")
                    .foregroundStyle(.secondary)
                    .bold()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)

            // Sell Orders
            ForEach(sellRecords.prefix(5)) { record in
                HStack {
                    Text(record.price.formatted(.number.precision(.fractionLength(0...2))))
                        .foregroundColor(.red)
                    Spacer()
                    Text(record.amount.formatted(.number.precision(.fractionLength(0...5))))
                }
                .font(.caption)
                .padding(.horizontal, 8)
            }
            
            // Current Market Price
            VStack(alignment: .leading, spacing: 2) {
                Text(currentPrice.formatted(.number.precision(.fractionLength(0...2))))
                    .font(.headline)
                    .foregroundColor(.white)
                Text(String(format: "$%.2f", currentPrice))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding([.horizontal, .vertical], 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Buy Orders
            ForEach(buyRecords.prefix(5)) { record in
                HStack {
                    Text(record.price.formatted(.number.precision(.fractionLength(0...2))))
                        .foregroundColor(.green)
                    Spacer()
                    Text(record.amount.formatted(.number.precision(.fractionLength(0...5))))
                }
                .font(.caption)
                .padding(.horizontal, 8)
            }
            
            Spacer()
        }
    }
}
