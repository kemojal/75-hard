//
//  ReadingTips.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

struct ReadingTipsView: View {
    var body: some View {
        ResourceDetailView(
            title: "Reading Tips",
            icon: "lightbulb.fill",
            description: "Learn how to make reading a consistent and enjoyable habit.",
            tips: [
                "Choose books that align with your interests.",
                "Use a bookmark to track your progress.",
                "Read in a quiet, comfortable environment."
            ],
            actionButtonTitle: "Get Started",
            action: {
                            // Navigate to a detailed nutrition guide or external resource
                            print("Reding tips...")
                            // Example: Open a detailed guide or link to an external website
                        }
        )
    }
}


