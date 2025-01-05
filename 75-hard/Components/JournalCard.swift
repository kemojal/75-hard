//
//  JournalCard.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI
import UIKit
import AVFoundation

struct JournalCard: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var journalText: String = ""
    @FocusState private var focusField: Field?
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @State private var audioRecorder: AVAudioRecorder?
    @State private var isRecording = false
    @State private var checklistItems: [String] = []
    @State private var showChecklist = false
    @State private var textFormat: TextFormat = .plain
    @State private var showMoreOptions = false
    
    enum Field {
        case title
        case content
    }
    
    enum TextFormat {
        case plain
        case bold
        case italic
        case underline
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Title Field
                TextField("Title", text: $title)
                    .font(.title2)
                    .textInputAutocapitalization(.words)
                    .focused($focusField, equals: .title)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Divider()
                
                // Content Field
                TextEditor(text: $journalText)
                    .font(textFormat == .bold ? .body.bold() : textFormat == .italic ? .body.italic() : .body)
                    .underline(textFormat == .underline)
                    .focused($focusField, equals: .content)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemBackground))
                    .placeholder(when: journalText.isEmpty) {
                        Text("Start writing...")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                
                if showChecklist {
                    ChecklistView(items: $checklistItems)
                        .padding(.horizontal)
                }
                
                Divider()
                
                // Bottom Toolbar
                HStack(spacing: 25) {
                    Button(action: { toggleTextFormat() }) {
                        Image(systemName: textFormat == .bold ? "bold" : textFormat == .italic ? "italic" : textFormat == .underline ? "underline" : "textformat")
                            .font(.title3)
                    }
                    
                    Button(action: { addChecklistItem() }) {
                        Image(systemName: "checklist")
                            .font(.title3)
                    }
                    
                    Button(action: { self.showImagePicker = true }) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title3)
                    }
                    
                    Button(action: { takePhoto() }) {
                        Image(systemName: "camera")
                            .font(.title3)
                    }
                    
                    Button(action: { recordAudio() }) {
                        Image(systemName: isRecording ? "stop.circle.fill" : "waveform")
                            .font(.title3)
                            .foregroundColor(isRecording ? .red : .gray)
                    }
                    
                    Button(action: { shareJournalEntry() }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title3)
                    }
                    
                    Button(action: { self.showMoreOptions.toggle() }) {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                    }
                }
                .foregroundColor(.gray)
                .padding()
                .background(Color(.systemBackground))
                .sheet(isPresented: $showImagePicker) {
                    CustomImagePicker(selectedImage: $selectedImage)
                }
                .actionSheet(isPresented: $showMoreOptions) {
                    ActionSheet(title: Text("More Options"), buttons: [
                        .default(Text("Save Draft")),
                        .default(Text("Export as PDF")),
                        .cancel()
                    ])
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(getCurrentDate())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { /* Toggle bookmark */ }) {
                        Image(systemName: "bookmark")
                            .foregroundColor(.blue)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        saveJournalEntry()
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func toggleTextFormat() {
        switch textFormat {
        case .plain:
            textFormat = .bold
        case .bold:
            textFormat = .italic
        case .italic:
            textFormat = .underline
        case .underline:
            textFormat = .plain
        }
    }

    private func addChecklistItem() {
        showChecklist = true
        checklistItems.append("New Item")
    }

    private func takePhoto() {
        // Implement camera functionality
        print("Take photo")
    }

    private func recordAudio() {
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
        } else {
            startRecording()
            isRecording = true
        }
    }

    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentsPath.appendingPathComponent("recording.m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }

    private func shareJournalEntry() {
        let activityViewController = UIActivityViewController(activityItems: [title, journalText], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }

    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }
    
    private func saveJournalEntry() {
        print("Saving journal entry - Title: \(title), Content: \(journalText)")
    }
}

// Checklist View
struct ChecklistView: View {
    @Binding var items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<items.count, id: \.self) { index in
                HStack {
                    Image(systemName: "circle")
                    TextField("Checklist item", text: $items[index])
                }
            }
        }
    }
}

// CustomImagePicker for selecting images
struct CustomImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CustomImagePicker
        
        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.selectedImage = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// Extension for TextEditor placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct JournalCard_Previews: PreviewProvider {
    static var previews: some View {
        JournalCard()
    }
}


#Preview{
    JournalCard()
}
