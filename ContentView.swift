//
//  ContentView.swift
//  WeSplit
//
//  Created by Ping Yun on 9/26/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = "" //must use strings to store text field values
    @State private var numberOfPeople = 2 //index in 2-99
    @State private var tipPercentage = 2 //index in tipPercentages array
    let tipPercentages = [10, 15, 20, 25, 0] //possible tip sizes
    var totalPerPerson: Double {
        //calculates the total per person
        let peopleCount = Double(numberOfPeople + 2) //adds 2 to numberOfPeople property to get actual number of people
        let tipSelection = Double(tipPercentages[tipPercentage]) //gets value in tipPercentages at tipPercentage
        let orderAmount = Double(checkAmount) ?? 0 //attempts to convert checkAmount into Double, if fails uses 0 instead
        
        let tipValue = orderAmount / 100 * tipSelection //calculates tip value
        let grandTotal = orderAmount + tipValue //calculates total
        let amountPerPerson = grandTotal / peopleCount //calculates amount per person
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView { //gives space across top for title, lets iOS slide in new views as needed
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)//"Amount" is placeholder
                        .keyboardType(.decimalPad) //changes default keyboard to number keyboard with decimal point
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) { //makes text look like prompt for segmented control below it
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%") //counts through all options in tipPercentages, converts them into text view
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) //shows handful of options in horizontal ist
                }
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")//%f means any floating-point number, .2 asks for two digits after decimal point 
                }
            }
            .navigationBarTitle("WeSplit") //title inside navigation view allows iOS to change it freely
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
