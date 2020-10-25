//
//  ContentView.swift
//  Slider&ObservableObject&Published&MVVM
//
//  Created by noseeevil on 25.10.2020.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?

    public func play() {
        playSoung(name: "Alexei_Scene_1_Take_5")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSoung(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "wav") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


struct ContentView: View {
    @State private var progress: Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    
    
    var body: some View {
        VStack {
            
            Slider(value: Binding(get: {
                Double(self.progress)
            }, set: {newValue in
                self.progress = Float(newValue)
                self.viewModel.setTime(value: Float(newValue))
            }), in: 0...viewModel.maxDuration).padding()
            
            HStack {
                Button(action: {
                    print("start")
                    self.viewModel.play()
                }, label: {
                    Text("Play").foregroundColor(.blue)
                })
                .frame(width: 100, height: 50)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button(action: {
                    print("stop")
                    self.viewModel.stop()
                }, label: {
                    Text("Stop").foregroundColor(.blue)
                })
                .frame(width: 100, height: 50)
                .background(Color.orange)
                .cornerRadius(10)
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
