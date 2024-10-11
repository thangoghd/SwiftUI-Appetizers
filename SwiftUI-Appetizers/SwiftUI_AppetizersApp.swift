//
//  SwiftUI_AppetizersApp.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

@main
struct SwiftUI_AppetizersApp: App {
    @StateObject private var cartController = CartController()

    var body: some Scene {
        WindowGroup {
            AppetizerTabView()
                .environmentObject(cartController)
        }
    }
}
