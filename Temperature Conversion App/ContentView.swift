//
//  ContentView.swift
//  UnitConverter
//
//  Created by Steven Gustason on 3/19/23.
//

import SwiftUI

struct ContentView: View {
    // Create State variable for inputting the original temp
    @State private var input = 0.0
    // Create State variable for the original unit of temperature
    @State private var inputUnit = "Fahrenheit"
    // Create State variable for desired output unit of temperature
    @State private var outputUnit = "Celsius"
    
    // Create array of temperature unit selection options to use in the pickers
    let tempOptions = ["Fahrenheit", "Celsius", "Kelvin"]
    
    // Calculate the output temperature
    var output: Double {
        var tempTemp = 0.0
        var actualOutput = 0.0
        
        // First, convert the input temp to Celsius
        switch inputUnit {
            // If the first temp was in Fahrenheit, convert to Celsius
        case "Fahrenheit":
            tempTemp = (input - 32) * 5 / 9
            // If the first temp was in Kelvin, convert to Celsius
        case "Kelvin":
            tempTemp = input - 273.15
            // if the first temp was already in Celsius, set our temp variable to the original input
        default:
            tempTemp = input
        }
        
        // Now convert our Celsius unit to the correct output unit
        switch outputUnit {
            // Convert Celsius to Fahrenheit
        case "Fahrenheit":
            actualOutput = (tempTemp * 9 / 5) + 32
            // Convert Celsius to Kelvin
        case "Kelvin":
            actualOutput = tempTemp + 273.15
            // If we're going from Celsius to Celsius, then we don't need to do any conversion
        default:
            actualOutput = tempTemp
        }
        
        // Return the final calculated value
        return actualOutput
    }
    
    // Track focus
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Bind our input temp text field to our input variable, and make it so there's a decimal keyboard since the user will only be entering numbers here, and also set it up so the field drops focus and the keyboard goes away when the user hits Done
                    TextField("InputTemp", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    // Add a header for readability
                } header: {
                    Text("Enter temperature:")
                }
                Section {
                    // Create a segmented picker for our three temperature units and bind it to inputUnit
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(tempOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    // Header for readability
                } header: {
                    Text("From which unit?")
                }
                Section {
                    // Create a segmented picker again but this time bind it to outputUnit
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(tempOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    // Header for readability
                } header: {
                    Text("To which unit?")
                }
                Section {
                    // Display our calculated output
                    Text(output, format: .number)
                    // Header for readability
                } header: {
                    Text("Converted Temperature")
                }
            }
            // Add a title header for our app
            .navigationTitle("TempConverter")
            // Add a done button on the right of our keyboard and set focus to false when user hits Done
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
