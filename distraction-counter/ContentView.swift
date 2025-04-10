//
//  ContentView.swift
//  distraction-counter
//
//  Created by Samuel Fahim on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @State var DCounter = 0;
    
    var increment: Int {
        DCounter = DCounter + 1
        return DCounter
    }
    
    var decrement: Int {
        DCounter = DCounter - 1
        return DCounter
    }
    
    @State var dist = ""
    @State var distList: [String] = []
    
    var body: some View {
        VStack {
            
            // TODO: rename to distraction buddy

           TextField("What's distracting you today?", text: $dist)
                .padding(.all, 5)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 300, height: 50)
                .onSubmit {
                    distList.append(dist)
                }
            
            Text("You've been distracted: \(DCounter) times. Congrats!")
            
            ForEach(Array(distList.enumerated()), id: \.offset) { index, item in
                distItem(
                    Action: { increment },
                    Action2: { decrement },
                    Label1: Text(item)
                )
            }
            
            
            Button(action: {DCounter = 0}, label: {Text("Day's Over, See you tomorrow!")})
                .frame(width: 300,  alignment: .leading)
        }.padding()
    }
}

struct distItem: View{
    var Action = {print("Oops!")}
    var Action2 = {print("Oops!")}
    var Label1: Text = Text("I got distracted!")
    var Label2: Text = Text("X")
    var body: some View{
        HStack{
            Button(action: {Action()}, label: {Label1})
            Button(action: {Action2()}, label: {Label2})
            
        }.frame(width: 300, alignment: .leading)
    }
}

#Preview {
    ContentView()
}
