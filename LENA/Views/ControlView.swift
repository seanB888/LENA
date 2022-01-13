//
//  ControlView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControllsVisible: Bool
    @Binding var showBrowse: Bool
    
    var body: some View {
        VStack {
        
            ControlVisibilityToggleButton(isControllsVisible: $isControllsVisible, showBrowse: $showBrowse)
        
            Spacer()
            
            if isControllsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControllsVisible: Bool
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button(action: {
                    print("Control Visibility toggle button pressed")
                    self.isControllsVisible.toggle()
                }) {
                    Image(systemName: self.isControllsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            // MostRecentlyPlaced button (this button start out hidden until an object has been placed on the seen.
            mostRecentlyPlaceButton().hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            // Browse buttton
            ControlButton(imageIcon: "square.grid.2x2") {
                print("Browse button pressed.")
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse) {
                BrowseView(showbrowse: $showBrowse)
            }
            
            
            Spacer()
            // Settings button
            ControlButton(imageIcon: "slider.horizontal.3") {
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

struct mostRecentlyPlaceButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        Button(action: {
            print("mostRecentlyPlaceButton pressed")
            // allows to place multiple models im an ARView scene
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }) {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                // if not empty
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46)
                    .aspectRatio(1/1, contentMode: .fit)
            } else {
                // if there is no image
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(width: 50, height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
    }
}
