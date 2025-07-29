//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
//

import SwiftUI

enum Muscle {
    case chest, triceps, biceps, shoulders
}

struct Workout: Identifiable {
    var id: UUID = UUID()
    
    var name: String
    var date: String
    var numberSets: Int
    var muscles: [Muscle]
    var numberPRs: Int
}

struct LogView: View {
    @State var workouts: [Workout] = [Workout(name: "Push", date: "Mon 2", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Workout(name: "Pull", date: "Tue 3", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Workout(name: "Legs", date: "Wed 4", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]
    @State var showingSheet: Bool = false
    @State var inputName: String = ""
    @State var inputSets: String = ""
    @State var inputPRs: String = ""
    @State var inputDate: String = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                topButtonHStack
                Text("June Log")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                belowTitleHStack.padding(.top, 4)
                
                ScrollView {
                    ForEach(workouts) { workout in
                        WorkoutCard(workout: workout)
                    }
                }
                
                //Spacer()
            }
            .padding(.horizontal, 10)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(.black)
            .sheet(isPresented: $showingSheet) {
                sheetView.background(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
        }
    }
    
    var sheetView: some View {
        VStack(alignment: .leading) {
            Button {
                showingSheet.toggle()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.cyan)
            }
            .padding(.bottom, 10)
            Text("Enter New Workout")
                .font(.title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0, green: 0, blue: 0))
                VStack {
                    TextField("", text: $inputName, prompt: Text("enter name").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputSets, prompt: Text("number of sets").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputPRs, prompt: Text("number of PRs").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputDate, prompt: Text("Weekday Date").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(25)
                   
            }.frame(height: UIScreen.main.bounds.height * 0.2)
            Button {
                showingSheet.toggle()
                workouts.append(Workout(name: inputName, date: inputDate, numberSets: Int(inputSets) ?? -1, muscles: [], numberPRs: Int(inputPRs) ?? -1))
                inputName = ""
                inputSets = ""
                inputPRs = ""
                inputDate = ""
            } label: {
                Text("Finish")
                    .foregroundStyle(.cyan)
            }.padding(.top, 20)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
    }
    
    var topButtonHStack: some View {
        HStack {
            Button {
                print("Clicked Edit")
            } label: {
                Text("Edit")
                    .foregroundStyle(.cyan)
            }
            
            Spacer()
            
            Button {
                print("Clicked plus")
                showingSheet.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .foregroundStyle(.cyan)
            }
        }
    }
    
    var belowTitleHStack: some View {
        HStack {
            Text("June 2025")
                .foregroundStyle(.gray)
            Spacer()
            Text("1 Workout")
                .foregroundStyle(.gray)
        }
    }
    
    
}

struct WorkoutCard: View {
    var workout: Workout
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.1, green: 0.1, blue: 0.1))
                .frame(height: UIScreen.main.bounds.height * 0.16)
            HStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.125, height: UIScreen.main.bounds.width * 0.125)
                        
                    VStack {
                        Text("\(workout.date.split(separator: " ")[0])")
                            .foregroundStyle(.white)
                            .padding(.top, 1)
                        Text("\(workout.date.split(separator: " ")[1])")
                            .foregroundStyle(.white)
                            .padding(.bottom, 1)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                    .padding(.trailing, 4)
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .bold()
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                    Text("\(workout.numberSets) total sets")
                        .foregroundStyle(.white)
                    Text("\(workout.muscles.count) Muscles Hit")
                        .foregroundStyle(.white)
                    Text("\(workout.numberPRs) PRs")
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("90 min")
                    .foregroundStyle(.gray)
            }.padding(10)
            
        }
    }
}

#Preview {
    LogView()
}
