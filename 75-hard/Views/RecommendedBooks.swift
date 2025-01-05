//
//  RecommendedBooks.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//


import SwiftUI

struct RecommendedBooksView: View {
    var body: some View {
        ResourceDetailView(
            title: "Recommended Books",
            icon: "book.fill",
            description: "Discover a curated list of books to inspire personal growth and self-improvement.",
            tips: [
                "Set aside 20-30 minutes daily for reading.",
                "Take notes to reflect on key insights.",
                "Join a book club for accountability."
            ],
            actionButtonTitle: "View Book List",
            action: {
                            // Navigate to a list of recommended books
                            print("Viewing Recommended Books...")
                            // Example: Open a list of books or link to an external bookstore
                        }
        )
    }
}

#Preview {
    RecommendedBooksView()
}
