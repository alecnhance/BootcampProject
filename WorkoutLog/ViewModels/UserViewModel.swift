//
//  WorkoutViewModel.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/9/25.
//
import SwiftUI
import Foundation

class UserViewModel: ObservableObject {
    var user: User
    @Published var cardios: [Cardio]
    @Published var lifts: [Lift]
    
    init(user: User = User(id: "Default", name: "Default", email: "default@gmail.com"), cardios: [Cardio] = [], lifts: [Lift] = []) {
        self.user = user
        self.cardios = cardios
        self.lifts = lifts
    }
    
    func updateLift(lift: Lift) {
        if let index = lifts.firstIndex(where: { $0.id == lift.id }) {
            lifts[index] = lift
        } else {
            print("error finding lift")
        }
    }
    
    func removeLift(lift: Lift) {
        if let index = lifts.firstIndex(where: { $0.id == lift.id }) {
            lifts.remove(at: index)
            print("removed lift")
        } else {
            print("error removing lift")
        }
    }
    
    func addLift(lift: Lift) {
        lifts.append(lift)
    }
}
