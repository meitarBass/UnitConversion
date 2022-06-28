//
//  ContentView.swift
//  UnitConversion
//
//  Created by Meitar Basson on 28/06/2022.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var distanceIsFocused: Bool
    
    @State private var inputUnits = UnitLength.meters.symbol
    @State private var outputUnits = UnitLength.meters.symbol
    @State private var distance = 0.0
    
    let lengthTypes = [
        UnitLength.meters.symbol,
        UnitLength.kilometers.symbol,
        UnitLength.feet.symbol,
        UnitLength.yards.symbol,
        UnitLength.miles.symbol
    ]
    
    func getUnit(symbol: String) -> UnitLength {
        switch symbol {
        case lengthTypes[0]:
            return UnitLength.meters
        case lengthTypes[1]:
            return UnitLength.kilometers
        case lengthTypes[2]:
            return UnitLength.feet
        case lengthTypes[3]:
            return UnitLength.yards
        case lengthTypes[4]:
            return UnitLength.miles
        default:
            return UnitLength.meters
        }
    }
    

    var calculatedDistance: Double {
        let inputUnit = getUnit(symbol: inputUnits)
        let outputUnit = getUnit(symbol: outputUnits)
        
        let current = Measurement(value: distance , unit: inputUnit)
        let newDistance = current.converted(to: outputUnit)
        
        return newDistance.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Length",
                              value: $distance,
                              format: .number)
                    .keyboardType(.decimalPad)
                    .focused($distanceIsFocused)
                } header: {
                    Text("Distance:")
                }
                
                Section {
                    Picker("From", selection: $inputUnits) {
                        ForEach(lengthTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("From:")
                }
                
                Section {
                    Picker("To:", selection: $outputUnits) {
                        ForEach(lengthTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                
                Section {
                    Text("\(calculatedDistance.formatted()) \(outputUnits)")
                }header: {
                    Text("\(distance.formatted()) \(inputUnits) are")
                }
            }
            .navigationTitle("UnitConversion")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            distanceIsFocused = false
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
