//
//  Cardify.swift
//  Memory
//
//  Created by Matthew Hopkins on 11/6/23.
//

import SwiftUI

// AnimatableModifier is just a combo of the Animatable and ViewModifier protocols
struct Cardify: AnimatableModifier {
    // views that use this think in terms of isFaceUp-ness and rotation (for animating).
    // init is a convenience for views that use this
    // (just turn isFaceUp to the appropriate rotation).
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // the var in the Animatable protocol (which the protocol AnimatableModifier inherits).
    // in this case, it's computed to set/get the value of the rotation var
    // (since the rotation is the thing being animated).
    // this will be called repeatedly as the animation system breaks
    // the rotation into little pieces
    // (and the body will get invalidated and recalculated)
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    // how far around (in degrees)
    // from 0 (fully face up) to 180 (fully face down)
    var rotation: Double // in degrees
    
    // the body
    // what's on the card is the given content argument
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            // don't put this inside the "if rotation < 90" because
            // the content shouldn't be removed and put back into the UI all the time.
            // it stays in the UI, but is hidden from the user when face down
            // (i.e. opacity = 0 when rotation >= 90).
            // any animations on content can be started even while face down
            // (even though it's hiding until the card goes back face up)
            // otherwise, only changes to the content while face up can be animated
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        // above it's showing or hiding the front/back as rotation passes 90
        // here it's doing the actual 3D rotation effect for however many degrees rotated
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

// add the cardify(isFaceUp:) func to the View protocol
// syntactic sugar for views that use the Cardify view modifier
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
