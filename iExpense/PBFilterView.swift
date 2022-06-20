//
//  PBFilterView.swift
//  iExpense
//
//  Created by Roro on 6/20/22.
//

import SwiftUI

struct PBFilterView: View {
    @ObservedObject var expenses: Expenses
//    @ObservedObject var expenses: Expenses
//    @ObservedObject var expensesPersonal: Expenses
//    @ObservedObject var expensesBusiness: Expenses
    @Environment(\.dismiss) var dismiss
    
    
    @State private var expensesModified = []
    @State var type = ""
    
    var body: some View {
        Form {
            Button {
//                print(expenses.items)
//                AddView(expenses: Expenses(), expensesPersonal: expenses, expensesBusiness: Expenses())
                personalButtonPressed()
//                expenses = expensesModified
              type = "Personal"
                
                dismiss()
            } label: {
                Text("Personal")
            }
            Button {
//                AddView(expenses: Expenses(), expensesPersonal: Expenses(), expensesBusiness: expenses)
                businessButtonPressed()
                type = "Business"
                
                dismiss()

            } label: {
                Text("Business")
            }
            Button {
//                AddView(expenses: expenses, expensesPersonal: Expenses(), expensesBusiness: Expenses())
                bothButtonPressed()
                type = "Both"
                
                dismiss()

            } label: {
                Text("Both")
            }
            
        }
        
    }
    
    
    func personalButtonPressed() {
        print(expenses)
        for item in expenses.items {
            if item.type == "Personal" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
    func businessButtonPressed() {
        for item in expenses.items {
            if item.type == "Business" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
    
    func bothButtonPressed() {
        for item in expenses.items {
            if item.type == "Business" || item.type == "Personal" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
}

struct PBFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PBFilterView(expenses: Expenses())
    }
}
