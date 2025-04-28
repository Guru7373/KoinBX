//
//  TradeActionButton.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct TradeActionButton: View {
    let tradeType: TradeType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(tradeType == .buy ? "Buy" : "Sell") BTC")
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(tradeType == .buy ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
