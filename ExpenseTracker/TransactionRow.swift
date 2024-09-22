//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 22/09/2024.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    
    var body: some View {
        HStack(spacing: 20){
            VStack(alignment: .leading, spacing: 8){
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "GBP"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
            
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}
