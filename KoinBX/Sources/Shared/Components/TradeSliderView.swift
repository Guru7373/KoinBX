//
//  TradeSliderView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct TradeSliderView: View {
    var onPercentageSelected: (Double) -> Void
    
    private let percentages: [Double] = [25, 50, 75, 100]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(percentages, id: \.self) { percent in
                Button(action: {
                    onPercentageSelected(percent)
                }) {
                    Text("\(Int(percent))%")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                }
                .scaledToFit()
            }
        }
    }
}
