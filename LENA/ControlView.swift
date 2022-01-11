//
//  ControlView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        VStack {
        
            ControlVisibilityToggleButton()
        
            Spacer()
            
            ControlButtonBar()
        }
    }
}

struct ControlVisibilityToggleButton: View {
    var body: some View {
        HStack {
            
        }
    }
}

struct ControlButtonBar: View {
    var body: some View {
        HStack {
           
            ControlButton(imageIcon: "clock.fill") {
                print("Recent button pressed.")
            }
            
            Spacer()
            
            ControlButton(imageIcon: "square.grid.2x2") {
                print("Browse button pressed.")
            }
            
            
            Spacer()
            
            ControlButton(imageIcon: "clock") {
                print("Settings button pressed.")
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    let imageIcon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: imageIcon)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
    }
}
