//
//  AvailableBalanceView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct AvailableBalanceView: View {
    let balance: Double
    
    var body: some View {
        HStack {
            Text("Available:")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(balance.formatted(.number.precision(.fractionLength(0...5))) + " BTC")
                .font(.footnote)
                .foregroundStyle(Color.primaryText)

            Spacer()
        }
    }
}
