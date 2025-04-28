//
//  TradeTypeToggleView.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

struct TradeTypeToggleView: View {
    @Binding var selectedType: TradeType
    
    var body: some View {
        HStack(spacing: 0) {
            toggleButton(for: .buy, title: "Buy", selectedImage: Image(.buyBG), unselectedImage: Image(.buyUnselectedBG))
            toggleButton(for: .sell, title: "Sell", selectedImage: Image(.sellBG), unselectedImage: Image(.sellUnselectedBG))
        }
        .frame(height: 30)
        .padding(.vertical, 8)
        .background(Color.clear)
    }
    
    private func toggleButton(for type: TradeType, title: String, selectedImage: Image, unselectedImage: Image) -> some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedType = type
                }
            }) {
                ZStack {
                    (selectedType == type ? selectedImage : unselectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
        }
}
