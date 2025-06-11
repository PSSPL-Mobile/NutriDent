import Foundation
import GoogleGenerativeAI
import OSLog
import SwiftUI
import UIKit

func colorForAcidLevel(_ riskValue: Int) -> Color {
    switch riskValue {
    case 0...3:
        return .green  // Low risk
    case 4...5:
        return .yellow  // Mild risk
    case 6...8:
        return .orange  // Medium risk
    case 8...10:
        return .red  // High risk
    default:
        return .gray
    }
}

func colorForCalciumLevel(_ calciumValue: Int) -> Color {
    switch calciumValue {
    case 0...100:
        return .red       // Low Calcium
    case 101...300:
        return .orange    // Moderate Calcium
    case 301...:
        return .green     // High Calcium
    default:
        return .gray
    }
}

func colorForCalories(_ calorieValue: Int) -> Color {
    switch calorieValue {
    case 0...200:
        return .green       // Low Calories
    case 201...500:
        return .orange      // Moderate Calories
    case 501...:
        return .red         // High Calories
    default:
        return .gray
    }
}

func colorForCarbohydrates(_ carbValue: Int) -> Color {
    switch carbValue {
    case 0...15:
        return .green       // Low Carbs
    case 16...30:
        return .orange      // Moderate Carbs
    case 31...:
        return .red         // High Carbs
    default:
        return .gray
    }
}

func colorForPhosphorus(_ phosphorusValue: Int) -> Color {
    switch phosphorusValue {
    case 0...150:
        return .green       // Low Risk
    case 151...300:
        return .orange      // Moderate Risk
    case 301...:
        return .red         // High Risk
    default:
        return .gray
    }
}

func sugarRiskLevel(_ value: Int) -> Color {
    switch value {
    case 0...5:
        return .green
    case 6...15:
        return .orange
    case 16...:
        return .red
    default:
        return .gray
    }
}


// Struct to decode the JSON response
struct DentalAnalysis: Codable {
    let nutritionalBreakdown: NutritionalBreakdown
    let highlightedNutrients: HighlightedNutrients
    let dentalRiskScore: Int
    let riskLevel: String
    let dentalWarnings: [String]
    let careTips: [String]

    enum CodingKeys: String, CodingKey {
        case nutritionalBreakdown = "nutritional_breakdown"
        case highlightedNutrients = "highlighted_nutrients"
        case dentalRiskScore = "dental_risk_score"
        case riskLevel = "risk_level"
        case dentalWarnings = "dental_warnings"
        case careTips = "care_tips"
    }
}

// MARK: - NutritionalBreakdown
struct NutritionalBreakdown: Codable {
    let calories: Int
    let carbohydrates: Int
    let sugar: Int
    let acids: Int
    let calcium: Int
    let vitaminD: Int
    let phosphorus: Int

    enum CodingKeys: String, CodingKey {
        case calories
        case carbohydrates
        case sugar
        case acids
        case calcium
        case vitaminD = "vitamin_d"
        case phosphorus
    }
}

// MARK: - HighlightedNutrients
struct HighlightedNutrients: Codable {
    let beneficial: [String]
    let harmful: [String]
}

@MainActor
class NutriDentViewModel: ObservableObject {
    private static let largestImageDimension = 768.0
    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: AppConstants.category)
    var lastImage: UIImage?
    
    @Published var userInput: String = AppConstants.userInput
    @Published var errorMessage: String?
    @Published var inProgress = false
    @Published var dentalAnalysis: DentalAnalysis?
    @Published var analysisDate: Date?
    
    private var model: GenerativeModel?

    init() {
        model = GenerativeModel(name: AppConstants.model, apiKey: APIKey.default)
    }

    func reason(with image: UIImage) async {
        defer { inProgress = false }
        guard let model else { return }

        do {
            inProgress = true
            errorMessage = nil
            dentalAnalysis = nil

            let prompt = AppConstants.userInput

            var finalImage = image
            lastImage = finalImage

            if !image.size.fits(largestDimension: NutriDentViewModel.largestImageDimension) {
                guard let resized = image.preparingThumbnail(
                    of: image.size.aspectFit(largestDimension: NutriDentViewModel.largestImageDimension)
                ) else {
                    logger.error("Failed to resize image")
                    return
                }
                finalImage = resized
            }

            let outputStream = model.generateContentStream(prompt, [finalImage])
            var fullText = ""

            for try await chunk in outputStream {
                if let text = chunk.text {
                    fullText += text
                }
            }

            if fullText.contains("NO_TEETH_FOUND") {
                errorMessage = "This image does not appear to show teeth. Please upload a clear image of teeth."
                return
            }
            
            // Use regex to extract valid JSON object
            if let match = fullText.range(of: #"(?s)\{.*\}"#, options: .regularExpression) {
                let json = String(fullText[match])
                if let jsonData = json.data(using: .utf8) {
                    let decoder = JSONDecoder()
                    dentalAnalysis = try decoder.decode(DentalAnalysis.self, from: jsonData)
                    print("Result: \(String(describing: dentalAnalysis))")
                    analysisDate = Date()
                } else {
                    errorMessage = "Failed to convert response to data."
                }
            } else {
                errorMessage = "No valid JSON found in response."
            }

        } catch {
            logger.error("Error: \(error.localizedDescription)")
            errorMessage = "An error occurred during analysis."
        }
    }

    func analyzeImage(_ image: UIImage?, completion: @escaping () -> Void) {
        guard let image = image else { return }
        Task {
            await reason(with: image)
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    var formattedAnalysisDate: String {
        guard let date = analysisDate else { return "Processing date unavailable" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Getter for lastImage to make it accessible
    var lastImageValue: UIImage? {
        return lastImage
    }
}

private extension CGSize {
    func fits(largestDimension length: CGFloat) -> Bool {
        return width <= length && height <= length
    }

    func aspectFit(largestDimension length: CGFloat) -> CGSize {
        let aspectRatio = width / height
        if width > height {
            let width = min(self.width, length)
            return CGSize(width: width, height: round(width / aspectRatio))
        } else {
            let height = min(self.height, length)
            return CGSize(width: round(height * aspectRatio), height: height)
        }
    }
}
