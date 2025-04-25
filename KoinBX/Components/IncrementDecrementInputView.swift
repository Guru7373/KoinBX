//
//  IncrementDecrementInputView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct IncrementDecrementInputView: View {
    let title: String
    @Binding var value: Double
    let increment: () -> Void
    let decrement: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            // Decrement Button
            Button(action: decrement) {
                Image(systemName: "minus")
                    .frame(width: 30, height: 30)
            }
            
            // Value Input
            TextField(title, value: $value, format: .number.precision(.fractionLength(0...5)))
                .keyboardType(.decimalPad)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(height: 36)

            // Increment Button
            Button(action: increment) {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
            }
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(6)
    }
}

struct TotalInputView: View {
    let title: String
    @Binding var value: Double

    var body: some View {
        HStack(spacing: 8) {
            TextField(title, value: $value, format: .number.precision(.fractionLength(0...5)))
                .keyboardType(.decimalPad)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(height: 36)
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(6)
    }
}
