//
//  ContentView.swift
//  Alert&ActionSheet
//
//  Created by noseeevil on 25.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isError = false
    
    var body: some View {
        //showAсtionSheet()
        //showAlert()
        Text("hello").padding()
    }
    
    fileprivate func showAlert() -> some View {
        return Button(action: {
            self.isError = true
        }, label: {
            Text("Enter")
        }).alert(isPresented: $isError, content: {
            Alert(title: Text("Some message"))
        })
    }
    
    fileprivate func showAсtionSheet() -> some View {
        return Button(action: {
            self.isError = true
        }, label: {
                Text("Enter")
        }).actionSheet(isPresented: $isError, content: {
            ActionSheet(title: Text("Loading"),
                        message: Text("Do you want to start the download?"),
                        buttons: [
                            .destructive(Text("Load"),
                            action: {print("download started")}),
                            .cancel()])
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
