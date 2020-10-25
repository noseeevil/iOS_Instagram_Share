//
//  ContentView.swift
//  Picker
//
//  Created by noseeevil on 25.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var section = 0
    @State var procentSection = 0
    @State var isOn = false
    
    var settingsTime = ["5 min", "10 min", "15 min"]
    var procents = ["5 procents", "50 procents", "100 procents"]
    
    
    var body: some View {
        NavigationView{
            Form {
                Picker(selection: $section, label: Text("Time")) {
                    ForEach(0..<settingsTime.count) {
                        Text(self.settingsTime[$0])
                    }
                }
                
                Toggle(isOn: $isOn) {
                    Text("Aviamode").foregroundColor(isOn ? Color.gray : Color.orange)
                }
                
                Picker(selection: $procentSection, label: Text("Подсветка")) {
                    ForEach(0..<100) {
                        Text("item = \($0)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
