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
    @State private var expensesPersonal: [ExpenseItem] = []
    @State private var expensesBusiness: [ExpenseItem] = []
    @State private var expensesBoth: [ExpenseItem] = []

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
                            personalButtonPressed()
                        }
                        Button("Business") {
                            bothButtonPressed()
                            businessButtonPressed()
                        }
                        Button("Both") {
                            bothButtonPressed()
                            expenses.items = expensesBoth
                        }
                        Button("Delete all") {
                            expenses.items.removeAll()
                            expensesBoth.removeAll()
                            expensesPersonal.removeAll()
                            expensesBusiness.removeAll()
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
    
    func personalButtonPressed() {
        addItemInBoth = false
        for item in expensesModified {
            if item.type == "Personal" {
                expensesPersonal.append(item)
            }
        }
        expenses.items = expensesPersonal
        expensesPersonal = []
        expensesBusiness = []
    }
    
    func businessButtonPressed() {
        addItemInBoth = false
        for item in expensesModified {
            if item.type == "Business" {
                expensesBusiness.append(item)
            }
        }
        expenses.items = expensesBusiness
        expensesPersonal = []
        expensesBusiness = []
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

