//
//  CameraManager.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI
import AVFoundation
import Photos

class CameraManager: ObservableObject {
    @Published var photo: UIImage?
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var cameraAccess = false
    @Published var showImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    
    init() {
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.cameraAccess = true
        case .notDetermined:
            requestCameraAccess()
        case .denied, .restricted:
            self.showError = true
            self.errorMessage = "Camera access is required. Please enable it in Settings."
        @unknown default:
            break
        }
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                self?.cameraAccess = granted
                if !granted {
                    self?.showError = true
                    self?.errorMessage = "Camera access is required to take progress photos"
                }
            }
        }
    }
    
    func takePhoto() {
        guard cameraAccess else {
            checkPermissions()
            return
        }
        sourceType = .camera
        showImagePicker = true
    }
    
    func chooseFromLibrary() {
        sourceType = .photoLibrary
        showImagePicker = true
    }
}

// ImagePicker using UIKit integration
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImage: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// PhotoCaptureView using CameraManager
struct PhotoCaptureView: View {
    @StateObject private var cameraManager = CameraManager()
    @Binding var capturedImage: UIImage?
    let onSave: (UIImage) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.6)
                } else {
                    PhotoPlaceholderView()
                }
                
                HStack(spacing: 40) {
                    Button(action: {
                        cameraManager.takePhoto()
                    }) {
                        VStack {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 30))
                            Text("Camera")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        cameraManager.chooseFromLibrary()
                    }) {
                        VStack {
                            Image(systemName: "photo.fill")
                                .font(.system(size: 30))
                            Text("Library")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Color.green)
                        .clipShape(Circle())
                    }
                }
            }
            .padding()
            .navigationTitle("Take Progress Photo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    if let image = capturedImage {
                        onSave(image)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(capturedImage == nil)
            )
            .sheet(isPresented: $cameraManager.showImagePicker) {
                ImagePicker(
                    selectedImage: $capturedImage,
                    sourceType: cameraManager.sourceType
                )
            }
            .alert(isPresented: $cameraManager.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(cameraManager.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct PhotoPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text("Take your daily progress photo")
                .font(.headline)
            
            Text("Front, side, or back view in good lighting")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10)
        )
        .padding()
    }
}
