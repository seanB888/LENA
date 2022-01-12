//
//  PlacementView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/12/22.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        HStack {
            Spacer()
            PlacementButton(systemIcanName: "xmark.circle.fill") {
                print("Cancel placement button pressed")
                self.placementSettings.selectedModel = nil
            }
            Spacer()
            PlacementButton(systemIcanName: "checkmark.circle.fill") {
                print("Confirm placement button pressed")
                
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                
                self.placementSettings.selectedModel = nil
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct PlacementButton: View {
    let systemIcanName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: systemIcanName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}
