//
//  ContentView.swift
//  AccessibilityApp
//
//  Created by Ifang Lee on 2/14/22.
//
/**
 How active VoiceOver user use the app:
 1. they are remarkably adept at navigating around user interfaces,
 2. they also often set reading speed extremely fast

 ways to adopt:
 Marking images as being unimportant for VoiceOver.
 Hiding views from the accessibility system.
 Grouping several views as one.
 */
import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var value = 10

    var body: some View {
        VStack {
            Image(decorative: "myFutureNoodles") //ignored by VoiceOver
                .accessibilityHidden(true) //make the view complete invisible to VoiceOver
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            //.accessibilityElement(children: .combine) //read two lines together with little pause
            .accessibilityElement(children: .ignore) // alternatives to use combine children
            .accessibilityLabel("Your score is 1000") //no pause
            //.ignore is the default parameter for children: .accessibilityElement(children: .ignore) == .accessibilityElement().

            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)

            VStack {
                Text("Value: \(value)")
                HStack {
                    Button("Increment") {
                        value += 1
                    }
                    Button("Decrement") {
                        value -= 1
                    }
                }
            }
            .accessibilityElement() //ignore VoiceOver
            .accessibilityLabel("Value")
            .accessibilityValue(String(value))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not handled.")
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
