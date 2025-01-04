//
//  TaskRowView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                if let notes = task.notes {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: .constant(task.isCompleted))
                .labelsHidden()
                .onTapGesture(perform: onToggle)
        }
    }
}
//#Preview {
//    TaskRowView(task: Task(id: UUID(), name: "Task", isCompleted: true, type: Task.TaskType(rawValue: "First Workout") ?? "cccc", notes: "Notes"), onToggle: {})
//}
