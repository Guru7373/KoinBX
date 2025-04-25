//
//  TradeFormView.swift
//  KoinBX
//
//  Created by Guru on 23/04/25.
//

import SwiftUI

struct TradeFormView: View {
    
    @EnvironmentObject var viewModel: TradeViewModel
    @FocusState var focusState: Field?
    
    var body: some View {
        VStack(spacing: 12) {
            TradeTypeToggleView(selectedType: $viewModel.selectedTradeType)
            
            OrderTypePickerView(selectedOrderType: $viewModel.selectedOrderType)
            
            VStack {
                IncrementDecrementInputView(title: "Price",
                                            value: $viewModel.price,
                                            increment: viewModel.incrementPrice,
                                            decrement: viewModel.decrementPrice)
                .onChange(of: viewModel.price) { newValue in
                    viewModel.updatePrice(newValue)
                }
                
                IncrementDecrementInputView(title: "Amount (BTC)",
                                            value: $viewModel.amount,
                                            increment: viewModel.incrementAmount,
                                            decrement: viewModel.decrementAmount)
                .focused($focusState, equals: .amount)
                
                TradeSliderView { percent in
                    let balanceForUse = viewModel.availableBalance * (percent / 100)
                    viewModel.updateTotal(balanceForUse)
                }
                
                TotalInputView(title: "Total", value: $viewModel.total)
                    .focused($focusState, equals: .total)
                
                AvailableBalanceView(balance: viewModel.availableBalance)
            }
            .disabled(viewModel.selectedOrderType == .market)

            TradeActionButton(tradeType: viewModel.selectedTradeType,
                              action: viewModel.submitTrade)
            .disabled((viewModel.amount <= 0 || viewModel.total <= 0 || viewModel.availableBalance <= 0) && viewModel.selectedOrderType == .limit)
        }
        .onChange(of: focusState) { newValue in
            viewModel.beginEditing(newValue)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
            focusState = nil
            viewModel.beginEditing(nil)
        }
    }
}

#Preview {
    TradeFormPreview()
}

private struct TradeFormPreview: View {
    @StateObject private var viewModel = TradeViewModel()
    
    var body: some View {
        TradeFormView()
            .environmentObject(viewModel)
    }
}
