//
//  ContentView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var isControllsVisible: Bool = true
    @State private var showBrowse: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ControlView(isControllsVisible: $isControllsVisible, showBrowse: $showBrowse)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// ARVIEW CONTAINER
// Wraping the ARView in a UIView Container
struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        // letting the system setup the frame by setting the frame: to .zero
        let arView = ARView(frame: .zero)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
