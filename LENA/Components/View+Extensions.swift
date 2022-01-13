//
//  View+Extensions.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/12/22.
//

import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
