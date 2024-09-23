//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
