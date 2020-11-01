//
//  ContentView.swift
//  ActivityView
//
//  Created by noseeevil on 01.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var isSharePresented = false
    
    let customActivity = ActivityViewCustomActivity(title: "telegram", imageName: "telegram") {
        print("")
    }
    
    var body: some View {
        Button("Share") {
            self.isSharePresented = true
        }.sheet(isPresented: $isSharePresented) {
            ActivityView(activityItems: ["message"], applicatioActivities: [self.customActivity])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
