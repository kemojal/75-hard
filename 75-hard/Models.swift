//
//  Models.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//

import SwiftUI

struct Task: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var type: TaskType
    var notes: String?
    var photoData: Data? // Add this for storing photos
    
    enum TaskType: String, Codable {
        case workout1 = "First Workout"
        case workout2 = "Second Workout (Outdoor)"
        case water = "Gallon of Water"
        case reading = "Read 10 Pages"
        case diet = "Follow Diet"
        case photo = "Progress Photo"
    }
}

struct DailyProgress: Identifiable, Codable {
    let id: UUID
    var date: Date
    var tasks: [Task]
    var journalEntry: String?
    var progressPhoto: Data?
    var isCompleted: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
}
