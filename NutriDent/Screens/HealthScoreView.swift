
import SwiftUI

struct HealthScoreView: View {
    let score: Int
    let maxScore: Int
    
    // Computed property for color based on score
    private var scoreColor: Color {
        switch score {
        case 1...3:
            return .green
        case 4...6:
            return .orange
        default:
            return .red
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon
            ZStack {
                Circle()
                    .fill(scoreColor.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(icons.dentalRisk.rawValue)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(scoreColor)
            }

            // Text + Progress
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(AppConstants.dentalRiskScore)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)

                    Spacer()

                    Text("\(score)/\(maxScore)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                }

                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .frame(height: 5)
                            .foregroundColor(Color.gray.opacity(0.2))

                        Capsule()
                            .frame(width: geometry.size.width * CGFloat(score) / CGFloat(maxScore), height: 5)
                            .foregroundColor(scoreColor)
                    }
                }
                .frame(height: 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.top, 5)
    }
}

