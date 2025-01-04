//
//  JournalEntryView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI

struct JournalEntryView: View {
    @State private var journalText = ""
    
    var body: some View {
        TextEditor(text: $journalText)
            .frame(height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2))
            )
            .padding(.vertical, 4)
    }
}
