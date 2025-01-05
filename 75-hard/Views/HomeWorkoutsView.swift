//
//  HomeWorkoutsView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

struct HomeWorkoutsView: View {
    var body: some View {
        ResourceDetailView(
            title: "Home Workouts",
            icon: "house.fill",
            description: "Stay fit at home with these no-equipment workouts that target all major muscle groups.",
            tips: [
                "Create a dedicated workout space.",
                "Follow along with online workout videos.",
                "Track your progress to stay motivated."
            ],
            actionButtonTitle: "Start Home Workout",
            action: {
                           // Navigate to a workout video or start a workout session
                           print("Starting Beginner home Workout...")
                           // Example: Open a workout video or start a timer
                       }
        )
    }
}

