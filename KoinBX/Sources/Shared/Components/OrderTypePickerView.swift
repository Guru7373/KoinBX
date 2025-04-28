//
//  OrderTypePickerView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct OrderTypePickerView: View {
    @Binding var selectedOrderType: OrderType
    
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            
            Spacer()
            
            Picker("Order Type", selection: $selectedOrderType) {
                ForEach(OrderType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .tint(.primaryText)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.1))
        .cornerRadius(6)
    }
}
