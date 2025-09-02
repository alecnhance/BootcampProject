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
    @State var userVM: UserViewModel = UserViewModel()
    @State var fbVM: FirebaseViewModel? = nil
    var body: some Scene {
        WindowGroup {
            if let fbVM = fbVM {
                LogView(userVM: userVM)
                    .environment(fbVM)
                    .task {
                        userVM.lifts = await fbVM.getLifts(userID: userVM.user.id)
                    }
            } else {
                ProgressView("Loading...")
                    .task {
                        // initialize AFTER FirebaseApp.configure() runs
                        fbVM = FirebaseViewModel.vm
                    }
            }
        }
    }
}
