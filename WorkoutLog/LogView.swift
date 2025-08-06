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

protocol Workout: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var date: String { get }
    var topSummary: String { get }
    var midSummary: String { get }
    var botSummary: String { get }
}


struct Lift: Identifiable, Workout {
    var id: UUID = UUID()
    
    var name: String
    var date: String
    var numberSets: Int
    var muscles: [Muscle]
    var numberPRs: Int
    
    var topSummary: String {
        "\(numberSets) Total Sets"
    }
    
    var midSummary: String {
        "\(muscles.count) Muscles Hit"
    }
    
    var botSummary: String {
        "\(numberPRs) PRs"
    }
}

struct Cardio: Identifiable, Workout {
    var id: UUID = UUID()
    
    var name: String
    var date: String
    var minutes: Int
    var calories: Int
    var maxHR: Int
    
    var topSummary: String {
        "\(minutes) Minutes Completed"
    }
    
    var midSummary: String {
        "\(calories) Calories Burned"
    }
    
    var botSummary: String {
        "\(maxHR) BPM Max Heart Rate"
    }
}

struct LogView: View {
    @State var lifts: [Lift] = [Lift(name: "Push", date: "Mar 2", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Pull", date: "Mar 3", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Legs", date: "Mar 4", numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]
    @State var cardios: [Cardio] = [Cardio(name: "Seated Bike", date: "Jun 4", minutes: 30, calories: 300, maxHR: 150)]
    @State var showingSheet: Bool = false
    @State var inputName: String = ""
    @State var inputSets: String = ""
    @State var inputPRs: String = ""
    @State var inputDate: String = ""
    @State var showCardio: Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                topButtonHStack
                Text("Log")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                belowTitleHStack.padding(.top, 4)
                
                Picker("", selection: $showCardio) {
                    Text("Lifts").tag(false)
                    Text("Cardio")
                        .tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .tint(.white)
                .foregroundStyle(.red)
                
                ScrollView {
                    if !showCardio {
                        ForEach(lifts) { workout in
                            WorkoutCard(workout: workout)
                        }
                    } else {
                        ForEach(cardios) { cardio in
                            WorkoutCard(workout: cardio)
                        }
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
                lifts.append(Lift(name: inputName, date: inputDate, numberSets: Int(inputSets) ?? -1, muscles: [], numberPRs: Int(inputPRs) ?? -1))
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
            Text("2025")
                .foregroundStyle(.gray)
            Spacer()
            Text("1 Workout")
                .foregroundStyle(.gray)
        }
    }
    
    
}

struct WorkoutCard: View {
    var workout: any Workout
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
                    Text(workout.topSummary)
                        .foregroundStyle(.white)
                    Text(workout.midSummary)
                        .foregroundStyle(.white)
                    Text(workout.botSummary)
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
