/// This is the old (iOS 13) version.
/// This has a "bug" where adding a second finger freezes the touch event.
/// However, according to Apple, this "bug" is intended.
/// In the new iOS 14 version, we use GestureState instead, which gets around this "bug"

/// Forums post (with Apple reply): https://developer.apple.com/forums/thread/660070
/// New iOS 14 version: https://gist.github.com/aheze/3d5820c03616d25e21376ad561798e9e

/// if you're on iPad Swift Playgrounds and you put all of this code in a seperate file,
/// you need to make everything public so that the compiler detects it.

import SwiftUI
/// the possible states of the button
public enum ButtonState {
    case pressed
    case notPressed
}

/// ViewModifier allows us to get a view, then modify it and return it
public struct TouchDownUpEventModifier: ViewModifier {
    
    /// Later, .onChanged will be called multiple times (around 10 times a second once your finger touches down)
    /// so we need a variable to keep track of the first time your finger touches down...
    /// ... we then set this to false when your finger lifts up, so the cycle can repeat again
    @State private var pressed = false
    
    /// this is the closure that will get passed around.
    /// we will update the ButtonState every time your finger touches down or up.
    let changeState: (ButtonState) -> Void
    
    /// a required function for ViewModifier.
    /// content is the body content of the caller view
    public func body(content: Content) -> some View {
        
        /// prepare to add the gesture to the the body content
        content
        
        /// we need to detect both .onChanged and .onEnded
        /// so we modify the original content by adding a gesture to it
        .gesture(DragGesture(minimumDistance: 0)
            
            /// equivalent to UIKit's Touch Down event, but is called continuously once your finger moves while still on the screen.
            /// It will be called a lot, so we need a bool to make sure we change the state only when your finger first touches down
            .onChanged { _ in
                
                /// this will make sure that we only pass the new state one time
                if !self.pressed {
                    
                    /// we lock the state to "pressed" so that it won't be set continuously by .onChanged. We will enable it to be changed once the user lifts their finger.
                    self.pressed = true
                    
                    /// pass the new state to the caller
                    self.changeState(ButtonState.pressed)
                }
            }
                
                
            /// equivalent to both UIKit's Touch Up Inside and Touch Up Outside event
            .onEnded { _ in
                
                /// we enable "pressed" to be changed now to allow another cycle of finger down/up events.
                self.pressed = false
                
                /// pass the new state to the caller
                self.changeState(ButtonState.notPressed)
            }
        )
    }
    
    /// if you're on iPad Swift Playgrounds and you put all of this code in a seperate file,
    /// you need to add a public init so that the compiler detects it.
    public init(changeState: @escaping (ButtonState) -> Void) {
        self.changeState = changeState
    }
}
