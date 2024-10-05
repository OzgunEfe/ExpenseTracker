//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var demoData: [Double] = [8, 3, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // Chart
                    CardView {
                        VStack {
                            ChartLabel("£900", type: .title)
                            LineChart()
                        }
                        .background(Color.systemBackground)
                        
                    }
                    .data(demoData)
                    .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                    .frame(height: 300)
                    
                    // TransactionList
                    RecentTransactionList()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.custombackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundColor(Color.iconColor)
                        
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
