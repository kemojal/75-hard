//
//  ResourceDetailView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

struct ResourceDetailView: View {
    let title: String
    let icon: String
    let description: String
    let tips: [String]
    let actionButtonTitle: String
    let action: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)

                    Text(title)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                }
                .padding(.bottom, 10)

                // Description
                Text(description)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineSpacing(5)

                // Tips
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tips")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)

                    ForEach(tips, id: \.self) { tip in
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 8))
                                .foregroundColor(.blue)
                                .padding(.top, 8)
                            Text(tip)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.primary)
                                .lineSpacing(5)
                        }
                    }
                }

                // Action Button
                Button(action: action) {
                    Text(actionButtonTitle)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle(title)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
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
