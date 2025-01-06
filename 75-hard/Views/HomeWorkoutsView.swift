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
            destination: AnyView(WorkoutVideoView(videoID: "d3LPrhI0v-w"))
        )
    }
}

#Preview {
    HomeWorkoutsView()
}

