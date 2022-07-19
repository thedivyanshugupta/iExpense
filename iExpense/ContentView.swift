//
//  ContentView.swift
//  iExpense
//
//  Created by Roro on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var expensesModified: [ExpenseItem] = []
    @State private var expensesBoth: [ExpenseItem] = []
    @State private var expensesPersonalBusiness: [ExpenseItem] = []

    @State private var showingConfirmation = false
    @State private var addItemInBoth = true
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {

            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "INR"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Type")
                        .onTapGesture {
                        showingConfirmation = true
                    }
                    .confirmationDialog("Filter", isPresented: $showingConfirmation) {
                        
                        Button("Personal") {
                            bothButtonPressed()
                            personalOrBusinessButtonPressed(expensesFiltered: "Personal")
                        }
                        Button("Business") {
                            bothButtonPressed()
                            personalOrBusinessButtonPressed(expensesFiltered: "Business")
                        }
                        Button("Both") {
                            bothButtonPressed()
                            expenses.items = expensesBoth
                        }
                        Button("Delete all") {
                            expenses.items.removeAll()
                            expensesModified.removeAll()
                            expensesBoth.removeAll()
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Select the filter")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addItemInBoth = true
                        showingAddExpense = true
                    }, label: {
                            Image(systemName: "plus") })
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func bothButtonPressed() {
        if addItemInBoth == true {
            for item in expenses.items {
                if item.type == "Business" || item.type == "Personal" {
                    if expensesBoth.contains(item) {
                    } else {
                        expensesBoth.append(item)
                    }
                }
            }
            expensesModified = expensesBoth
        }
    }

    func personalOrBusinessButtonPressed(expensesFiltered: String) {
        addItemInBoth = false
        for item in expensesModified {
            if item.type == expensesFiltered {
                expensesPersonalBusiness.append(item)
            }
        }
        expenses.items = expensesPersonalBusiness
        expensesPersonalBusiness = []
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        expensesBoth.remove(atOffsets: offsets)
        expensesPersonalBusiness.remove(atOffsets: offsets)
        expensesModified.remove(atOffsets: offsets)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

