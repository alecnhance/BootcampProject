//
//  MultiSelect.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/17/25.
//

import SwiftUI

struct MultiSelect: View {
    @Binding var selectedMuscles: Set<Muscle>
    @Environment(\.dismiss) var dismiss

    let columns = [
        GridItem(.adaptive(minimum: 100)) // still wraps automatically
    ]

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
            }.padding(.bottom, 20)
            Text("Select Muscles")
                .font(.title)
                .foregroundStyle(.white)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Muscle.allCases) { muscle in
                    Button(action: {
                        // Toggle selection
                        if selectedMuscles.contains(muscle) {
                            selectedMuscles.remove(muscle)
                        } else {
                            selectedMuscles.insert(muscle)
                        }
                    }) {
                        Text(muscle.rawValue.capitalized)
                            .frame(width: 100, height: 40) // fixed size for all buttons
                            .background(selectedMuscles.contains(muscle) ? Color.cyan : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            Spacer()
        }.padding().background(.black)
            .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    @Previewable @State var previewSelectedMuscles: Set<Muscle> = []

    MultiSelect(selectedMuscles: $previewSelectedMuscles)
}
