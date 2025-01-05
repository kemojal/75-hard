//
//  BeginnerWorkoutsView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//

import SwiftUI
struct BeginnerWorkoutsView: View {
    var body: some View {
        ResourceDetailView(
            title: "Beginner Workouts",
            icon: "dumbbell.fill",
            description: "Start your fitness journey with these beginner-friendly workouts designed to build strength and endurance.",
            tips: [
                "Warm up for 5-10 minutes before starting.",
                "Focus on proper form to avoid injuries.",
                "Start with 2-3 sessions per week and gradually increase."
            ],
            actionButtonTitle: "Start Workout",
            action: {
                           // Navigate to a workout video or start a workout session
                           print("Starting Beginner Workout...")
                           // Example: Open a workout video or start a timer
                       }
        )
    }
    
}
#Preview { BeginnerWorkoutsView() }
