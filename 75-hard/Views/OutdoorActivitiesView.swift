//
//  OutdoorActivitiesView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//

import SwiftUI

struct OutdoorActivitiesView: View {
    var body: some View {
        ResourceDetailView(
            title: "Outdoor Activities",
            icon: "figure.walk",
            description: "Explore fun and effective outdoor activities to stay active and enjoy nature.",
            tips: [
                "Try hiking, cycling, or jogging in a park.",
                "Incorporate interval training for better results.",
                "Stay hydrated and wear appropriate gear."
            ],
            actionButtonTitle: "Explore Activities",
            action: {
                            // Navigate to a list of outdoor activities or suggest nearby locations
                            print("Exploring Outdoor Activities...")
                            // Example: Open a map with nearby parks or trails
                        }
        )
    }
}

#Preview { OutdoorActivitiesView() }
