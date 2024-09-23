//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import Foundation

struct Transaction: Identifiable, Decodable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? Date()
    }
    
    var signedAmount: Double {
        return type == .credit ? amount : -amount
    }
}

enum TransactionType: String, Decodable {
    case debit
    case credit
}

