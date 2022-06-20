//
//  ContentView.swift
//  iExpense
//
//  Created by Roro on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showActionSheet = false
    @State private var expensesModified = Expenses()

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
                    Button(action: {
                        showActionSheet = true
                    }, label: {
                        Text("Type")})
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddExpense = true
                    }, label: {
                            Image(systemName: "plus") })
                }

            }
            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses, expensesPersonal: Expenses(), expensesBusiness: Expenses())
                AddView(expenses: Expenses())

            }
            
            .sheet(isPresented: $showActionSheet) {
                PBFilterView(expenses: Expenses())
                if PBFilterView(expenses: Expenses()).type == "Personal" {
                    
                }
            }
        }

    }
    
    func personalButtonPressed() {
        print(expenses)
        for item in expenses.items {
            if item.type == "Personal" {
                expensesModified.items.append(item)
            }
        }
        expenses = expensesModified
        print(expensesModified)
    }
    
    func businessButtonPressed() {
        for item in expenses.items {
            if item.type == "Business" {
                expensesModified.items.append(item)
            }
        }
        print(expensesModified)
    }
    
    
    func bothButtonPressed() {
        for item in expenses.items {
            if item.type == "Business" || item.type == "Personal" {
                expensesModified.items.append(item)
            }
        }
        print(expensesModified)
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        print(expenses.items)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
