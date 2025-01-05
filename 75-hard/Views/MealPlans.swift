//
//  MealPlans.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

struct MealPlansView: View {
    var body: some View {
        ResourceDetailView(
            title: "Meal Plans",
            icon: "fork.knife",
            description: "Follow these balanced meal plans to fuel your body and achieve your fitness goals.",
            tips: [
                "Plan your meals ahead of time.",
                "Include a variety of fruits, vegetables, and proteins.",
                "Stay consistent with your meal schedule."
            ],
            actionButtonTitle: "View Meal Plans",
            destination: AnyView(MealPlansListView())
        )
    }
}
#Preview { MealPlansView() }

