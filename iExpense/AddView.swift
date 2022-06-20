//
//  AddView.swift
//  iExpense
//
//  Created by Roro on 6/20/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
//    @ObservedObject var expensesPersonal: Expenses
//    @ObservedObject var expensesBusiness: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]

    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "INR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
//                    print(item)
//                    print(expensesBusiness.items)
//                    print(expensesPersonal.items)
//                    
                    expenses.items.append(item)
//                    if item.type == "Personal" {
//                        expensesPersonal.items.append(item)
//                    } else {
//                        expensesBusiness.items.append(item)
//                    }

                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
//        AddView(expenses: Expenses(), expensesPersonal: Expenses(), expensesBusiness: Expenses())
        AddView(expenses: Expenses())
        
    }
}
