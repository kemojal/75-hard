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
            destination: AnyView(WorkoutVideoView(videoID: "d3LPrhI0v-w"))
        )
    }
}

#Preview { OutdoorActivitiesView() }
