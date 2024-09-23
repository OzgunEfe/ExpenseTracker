//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 23/09/2024.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                // Header title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                //Header Link
                NavigationLink {
                    
                } label: {
                    HStack (spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0, y:5)
    }
}

#Preview {
    RecentTransactionList()
}
