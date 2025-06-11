# 🥗🦷 NutriDent Scanner App (SwiftUI)

This project is a SwiftUI-based iOS application that uses AI to analyze images of food for nutritional insights impacting dental health. It allows users to capture or upload images, processes them using Google's Generative AI, and provides a detailed nutritional report with metrics and dental care tips.

## ✨ Features

- 📸 **Camera Integration**: Capture food images directly using the device's camera.
- 🖼️ **Photo Picker**: Upload food images from the photo gallery.
- 🤖 **AI-Powered Analysis**: AI-powered nutritional analysis using Google's Generative AI, assessing:
  1. Acid Content
  2. Calcium Content
  3. Calories
  4. Carbohydrates
  5. Phosphorus Content
  6. Sugar Content
  7. Overall Dental Risk Score
- 📊 **Nutritional Highlights**: Identify **beneficial** (e.g., calcium, phosphorus) and **harmful** (e.g., high sugar, high acid) nutrients for dental health.
- 📈 **Detailed Results**: Display metrics in a visually appealing grid with color-coded indicators.
- 💡 **Care Tips**: Personalized dental care recommendations based on nutritional analysis.
- 🔄 **Progress Feedback**: Show a loading indicator during AI processing.
- 🚨 **Error Handling**: Display alerts for invalid images (e.g., no food detected) or camera unavailability.

## 🛠 Tech Stack

- **SwiftUI**: Modern UI building
- **GoogleGenerativeAI**: AI-powered nutritional image analysis
- **PhotosUI**: Photo gallery access
- **UIKit (minor)**: Image handling and camera integration
- **Foundation**: General utilities and networking

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/PSSPL-Mobile/NutriDent
   ```
2. Open the project in Xcode 15 or later.
3. Add the Google Generative AI dependency:
   - Ensure you have a valid API key for Google Generative AI.
   - Add the API key securely, such as in your project’s `.plist` or a configuration file.
4. Update `Info.plist` with the required permissions:
   - `NSCameraUsageDescription`: Camera access for capturing food images
   - `NSPhotoLibraryUsageDescription`: Photo library access for selecting images
5. Build and run the image on a real device:
   - Note: Camera functionality is not available on the iOS Simulator.

## 📖 Usage

1. Launch the app and view the home screen with instructions.
2. View the an image source:
   - Tap the **Camera** button to capture a new photo of food.
   - Tap the **Gallery** button to select an existing photo.
3. Preview the selected or captured image.
4. Tap **Proceed to Analysis** to start AI processing.
5. View the results, including:
   - Metrics like acid, calcium, calories, carbohydrates, phosphorus, sugar, sugar and overall dental risk score.
   - Highlighted **beneficial** and **harmful** nutrients for dental health.
   - Personalized dental care tips based on the analysis.
6. If an error occurs (e.g., no food detected), an alert will guide you to try again.

## 🎥 Preview

<p align="left">
  <img src="NutriDent/Video/sampleVideo.gif" width="30%" />
</p>