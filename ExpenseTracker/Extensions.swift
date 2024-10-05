//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Ozgun Efe on 02/09/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let custombackground = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUK: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parseDate = DateFormatter.allNumericUK.date(from: self) else { return Date() }
        return parseDate
    }
}

