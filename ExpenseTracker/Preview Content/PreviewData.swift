//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "03/09/2024", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 12.50, type: "debit", categoryId: 801, category: "Software", isPending: false, isTranster: false, isExpense: true, isEdited: false)


var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
