//
//  CardioView.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/9/25.
//

import SwiftUI

struct LiftView: View {
    @State var lift: Lift
    var id: UUID
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                }
                Spacer()
            }
            TextField("Workout Name", text: $lift.name)
                .foregroundStyle(.white)
                .font(.title)
                .multilineTextAlignment(.center)
            DatePicker(
                "Start Date:",
                selection: $lift.date,
                displayedComponents: [.date]
            ).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            Stepper("Number of Sets: \(lift.numberSets)", value: $lift.numberSets, in: 0...1000)
                .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            
            
            Stepper("Number of PRs: \(lift.numberPRs)", value: $lift.numberPRs, in: 0...500)
                .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            HStack {
                Button {
                    userVM.removeLift(lift: lift)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                        Text("Delete")
                            .foregroundStyle(.white)
                    }
                }
                Button {
                    userVM.updateLift(lift: lift)
                    dismiss()
                } label: {
                    HStack {
                        Text("Submit")
                            .foregroundStyle(.cyan)
                        Image(systemName: "checkmark")
                            .foregroundStyle(.cyan)
                    }
                }.padding(.leading, 40)
            }.padding(.top, 20)
            Spacer()
        }.padding(.horizontal, 10)
            .background(Color.black)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LiftView(lift: Lift(name: "Push", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), numberSets: 20, muscles: [], numberPRs: 2),id: UUID(), userVM: UserViewModel(cardios: [Cardio(name: "Seated Bike", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), minutes: 30, calories: 300, maxHR: 150), Cardio(name: "Eliptical", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), minutes: 45, calories: 400, maxHR: 140)],lifts: [Lift(name: "Push", date: Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Pull", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Legs", date: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]))
}
