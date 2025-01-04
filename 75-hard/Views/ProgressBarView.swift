//
//  ProgressBarView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI


struct ProgressView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Statistics")) {
                    VStack(alignment: .leading) {
                        Text("Current Streak: 5 days")
                        Text("Completion Rate: 85%")
                        Text("Most Missed Task: Outdoor Workout")
                    }
                }
                
                Section(header: Text("Calendar")) {
                    Text("Calendar View Coming Soon")
                }
            }
            .navigationTitle("Progress")
        }
    }
}

struct ProgressBarView: View {
    let progress: Double
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * progress)
                }
            }
            .frame(height: 20)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("\(Int(progress * 100))% Complete")
                .font(.caption)
        }
    }
}
#Preview {
    ProgressBarView(progress: 0.5)
}
