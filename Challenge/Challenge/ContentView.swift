//
//  ContentView.swift
//  Challenge
//
//  Created by Joon Park  on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    @State private var value = ""
    
    @State private var unitType = 0
    @State private var unitType2 = 0
    
    let unitTypes = ["m", "km", "ft", "yd", "mi"]
    
    let unitTypes2 = [UnitLength.meters, UnitLength.kilometers,UnitLength.feet,UnitLength.yards,UnitLength.miles]
    
    var changed: Double{
        
        let finalval = Double(value) ?? 0
        
        let initialUnit = unitTypes2[unitType]
        
        let finalUnit = unitTypes2[unitType2]
        
        let initial = Measurement(value: finalval, unit: initialUnit)
        
        let final = initial.converted(to: finalUnit).value
        
        let finalfinal = final
        
        return finalfinal
        
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Enter the number: ", text: $value).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Please enter the input unit:")) {
                    Picker("Input unit selection ", selection: $unitType) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Please enter the output unit:")) {
                    Picker("Output unit selection ", selection: $unitType2) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section (header: Text("Converted Unit")){
                    Text("\(changed, specifier: "%.3f")")
                    }
            }
            .navigationBarTitle("Change Units!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
