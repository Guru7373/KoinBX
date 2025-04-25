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
                // Buy orders
                ForEach(viewModel.sellRecords.prefix(5)) { record in
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
                ForEach(viewModel.buyRecords.prefix(5)) { record in
                    HStack {
                        Text(record.price.formatted(.number.precision(.fractionLength(0...2))))
                            .foregroundColor(.green)
                        Spacer()
                        Text(record.amount.formatted(.number.precision(.fractionLength(0...5))))
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
