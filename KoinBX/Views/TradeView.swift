//
//  TradeView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct TradeView: View {
    
    @EnvironmentObject private var viewModel: TradeViewModel
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .top, spacing: 0) {
                OrderBookView()
                    .frame(width: geo.size.width * 0.4)
                
                TradeFormView()
                    .padding()
            }
            .frame(maxHeight: .infinity)
            .background(Color.mainViewBG)
            .foregroundStyle(Color.primaryText)
            .onTapGesture {
                dismissKeyboard()
            }
        }
    }
}

#Preview {
    TradeViewPreview()
}

private struct TradeViewPreview: View {
    @StateObject private var viewModel = TradeViewModel()
    
    var body: some View {
        TradeView()
            .environmentObject(viewModel)
    }
}
