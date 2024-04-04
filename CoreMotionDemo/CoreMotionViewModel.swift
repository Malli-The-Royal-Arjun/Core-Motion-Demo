//
//  CoreMotionViewModel.swift
//  CoreMotionDemo
//
//  Created by Ambati, Janakiram @ CBRE Contractor on 14/07/22.
//

import Foundation
import SwiftUI
import CoreMotion

class CoreMotionViewModel : NSObject, ObservableObject {

    static let shared = CoreMotionViewModel()
    
    private let manager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private let altimeter = CMAltimeter()
    
    @Published var stationary = false
    @Published var walking = false
    @Published var running = false
    @Published var automotive = false
    @Published var cycling = false
    @Published var unknown = false

    @Published var confidence = ""
    @Published var stepsCount = 0
    @Published var distance = 0
    @Published var floorsAsc = 0
    @Published var floorsDesc = 0
    
    func startUpdates() {
        if CMMotionActivityManager.isActivityAvailable() {
            manager.startActivityUpdates(to: OperationQueue.main) { (motion) in
                self.stationary = (motion?.stationary)! ? true : false
                self.walking = (motion?.walking)! ? true : false
                self.running = (motion?.running)! ? true : false
                self.automotive = (motion?.automotive)! ? true : false
                self.cycling = (motion?.cycling)! ? true : false
                self.unknown = (motion?.unknown)! ? true : false
                                
                if motion?.confidence == CMMotionActivityConfidence.low {
                    self.confidence = "Low"
                } else if motion?.confidence == CMMotionActivityConfidence.medium {
                    self.confidence = "Good"
                } else if motion?.confidence == CMMotionActivityConfidence.high {
                    self.confidence = "High"
                }
            }
            
            let calendar = Calendar.current
            manager.queryActivityStarting(from: calendar.startOfDay(for: Date()),
                                          to: Date(),
                                          to: OperationQueue.main) { (motionActivities, error) in
                for motionActivity in motionActivities! {
                    if motionActivity.automotive {
                        print(motionActivity)
                    }
                }
            }
            
        }
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                guard let pedometerData = pedometerData, error == nil else { return }
                
                DispatchQueue.main.async {
                    print(pedometerData.numberOfSteps.intValue)
                    self.stepsCount = pedometerData.numberOfSteps.intValue
                    self.distance = pedometerData.distance?.intValue ?? 10
                    self.floorsAsc = pedometerData.floorsAscended?.intValue ?? 10
                    self.floorsDesc = pedometerData.floorsDescended?.intValue ?? 10
                }
            }
        }
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { data, error in
                if let altitudeData = data {
                    print("time = \(altitudeData.timestamp)")
                    print("relativeAltitude = \(altitudeData.relativeAltitude)")
                    print("pressure = \(altitudeData.pressure)")
                    print("===================")
                }
            }
         }
    }

}
