//
//  CalendarView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//

import SwiftUI

struct CalendarView: View {
    let days: [Bool]
    @State private var selectedDay: Int? = nil
    @State private var showDayDetails: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("75 Hard Challenge Progress")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)

            // Grid Layout for Days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 7), spacing: 10) {
                ForEach(0..<75, id: \.self) { index in
                    DayView(day: index + 1, isCompleted: days[index], isSelected: selectedDay == index)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                selectedDay = index
                                showDayDetails = true
                            }
                        }
                }
            }
            .padding(.horizontal, 20)

            // Selected Day Details
            if let selectedDay = selectedDay, showDayDetails {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Day \(selectedDay + 1)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: days[selectedDay] ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(days[selectedDay] ? .green : .red)
                            .font(.system(size: 24))
                    }

                    Text(days[selectedDay] ? "You crushed it! Keep going!" : "You missed this day. Reflect and restart.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)

                    if !days[selectedDay] {
                        Button(action: {
                            // Action to restart the challenge
                        }) {
                            Text("Restart Challenge")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)
                .transition(.opacity.combined(with: .scale(scale: 0.9))) // Smooth transition
            }
        }
        .padding(.vertical, 20)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
        .padding(.horizontal, 10)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// Day View Component
struct DayView: View {
    let day: Int
    let isCompleted: Bool
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isCompleted ? LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                )
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: isSelected)

            Text("\(day)")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(isCompleted ? .white : .primary)
        }
    }
}

// Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(days: Array(repeating: false, count: 75))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
