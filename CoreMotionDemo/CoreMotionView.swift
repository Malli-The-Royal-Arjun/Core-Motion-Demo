//
//  CoreMotionView.swift
//  CoreMotionDemo
//
//  Created by Ambati, Janakiram @ CBRE Contractor on 14/07/22.
//

import SwiftUI

struct CoreMotionView: View {
    
    @ObservedObject var viewmodel : CoreMotionViewModel = .shared
    
    init() {
        viewmodel.startUpdates()
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("User Activity Type")) {
                    Text("Stationary")
                        .listRowBackground(viewmodel.stationary == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.stationary == true ? Color.white : .black)
                        .padding()
                    Text("Walking")
                        .listRowBackground(viewmodel.walking == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.walking == true ? Color.white : .black)
                        .padding()
                    Text("Running")
                        .listRowBackground(viewmodel.running == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.running == true ? Color.white : .black)
                        .padding()
                    Text("Cycling")
                        .listRowBackground(viewmodel.cycling == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.cycling == true ? Color.white : .black)
                        .padding()
                    Text("Automotive")
                        .listRowBackground(viewmodel.automotive == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.automotive == true ? Color.white : .black)
                        .padding()
                    Text("Unknown")
                        .listRowBackground(viewmodel.unknown == true ? Color.green : .clear)
                        .foregroundColor(viewmodel.unknown == true ? Color.white : .black)
                        .padding()
                }
                
                Section(header: Text("Confidence value")) {
                    Text("Confidence is \(viewmodel.confidence)")
                }
                
                Section(header: Text("Pedometer")) {
                    Text("Steps count is \(viewmodel.stepsCount)")
                    Text("Distance is \(viewmodel.distance)")
                    Text("Floors Ascended is \(viewmodel.floorsAsc)")
                    Text("Floors Ascended is \(viewmodel.floorsDesc)")
                }
            }
            .navigationTitle("CBRE Motion detection")
        }
    }
}

struct CoreMotionView_Previews: PreviewProvider {
    static var previews: some View {
        CoreMotionView()
    }
}
