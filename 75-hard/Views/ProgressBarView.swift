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
                Section(header: Text("Statistics").font(.headline).foregroundColor(.primary)) {
                    VStack(alignment: .leading, spacing: 15) {
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
                    .padding(.horizontal, 15)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    .padding(.vertical, 5)
                }

                // Calendar Section
                Section(header: Text("Calendar").font(.headline).foregroundColor(.primary)) {
                    CalendarView(days: calendarDays)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



// ProgressBarView with animation
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
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(iconColor)
                .frame(width: 30, height: 30)
                .background(iconColor.opacity(0.1))
                .cornerRadius(8)

            // Title and Value
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text(value)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Progress Bar (if applicable)
            if let progress = progress {
                ProgressBarView(progress: progress)
                    .frame(width: 100, height: 8)
            }
        }
        .padding(.vertical, 8)
    }
}

// ProgressBarView with animation
struct ProgressBarView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * progress, alignment: .leading)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0), value: progress)
            }
            .cornerRadius(10)
        }
        .frame(height: 8)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// Preview
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Progress View")
            
            StatisticRow(
                icon: "flame.fill",
                iconColor: .orange,
                title: "Sample Stat",
                value: "42",
                progress: 0.75
            )
            .previewLayout(.fixed(width: 375, height: 100))
            .previewDisplayName("Statistic Row")
            
            ProgressBarView(progress: 0.8)
                .previewLayout(.fixed(width: 200, height: 20))
                .previewDisplayName("Progress Bar")
        }
    }
}

extension Color {
    static let primaryColor = Color("PrimaryColor") // Define in Assets
    static let secondaryColor = Color("SecondaryColor") // Define in Assets
}
