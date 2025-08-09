//
//  CardioView.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/9/25.
//

import SwiftUI

struct LiftView: View {
    @State var name: String
    @State var date: Date
    @State var numberSets: Int
    @State var numPRs: Int
    @Environment(\.dismiss) var dismiss
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
            TextField("Workout Name", text: $name)
                .foregroundStyle(.white)
                .font(.title)
                .multilineTextAlignment(.center)
            DatePicker(
                "Start Date:",
                selection: $date,
                displayedComponents: [.date]
            ).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            Stepper("Minutes: \(numberSets)", value: $numberSets, in: 0...1000)
                .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            
            
            Stepper("Number of PRs: \(numPRs)", value: $numPRs, in: 0...500)
                .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                .colorScheme(.dark)
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                        Text("Delete")
                            .foregroundStyle(.white)
                    }
                }
                Button {
                    
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
    LiftView(name: "Push", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), numberSets: 20, numPRs: 2)
}
