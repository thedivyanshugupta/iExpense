//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Roro on 6/20/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double    
}
