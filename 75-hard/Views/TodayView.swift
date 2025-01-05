//
//  TodayView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = ChallengeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Daily Progress Card
                    DailyProgressCard(progress: calculateDailyProgress())
                        .padding(.top, 8)
                    
                    // Tasks Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's Tasks")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                        
                        ForEach(viewModel.currentDay.tasks) { task in
                            TaskRowView(
                                task: task,
                                onToggle: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        viewModel.toggleTask(task)
                                    }
                                    
                                    let generator = UIImpactFeedbackGenerator(style: .light)
                                    generator.impactOccurred()
                                },
                                photoData: Binding(
                                    get: { task.photoData },
                                    set: { newValue in
                                        viewModel.updateTaskPhoto(taskId: task.id, photoData: newValue ?? Data())
                                    }
                                )
                            )
                        }
                    }
                    
                    // Journal Section
                    JournalCard()
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Day \(calculateDay())")
        }
    }
    
    private func calculateDailyProgress() -> Double {
        let completed = Double(viewModel.currentDay.tasks.filter { $0.isCompleted }.count)
        return completed / Double(viewModel.currentDay.tasks.count)
    }
    
    private func calculateDay() -> Int {
        return 1
    }
}

struct DailyProgressCard: View {
    let progress: Double
    
    var body: some View {
        VStack(spacing: 16) {
            // Progress Ring
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .green]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 4) {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 28, weight: .bold))
                    Text("Complete")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 120, height: 120)
            .padding()
            
            // Stats Row
            HStack(spacing: 24) {
                StatItem(value: "5", title: "Streak", icon: "flame.fill", color: .orange)
                StatItem(value: "70", title: "Days Left", icon: "calendar", color: .blue)
                StatItem(value: "85%", title: "Success", icon: "chart.bar.fill", color: .green)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 16)
    }
}

struct StatItem: View {
    let value: String
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

struct JournalCard: View {
    @State private var journalText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Daily Journal")
                .font(.headline)
            
            TextEditor(text: $journalText)
                .frame(height: 100)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2))
                )
            
            Button(action: {
                // Save journal entry
            }) {
                Text("Save Entry")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 16)
    }
}

struct TaskDetailView: View {
    let task: Task
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Task details implementation
                }
            }
            .navigationTitle(task.name)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


#Preview {
    TodayView()
}


