//
//  ChallengeViewModel.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI

class ChallengeViewModel: ObservableObject {
    @Published var currentDay: DailyProgress
    @Published var allProgress: [DailyProgress]
    @Published var currentStreak: Int = 0
    
    init() {
        self.currentDay = DailyProgress(id: UUID(), date: Date(), tasks: [
            Task(id: UUID(), name: "First Workout", isCompleted: false, type: .workout1),
            Task(id: UUID(), name: "Outdoor Workout", isCompleted: false, type: .workout2),
            Task(id: UUID(), name: "Drink Water", isCompleted: false, type: .water),
            Task(id: UUID(), name: "Read", isCompleted: false, type: .reading),
            Task(id: UUID(), name: "Follow Diet", isCompleted: false, type: .diet),
            Task(id: UUID(), name: "Take Photo", isCompleted: false, type: .photo)
        ])
        self.allProgress = []
    }
    
    func toggleTask(_ task: Task) {
        if let index = currentDay.tasks.firstIndex(where: { $0.id == task.id }) {
            currentDay.tasks[index].isCompleted.toggle()
        }
    }
    
    func updateTaskPhoto(taskId: UUID, photoData: Data) {
        if let index = currentDay.tasks.firstIndex(where: { $0.id == taskId }) {
            var updatedTask = currentDay.tasks[index]
            updatedTask.photoData = photoData
            currentDay.tasks[index] = updatedTask
        }
    }
}


