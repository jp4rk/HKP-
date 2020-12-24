//
//  ContentView.swift
//  WeSplit
//
//  Created by Joon Park  on 12/17/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numOfPeople = "2"
    @State private var tipPercentage = 2
    @State private var useRedText = false
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(Double(numOfPeople) ?? 0 + 2) 
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        
        let grandTotal = orderAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson

    }
    
    var total: Double{
        
        let totalPP = totalPerPerson
        
        let peopleCount = Double(Double(numOfPeople) ?? 0)
        
        let totalAmount = totalPP * peopleCount
        
        return totalAmount
    }

    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                }
                
                Section {
                    TextField("Number of people", text: $numOfPeople).keyboardType(.decimalPad)
                }
                
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section (header: Text("Total amount of the check")){
                    Text("$\(total, specifier: "%.2f")").foregroundColor(tipPercentages[tipPercentage] == 0 ? Color.red : Color.black)
                }
                
                
                Section (header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Wesplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
