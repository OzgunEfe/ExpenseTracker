//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 23/09/2024.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON anahtarlarını camelCase'e dönüştür
                return decoder
            }())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                result.forEach { transaction in
                    print("Transaction date from JSON: \(transaction.date)")
                }
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }

        // Transaction'ları yıl ve aya göre gruplar ve sıralar
        let groupedTransactions = TransactionGroup(grouping: transactions.sorted(by: { $0.dateParsed > $1.dateParsed })) { transaction in
            let date = transaction.dateParsed
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy" // Ay ve Yıl formatı
            let monthYear = dateFormatter.string(from: date)
            return monthYear
        }

        return groupedTransactions
    }

    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        
        let today = transactions.max(by: { $0.dateParsed < $1.dateParsed })?.dateParsed ?? Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter {
                print("Transaction Date: \($0.dateParsed), Filter Date: \(date)")
                return Calendar.current.isDate($0.dateParsed, inSameDayAs: date) && $0.isExpense
            }

            
            print("Checking date: \(date.formatted())")
            print("Found \(dailyExpenses.count) transactions for \(date.formatted())")
            
            let dailyTotal = dailyExpenses.reduce(0) { $0 + abs($1.signedAmount) }
            print("\(date.formatted()) dailyTotal: \(dailyTotal)")
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum
    }

}
