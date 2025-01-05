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
            destination: AnyView(BookListView())
        )
    }
}

// MARK: - Book List View



// MARK: - Book Row

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack(spacing: 12) {
            // Book Cover Image
            Image(book.coverImage)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 90)
                .cornerRadius(8)
                .shadow(radius: 3)

            // Book Details
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(book.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }

            Spacer()

            // Chevron Icon
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Book Model



// MARK: - Search Bar

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}


#Preview {
    RecommendedBooksView()
}
