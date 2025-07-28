//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
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
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.cyan)
                    }
                }
                Text("June Log")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                HStack {
                    Text("June 2025")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("1 Workout")
                        .foregroundStyle(.gray)
                }.padding(.top, 4)
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .frame(height: geometry.size.height * 0.2)
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
                                .stroke(.white)
                                .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                
                            VStack {
                                Text("Mon")
                                    .foregroundStyle(.white)
                                    .padding(.top, 1)
                                Text("2")
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 1)
                            }
                        }.frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                            .padding(.trailing, 4)
                        VStack(alignment: .leading) {
                            Text("Push")
                                .bold()
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                            Text("15 total sets")
                                .foregroundStyle(.white)
                            Text("3 Muscles Hit")
                                .foregroundStyle(.white)
                            Text("2 PRs")
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Text("90 min")
                            .foregroundStyle(.gray)
                    }.padding(10)
                    
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(width: geometry.size.width, height: geometry.size.height)
                .background(.black)
        }
    }
}

#Preview {
    ContentView()
}
