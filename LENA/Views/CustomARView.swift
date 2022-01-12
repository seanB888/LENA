//
//  CustomARView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/12/22.
//

import SwiftUI
import ARKit
import FocusEntity
import RealityKit

class CustomARView: ARView {
    
    // focus entity property
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config)
    }
}
