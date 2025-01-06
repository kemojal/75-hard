//
//  ProgressBarView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI

struct ProgressView: View {
    @State private var progressPercentage: Double = 0.8 // Sample progress
    @State private var calendarDays: [Bool] = Array(repeating: false, count: 75) // Sample data

    var body: some View {
        NavigationView {
            List {
                // Statistics Section
                Section(header: Text("Statistics").font(.headline).foregroundColor(.primary).padding(.vertical, 10)) {
                    VStack(alignment: .leading, spacing: 16) {
                        // Current Streak
                        StatisticRow(
                            icon: "flame.fill",
                            iconColor: .orange,
                            title: "Current Streak",
                            value: "5 days",
                            progress: nil
                        )

                        // Completion Rate
                        StatisticRow(
                            icon: "checkmark.circle.fill",
                            iconColor: .green,
                            title: "Completion Rate",
                            value: "85%",
                            progress: progressPercentage
                        )

                        // Most Missed Task
                        StatisticRow(
                            icon: "exclamationmark.triangle.fill",
                            iconColor: .red,
                            title: "Most Missed Task",
                            value: "Outdoor Workout",
                            progress: nil
                        )
                    }
                    .padding(.vertical, 10)
                }

                // Calendar Section
                Section(header: Text("Calendar").font(.headline).foregroundColor(.primary).padding(.vertical, 10)) {
                    CalendarView(days: calendarDays)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Statistic Row Component
struct StatisticRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    let progress: Double?

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(iconColor)
                .cornerRadius(10)
                .shadow(color: iconColor.opacity(0.3), radius: 4)

            // Title and Value
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Progress Bar (if applicable)
            if let progress = progress {
                ProgressBarView(progress: progress)
                    .frame(width: 100, height: 8)
                    .padding(.leading, 10)
            } else {
                // Placeholder for when progress is nil
                Text("N/A")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 8)
            }
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground).opacity(0.95))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.15), radius: 5)
        .animation(.easeInOut)
    }
}



// Progress Bar Component
struct ProgressBarView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                    .cornerRadius(10)
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * progress, alignment: .leading)
                    .animation(.easeInOut(duration: 0.5), value: progress)
                    .cornerRadius(10)
            }
            .frame(height: 8)
        }
    }
}


extension Color {
    static let primaryColor = Color("PrimaryColor") // Define in Assets
    static let secondaryColor = Color("SecondaryColor") // Define in Assets
}

#Preview {
    ProgressView()
}
