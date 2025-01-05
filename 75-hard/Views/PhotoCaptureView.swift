////
////  PhotoCaptureView.swift
////  75-hard
////
////  Created by Kemo Jallow on 2025/1/4.
////
//import SwiftUI
//
//struct PhotoCaptureView: View {
//    @StateObject private var cameraManager = CameraManager()
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var capturedImage: UIImage?
//    @State private var sourceType: UIImagePickerController.SourceType = .camera
//    @State private var showImagePicker = false
//    @State private var showOptions = false
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                if let image = capturedImage {
//                    // Preview captured image
//                    PreviewImageView(image: image)
//                } else {
//                    // Placeholder or instructions
//                    PhotoPlaceholderView()
//                }
//                
//                // Camera Controls
//                CameraControlsView(
//                    showImagePicker: $showImagePicker,
//                    sourceType: $sourceType,
//                    showOptions: $showOptions
//                )
//            }
//            .navigationTitle("Progress Photo")
//            .navigationBarItems(
//                leading: Button("Cancel") {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                trailing: Button("Save") {
//                    savePhoto()
//                }
//                .disabled(capturedImage == nil)
//            )
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: $capturedImage, sourceType: sourceType)
//            }
//            .actionSheet(isPresented: $showOptions) {
//                ActionSheet(
//                    title: Text("Choose Photo Source"),
//                    buttons: [
//                        .default(Text("Camera")) {
//                            sourceType = .camera
//                            showImagePicker = true
//                        },
//                        .default(Text("Photo Library")) {
//                            sourceType = .photoLibrary
//                            showImagePicker = true
//                        },
//                        .cancel()
//                    ]
//                )
//            }
//            .alert(isPresented: $cameraManager.showError) {
//                Alert(
//                    title: Text("Error"),
//                    message: Text(cameraManager.errorMessage),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//            .onAppear {
//                cameraManager.requestCameraAccess()
//            }
//        }
//    }
//    
//    private func savePhoto() {
//        // Save photo logic here
//        presentationMode.wrappedValue.dismiss()
//    }
//}
//
//// Image Preview View
//struct PreviewImageView: View {
//    let image: UIImage
//    
//    var body: some View {
//        Image(uiImage: image)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(maxHeight: UIScreen.main.bounds.height * 0.6)
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
//            )
//            .padding()
//    }
//}
//
//// Photo Placeholder View
//struct PhotoPlaceholderView: View {
//    var body: some View {
//        VStack(spacing: 16) {
//            Image(systemName: "camera.fill")
//                .font(.system(size: 40))
//                .foregroundColor(.gray)
//            
//            Text("Take your daily progress photo")
//                .font(.headline)
//            
//            Text("Front, side, or back view in good lighting")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//        }
//        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
//        .background(
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color(UIColor.systemBackground))
//                .shadow(color: Color.black.opacity(0.05), radius: 10)
//        )
//        .padding()
//    }
//}
//
//// Camera Controls View
//struct CameraControlsView: View {
//    @Binding var showImagePicker: Bool
//    @Binding var sourceType: UIImagePickerController.SourceType
//    @Binding var showOptions: Bool
//    
//    var body: some View {
//        HStack(spacing: 30) {
//            Button(action: {
//                showOptions = true
//            }) {
//                VStack(spacing: 8) {
//                    Image(systemName: "camera.fill")
//                        .font(.system(size: 24))
//                    Text("Take Photo")
//                        .font(.caption)
//                }
//                .foregroundColor(.white)
//                .frame(width: 100, height: 100)
//                .background(Color.blue)
//                .clipShape(Circle())
//                .shadow(color: Color.black.opacity(0.2), radius: 5)
//            }
//        }
//        .padding(.bottom, 30)
//    }
//}
//
//// Image Picker Representative
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    let sourceType: UIImagePickerController.SourceType
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = sourceType
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//        
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.image = image
//            }
//            picker.dismiss(animated: true)
//        }
//        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
//        }
//    }
//}
//
//extension TaskRowView {
//    var photoButton: some View {
//        Button(action: {
//            // Show photo capture view
//        }) {
//            if task.type == .photo {
//                HStack {
//                    Image(systemName: "camera.fill")
//                        .font(.system(size: 20))
//                    Text("Take Photo")
//                }
//                .foregroundColor(.blue)
//                .padding(.vertical, 8)
//                .padding(.horizontal, 16)
//                .background(
//                    RoundedRectangle(cornerRadius: 8)
//                        .fill(Color.blue.opacity(0.1))
//                )
//            }
//        }
//    }
//}
