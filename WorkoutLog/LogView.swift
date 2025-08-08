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

extension Date {
    func monthDayMultiline() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM\nd" // "Aug\n7"
        return formatter.string(from: self)
    }
}

protocol Workout: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var date: Date { get }
    var topSummary: String { get }
    var midSummary: String { get }
    var botSummary: String { get }
}


struct Lift: Identifiable, Workout {
    var id: UUID = UUID()
    
    var name: String
    var date: Date
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
    var date: Date
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
    @State var lifts: [Lift] = [Lift(name: "Push", date: Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Pull", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Legs", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]
    @State var cardios: [Cardio] = [Cardio(name: "Seated Bike", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), minutes: 30, calories: 300, maxHR: 150)]
    @State var showingSheet: Bool = false
    @State var inputName: String = ""
    @State var inputSets: String = ""
    @State var inputPRs: String = ""
    @State var inputDate: String = ""
    @State var showCardio: Bool = false
    @State var insertDate: Date = Date()
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
                VStack(alignment: .leading) {
                    TextField("", text: $inputName, prompt: Text("enter name").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputSets, prompt: Text("number of sets").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputPRs, prompt: Text("number of PRs").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    HStack {
                        DatePicker(
                            "Start Date:",
                            selection: $insertDate,
                            displayedComponents: [.date]
                        ).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .colorScheme(.dark)
                            
                    }.frame(width: UIScreen.main.bounds.width * 0.55)
    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(25)
                   
            }.frame(height: UIScreen.main.bounds.height * 0.2)
            Button {
                showingSheet.toggle()
                lifts.append(Lift(name: inputName, date: insertDate, numberSets: Int(inputSets) ?? -1, muscles: [], numberPRs: Int(inputPRs) ?? -1))
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
                        Text("\(workout.date.monthDayMultiline())")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 1)
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
