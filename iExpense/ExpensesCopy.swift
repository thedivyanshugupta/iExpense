//
//  ExpensesCopy.swift
//  iExpense
//
//  Created by Roro on 6/22/22.
//


import Foundation

class ExpensesCopy: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodeditems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            items = decodeditems
//                print(items)
                return
            }
        }
        items = []
    }
}

