import SwiftUI

struct ResultScreen: View {
    @ObservedObject var viewModel: NutriDentViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Custom Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: SystemImage.leftArrow.rawValue)
                        .font(.system(size: 20))
                        .foregroundColor(.primaryAccent)
                        .padding()
                        .background(Circle().fill(Color.gray.opacity(0.1)))
                }
                
                Spacer()
                
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Image(icons.logo.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .accessibilityLabel("App Logo")
                        
                        Text(AppConstants.scanResult)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primaryAccent)
                            .dynamicTypeSize(.large)
                    }
                    Text(AppConstants.aiAnalysisReport)
                        .font(.subheadline)
                        .foregroundColor(.primaryAccent)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                // Empty view to balance the layout
                Color.clear
                    .frame(width: 20, height: 20)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.white)
            .zIndex(1)

            // Scrollable Content
            ScrollView {
                VStack(spacing: 10) {
                    VStack(spacing: 10) {
                        if let image = viewModel.lastImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.top, 10)
                        } else {
                            Image(systemName: SystemImage.photo.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.top, 10)
                        }

                        Text(viewModel.formattedAnalysisDate)
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.black.opacity(0.4))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 5)
                    
                    // Metrics Grid
                    if let analysis = viewModel.dentalAnalysis {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 15),
                            GridItem(.flexible(), spacing: 15)
                        ], spacing: 15) {
                            NutritionalView(title: AppConstants.acid, value: "\(analysis.nutritionalBreakdown.acids)", icon: icons.acid.rawValue, color: colorForAcidLevel(analysis.nutritionalBreakdown.acids))
                            NutritionalView(title: AppConstants.calcium, value: "\(analysis.nutritionalBreakdown.calcium)mg", icon: icons.calcium.rawValue, color: colorForCalciumLevel(analysis.nutritionalBreakdown.calcium))
                            NutritionalView(title: AppConstants.calories, value: "\(analysis.nutritionalBreakdown.calories)kcal", icon: icons.calories.rawValue, color: colorForCalories(analysis.nutritionalBreakdown.calories))
                            NutritionalView(title: AppConstants.carbohydrates, value: "\(analysis.nutritionalBreakdown.carbohydrates)g", icon: icons.carbohydrates.rawValue, color: colorForCarbohydrates(analysis.nutritionalBreakdown.carbohydrates))
                            NutritionalView(title: AppConstants.phosphorus, value: "\(analysis.nutritionalBreakdown.phosphorus)mg", icon: icons.phosphorus.rawValue, color: colorForPhosphorus(analysis.nutritionalBreakdown.phosphorus))
                            NutritionalView(title: AppConstants.sugar, value: "\(analysis.nutritionalBreakdown.sugar)g", icon: icons.sugar.rawValue, color: sugarRiskLevel(analysis.nutritionalBreakdown.sugar))
                        }
                    }
                    
                    if let analysis = viewModel.dentalAnalysis {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 15)
                        ], spacing: 15) {
                            HealthScoreView(score: analysis.dentalRiskScore, maxScore: 10)
                            
                            if !analysis.highlightedNutrients.beneficial.isEmpty {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(AppConstants.beneficialNutrientsSection)
                                        .font(.headline)
                                    Text(analysis.highlightedNutrients.beneficial.joined(separator: ", "))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.vertical)
                                        .padding(.horizontal, 10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.beneficial)
                                        .cornerRadius(10)
                                }
                            }
                            
                            if !analysis.highlightedNutrients.harmful.isEmpty {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(AppConstants.harmfulNutrientsSection)
                                        .font(.headline)
                                    Text(analysis.highlightedNutrients.harmful.joined(separator: ", "))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.vertical)
                                        .padding(.horizontal, 10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.harmful)
                                        .cornerRadius(10)
                                }
                            }
                            
                            // Recommended Care Tips
                            VStack(alignment: .leading, spacing: 10) {
                                Text(AppConstants.recommendedCareTips)
                                    .font(.headline)
                                
                                ForEach(analysis.careTips, id: \.self) { tip in
                                    HStack(alignment: .center) {
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundColor(.blue)
                                        Text(tip)
                                            .font(.system(size: 16))
                                    }
                                    .padding(.vertical)
                                    .padding(.horizontal, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .background(Color.gray.opacity(0.1))
        }
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
