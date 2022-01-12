//
//  BrowseView.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI

struct BrowseView: View {
    @Binding var showbrowse: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // GridView for thumbnails
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
            Button(action: {
            self.showbrowse.toggle()
            }) {
                Text("Done").bold()
            })
    }
}
