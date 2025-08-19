//
//  WorkoutLogApp.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userVM: UserViewModel = UserViewModel()
    @StateObject var fbVM: FirebaseViewModel = FirebaseViewModel.vm
    var body: some Scene {
        WindowGroup {
            LogView(userVM: userVM)
                .environmentObject(fbVM)
                .task {
                    userVM.lifts = await fbVM.getLifts(userID: userVM.user.id)
                    userVM.cardios = [Cardio(name: "Seated Bike", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), minutes: 30, calories: 300, maxHR: 150), Cardio(name: "Eliptical", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), minutes: 45, calories: 400, maxHR: 140)]
                }
        }
    }
}
