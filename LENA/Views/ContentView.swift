//
//  ContentView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI
import RealityKit
import simd

struct ContentView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @State private var isControllsVisible: Bool = true
    @State private var showBrowse: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            if self.placementSettings.selectedModel == nil {
                ControlView(isControllsVisible: $isControllsVisible, showBrowse: $showBrowse)
            } else {
                PlacementView()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// ARVIEW CONTAINER
// Wraping the ARView in a UIView Container
struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    func makeUIView(context: Context) -> CustomARView {
        
        // letting the system handel setting up the frame: to .zero
        let arView = CustomARView(frame: .zero)
        
        // Subscribe to SceneEvents.Update
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (Event) in
            // Call updateScene method
            self.updateScene(for: arView)
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        // Only display focusEntity when the user has selected a model for placement
        arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        // Add model to the scene if user confirmed placement
        if let confirmedModel = self.placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity {
            
            // Call place method
            self.place(modelEntity, in: arView)
            
            self.placementSettings.confirmedModel = nil
        }
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        
        ///1. Clone modelEntity. This creates an identical copy of modelEntity and references the same model. This also allows us to have multiple models of the same asset in our scene.
        let cloneEntity = modelEntity.clone(recursive: true)
        
        ///2. Enable translation and rotaion gestures.
        cloneEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation], for: cloneEntity)
        
        ///3. Create an anchorEntity and add clonedEntity to the anchorEntity.
        let anchorEntity = AnchorEntity(world: matrix_identity_float4x4)
        anchorEntity.addChild(cloneEntity)
        
        ///4. Add the anchorEntity the arView.scene.
        arView.scene.addAnchor(anchorEntity)
        
        print("Added modelEntity to scene.")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlacementSettings())
    }
}
