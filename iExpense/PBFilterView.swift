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
    
    @State  var expensesCopy: [ExpenseItem] = []
    
    @State var type = ""
    
    
    var body: some View {
        Form {
            Button {
//                print(expenses.items)
//                AddView(expenses: Expenses(), expensesPersonal: expenses, expensesBusiness: Expenses())
                expensesCopyCreation()
                
                personalButtonPressed()
                expenses.items.removeAll()
                print(expenses.items)
                
                for item in expensesModified {
                    expenses.items.append(item as! ExpenseItem)
                }
                
//                personalButtonPressed()
//                expenses = expensesModified
                type = "Personal"
                
                dismiss()
                
//                expenses.items = expensesCopy

            } label: {
                Text("Personal")
            }
            Button {
//                AddView(expenses: Expenses(), expensesPersonal: Expenses(), expensesBusiness: expenses)
                expensesCopyCreation()

                businessButtonPressed()
                
                expenses.items.removeAll()

                type = "Business"
                for item in expensesModified {
                    expenses.items.append(item as! ExpenseItem)
                }
                dismiss()

            } label: {
                Text("Business")
            }
            Button {
//                AddView(expenses: expenses, expensesPersonal: Expenses(), expensesBusiness: Expenses())
                expensesCopyCreation()

                bothButtonPressed()
                expenses.items.removeAll()

                type = "Both"
                for item in expensesModified {
                    expenses.items.append(item as! ExpenseItem)
                }
                dismiss()
//                expenses.items = expensesCopy

            } label: {
                Text("Both")
            }
        }
    }
    
    
    func personalButtonPressed() {
        print(expenses)
        print(expensesCopy)
        print(expenses.items)
        for item in expensesCopy {
            if (item).type == "Personal" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
    func businessButtonPressed() {
        for item in expensesCopy {
            if item.type == "Business" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
    
    func bothButtonPressed() {
        for item in expensesCopy {
            if item.type == "Business" || item.type == "Personal" {
                expensesModified.append(item)
            }
        }
        print(expensesModified)
    }
    
    func expensesCopyCreation() {
        
        if expenses.items == [] {
        expenses.items = expensesCopy
        }
        print(expensesCopy)
        print(expenses.items)
        for item in expenses.items {
            if item.type == "Business" || item.type == "Personal" {
                expensesCopy.append(item)
            }
        }
        print(expensesCopy)
    }
}

struct PBFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PBFilterView(expenses: Expenses(), expensesCopy: [ExpenseItem]())
    }
}


