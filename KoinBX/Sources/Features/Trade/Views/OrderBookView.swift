//
//  OrderBookView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct OrderBookView: View {
    
    @EnvironmentObject var viewModel: TradeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Header
            HStack {
                Text("Price")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.bold())
                
                Spacer()
                
                Text("Amount")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.bold())
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)

            ScrollView(.vertical, showsIndicators: false) {
                // Sellasks orders
                let asks = viewModel.orderBook?.data.asks.prefix(5) ?? []
                ForEach(asks, id: \.self) { record in
                    let price = record.first?.formatPrice() ?? "0.0"
                    let amount = record.last?.formatted(.number.precision(.fractionLength(0...5))) ?? "0"
                    HStack {
                        Text(price)
                            .foregroundColor(.red)
                        Spacer()
                        Text(amount)
                    }
                    .font(.caption)
                    .padding(.horizontal, 8)
                }
                
                // Current Market Price
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.price.formatted(.number.precision(.fractionLength(0...2))))
                        .font(.headline)
                        .foregroundStyle(Color.primaryText)
                    
                    Text(String(format: "$%.2f", viewModel.price))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding([.horizontal, .vertical], 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Buy Orders
                let bids = viewModel.orderBook?.data.bids.prefix(5) ?? []
                ForEach(bids, id: \.self) { record in
                    HStack {
                        let price = record.first?.formatPrice() ?? "0.0"
                        let amount = record.last?.formatted(.number.precision(.fractionLength(0...5))) ?? "0"
                        Text(price)
                            .foregroundColor(.green)
                        Spacer()
                        Text(amount)
                    }
                    .font(.caption)
                    .padding(.horizontal, 8)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    OrderBookPreview()
}

private struct OrderBookPreview: View {
    @StateObject private var viewModel = TradeViewModel()
    
    var body: some View {
        OrderBookView()
            .environmentObject(viewModel)
    }
}
