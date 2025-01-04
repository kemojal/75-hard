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
            List {
                Section(header: Text("Daily Tasks")) {
                    ForEach(viewModel.currentDay.tasks) { task in
                        TaskRowView(task: task) {
                            viewModel.toggleTask(task)
                        }
                    }
                }
                
                Section(header: Text("Progress")) {
                    ProgressBarView(progress: calculateDailyProgress())
                }
                
                Section(header: Text("Journal")) {
                    JournalEntryView()
                }
            }
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
#Preview {
    TodayView()
}


