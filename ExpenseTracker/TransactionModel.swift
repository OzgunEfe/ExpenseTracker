//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTranster: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
}

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
}
