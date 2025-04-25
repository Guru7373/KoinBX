//
//  KoinBXApp.swift
//  KoinBX
//
//  Created by Guru on 22/04/25.
//

import SwiftUI

@main
struct KoinBXApp: App {
    
    @StateObject private var viewModel = TradeViewModel()
    
    var body: some Scene {
        WindowGroup {
            TradeView()
                .environmentObject(viewModel)
        }
    }
}
