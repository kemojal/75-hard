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
    @State private var isPressed = false
    @Namespace private var animation
    @State private var showPhotoCapture = false
    @State private var capturedImage: UIImage?
    @Binding var photoData: Data? // Add this binding
    
//    var body: some View {
//        VStack(spacing: 0) {
//            Button(action: onToggle) {
//                HStack(spacing: 16) {
//                    // Task Status Indicator
//                    Circle()
//                        .strokeBorder(task.isCompleted ? Color.green : Color.gray.opacity(0.3), lineWidth: 2)
//                        .background(
//                            Circle()
//                                .fill(task.isCompleted ? Color.green : Color.clear)
//                                .overlay(
//                                    Image(systemName: "checkmark")
//                                        .font(.system(size: 12, weight: .bold))
//                                        .foregroundColor(.white)
//                                        .opacity(task.isCompleted ? 1 : 0)
//                                )
//                        )
//                        .frame(width: 28, height: 28)
//                        .matchedGeometryEffect(id: "checkbox\(task.id)", in: animation)
//                    
//                    // Task Content
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(task.name)
//                            .font(.system(size: 17, weight: .semibold))
//                            .foregroundColor(task.isCompleted ? .gray : .primary)
//                        
//                        // Task Type Indicator
//                        HStack(spacing: 6) {
//                            Image(systemName: taskTypeIcon(for: task.type))
//                                .font(.system(size: 12))
//                            Text(task.type.rawValue)
//                                .font(.system(size: 13))
//                        }
//                        .foregroundColor(.gray)
//                    }
//                    
//                    Spacer()
//                    
//                    // Progress or Time Indicator (if applicable)
//                    if let progressText = progressText(for: task.type) {
//                        Text(progressText)
//                            .font(.system(size: 15, weight: .medium))
//                            .foregroundColor(.blue)
//                    }
//                }
//                .padding(.vertical, 16)
//                .padding(.horizontal, 20)
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(Color(UIColor.systemBackground))
//                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(task.isCompleted ? Color.green.opacity(0.2) : Color.gray.opacity(0.1), lineWidth: 1)
//                )
//            }
//            .buttonStyle(TaskButtonStyle())
//            .padding(.horizontal, 16)
//            .padding(.vertical, 6)
//        }
//    }
    
    var body: some View {
            VStack(spacing: 0) {
                Button(action: {
                    if task.type == .photo {
                        showPhotoCapture = true
                    } else {
                        onToggle()
                    }
                }) {
                    HStack(spacing: 16) {
                        // Status Indicator
                        Circle()
                            .strokeBorder(task.isCompleted ? Color.green : Color.gray.opacity(0.3), lineWidth: 2)
                            .background(
                                Circle()
                                    .fill(task.isCompleted ? Color.green : Color.clear)
                                    .overlay(
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                            .opacity(task.isCompleted ? 1 : 0)
                                    )
                            )
                            .frame(width: 28, height: 28)
                        
                        // Task Content
                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.name)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                            
                            HStack(spacing: 6) {
                                Image(systemName: taskTypeIcon(for: task.type))
                                    .font(.system(size: 12))
                                Text(task.type.rawValue)
                                    .font(.system(size: 13))
                            }
                            .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        // Photo Preview if available
                        if task.type == .photo, let photoData = photoData, let uiImage = UIImage(data: photoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor.systemBackground))
                            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                    )
                }
                .buttonStyle(TaskButtonStyle())
                .sheet(isPresented: $showPhotoCapture) {
                    PhotoCaptureView(capturedImage: $capturedImage) { image in
                        if let imageData = image.jpegData(compressionQuality: 0.8) {
                            photoData = imageData
                            onToggle() // Mark task as completed
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
        }
        
    private func taskTypeIcon(for type: Task.TaskType) -> String {
        switch type {
        case .workout1: return "figure.walk"
        case .workout2: return "figure.hiking"
        case .water: return "drop.fill"
        case .reading: return "book.fill"
        case .diet: return "leaf.fill"
        case .photo: return "camera.fill"
        }
    }
    
    private func progressText(for type: Task.TaskType) -> String? {
        switch type {
        case .workout1, .workout2:
            return "45 min"
        case .water:
            return "1 gal"
        case .reading:
            return "10 pgs"
        default:
            return nil
        }
    }
}

struct TaskButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
//#Preview {
//    TaskRowView(task: Task(id: UUID(), name: "Task", isCompleted: true, type: Task.TaskType(rawValue: "First Workout") ?? "cccc", notes: "Notes"), onToggle: {})
//}
