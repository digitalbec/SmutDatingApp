import SwiftUI

struct ProfileView: View {
    @State private var name: String = "Your Name"
    @State private var age: String = "25"
    @State private var showingImagePicker = false
    @State private var profileImage: Image? = Image("defaultProfile") // Use a default image asset
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    VStack {
                        profileImage?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                            .padding(.bottom, 8)

                        Button("Change Photo") {
                            showingImagePicker = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                }

                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $name)
                        .autocapitalization(.words)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button(action: {
                        // Save profile changes logic here
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

// Simple ImagePicker implementation
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}