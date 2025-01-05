//
//  NutritionGuidelinesView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

struct NutritionGuidelinesView: View {
    var body: some View {
        ResourceDetailView(
            title: "Nutrition Guidelines",
            icon: "leaf.fill",
            description: "Understand the basics of nutrition to make informed dietary choices.",
            tips: [
                "Focus on whole, unprocessed foods.",
                "Stay hydrated by drinking plenty of water.",
                "Limit added sugars and unhealthy fats."
            ],
            actionButtonTitle: "Learn More",
            action: {
                            // Navigate to a detailed nutrition guide or external resource
                            print("Learning More About Nutrition...")
                            // Example: Open a detailed guide or link to an external website
                        }
        )
    }
}
#Preview {
    NutritionGuidelinesView() }
