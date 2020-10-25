//
//  ContentView.swift
//  Toggle
//
//  Created by noseeevil on 25.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var isOnToggle = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        Text("Кошелек")
                        Text("Кошелек")
                        Spacer().frame(height: 500)
                    }
                    Spacer()
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10).fill(Color.orange).offset(x: isOnToggle ? 100 : 0)
                Text("Что-то на экране").offset(x: isOnToggle ? 100 : 0)
            }
            Toggle(isOn: $isOnToggle, label: {
                Text("Показать настройки")
            }).padding()
        }.animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
