//
//  View+Extension.swift
//  KoinBX
//
//  Created by Guru on 24/04/25.
//

import SwiftUI

extension View {
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
