
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NutriDentViewModel()
    @State private var showCamera = false
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?
    @State private var navigateToResult = false
    @State private var showCameraNotAvlAlert = false
    @State private var showNoFoodImageAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 24) {
                    VStack(alignment: .center, spacing: 10) {
                        Text(AppConstants.nutriDentTitle)
                            .font(.title)
                            .foregroundColor(.primaryAccent)
                            .fontWeight(.bold)

                        Text(AppConstants.instruction)
                            .font(.subheadline)
                            .foregroundColor(.primaryAccent)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)

                    // Image Preview Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                            .foregroundColor(.black.opacity(0.3))
                            .frame(height: 250)

                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 230)
                                .cornerRadius(12)
                        } else {
                            VStack(spacing: 12) {
                                Image(systemName: SystemImage.noImage.rawValue)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray.opacity(0.6))

                                Text(AppConstants.imagePreview)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    // Camera and Gallery Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                showCamera = true
                            } else {
                                showCameraNotAvlAlert = true
                            }
                        }) {
                            VStack {
                                Image(systemName: SystemImage.camera.rawValue)
                                    .font(.title2)
                                Text(AppConstants.camera)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(.primaryAccent)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        }

                        Button(action: {
                            showPhotoPicker = true
                        }) {
                            VStack {
                                Image(systemName: SystemImage.gallery.rawValue)
                                    .font(.title2)
                                Text(AppConstants.gallery)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(.primaryAccent)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        }
                    }

                    // Analyze Image Button
                    Button(action: {
                        guard let image = selectedImage else { return }

                        viewModel.analyzeImage(image) {
                            if viewModel.errorMessage != nil {
                                showNoFoodImageAlert = true
                            } else {
                                navigateToResult = true
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: SystemImage.analyze.rawValue)
                            Text(AppConstants.proceedToAnalysis)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryAccent)
                        .cornerRadius(10)
                        .opacity(selectedImage == nil ? 0.4 : 1.0)
                        .allowsHitTesting(selectedImage != nil)
                    }

                    Spacer()
                }
                .padding(.horizontal)

                // Progress Indicator Overlay
                if viewModel.inProgress {
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            ToothLoaderView()
                                .padding()
                        )
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                // Camera not support alert
                if showCameraNotAvlAlert {
                    CustomPopup(
                        title: AppConstants.nutriDentTitle,
                        message: AppConstants.cameraNotSupportMsg,
                        isPresented: $showCameraNotAvlAlert
                    )
                }
                
                // Food image not visible alert
                if showNoFoodImageAlert {
                    CustomPopup(
                        title: AppConstants.nutriDentTitle,
                        message: AppConstants.noFoodImageMsg,
                        isPresented: $showNoFoodImageAlert
                    )
                }
            }
            .navigationBarHidden(true)
            .onDisappear {
                selectedImage = nil
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(selectedImage: $selectedImage)
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(capturedImage: $selectedImage)
            }
            .navigationDestination(isPresented: $navigateToResult) {
                ResultScreen(viewModel: viewModel)
            }
        }
    }
}

