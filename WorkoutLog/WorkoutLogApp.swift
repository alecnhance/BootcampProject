//
//  WorkoutLogApp.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
//

import SwiftUI

@main
struct WorkoutLogApp: App {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().backgroundColor = .black

        let normalAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let selectedAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        UISegmentedControl.appearance().setTitleTextAttributes(normalAttrs, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttrs, for: .selected)
        
        UIDatePicker.appearance().tintColor = .white // accent highlight
        //UIDatePicker.appearance().backgroundColor = .black // wheel/inline background
    }
    var body: some Scene {
        WindowGroup {
            LogView(userVM: UserViewModel(cardios: [Cardio(name: "Seated Bike", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), minutes: 30, calories: 300, maxHR: 150), Cardio(name: "Eliptical", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), minutes: 45, calories: 400, maxHR: 140)],lifts: [Lift(name: "Push", date: Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Pull", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Legs", date: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]))
        }
    }
}
