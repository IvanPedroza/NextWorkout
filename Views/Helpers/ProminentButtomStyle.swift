//
//  ProminentButtomStyle.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 8/2/24.
//

import Foundation
import SwiftUI

struct ProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}
