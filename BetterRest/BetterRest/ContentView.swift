//
//  ContentView.swift
//  BetterRest
//
//  Created by Joon Park  on 12/21/20.
//

import SwiftUI



struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View{
        NavigationView {
            Form {
                Text("When do you want to wake up?")
                    .font(.headline)

                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                
                
                Section (header: Text("Desired amount of sleep").font(.headline)){
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    
                }
                
                Picker("Daily coffee intake", selection: $coffeeAmount) {
                    
                    ForEach(1 ..< 20){
                        if $0 == 1 {
                            Text("\($0) cup")
                        }
                        else {
                            Text("\($0) cups")
                        }
                    }
                }
                
                Section (header: Text("Recommended Bedtime ").font(.headline))
                {
                    Text(calculateBedtime())
                    
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let final = formatter.string(from: sleepTime)
            
            return final

        } catch {
            return "Error: Please try again"
        }
            
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

