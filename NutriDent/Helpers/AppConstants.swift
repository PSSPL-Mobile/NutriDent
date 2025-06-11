

struct AppConstants {
    static let nutriDentTitle = "NutriDent"
    static let noImageSelectedTitle = "No Image Selected"
    static let camera = "Camera"
    static let gallery = "Gallery"
    static let ok = "OK"
    static let category = "generative-ai"
    static let model = "gemini-1.5-flash-latest"
    static let proceedToAnalysis = "Proceed to Analysis"
    static let imagePreview = "Your image will appear here"
    static let instruction = "Select a clear image of the food for AI analysis."
    static let analyzingFoodImpact = "Analyzing food impact..."
    static let scanResult = "Scan Results"
    static let aiAnalysisReport = "AI Analysis Report"
    static let nutritionalBreakdownSection = "Nutritional Breakdown"
    static let dentalRiskScoreSection = "Dental Risk score"
    static let acid = "Acid"
    static let calcium = "Calcium"
    static let calories = "Calories"
    static let carbohydrates = "Carbs"
    static let phosphorus = "Phos"
    static let sugar = "Sugar"
    static let dentalRiskScore = "Dental Risk Score"
    static let harmfulNutrientsSection = "Harmful Nutrients:"
    static let beneficialNutrientsSection = "Beneficial Nutrients:"
    static let recommendedCareTips = "Recommended Care Tips:"
    static let cameraNotSupportMsg = "This device does not support camera functionality."
    static let noFoodImageMsg = "This image does not appear to show food. Please upload a clear image of food."
    static let userInput = """
            You are a dental AI assistant. Analyze the nutritional content of a food item provided by the user and respond only with a valid JSON object that conforms exactly to the following format:

            {
              "nutritional_breakdown": {
                "calories": 0,
                "carbohydrates": 0,
                "sugar": 0,
                "acids": 0,
                "calcium": 0,
                "vitamin_d": 0,
                "phosphorus": 0
              },
              "highlighted_nutrients": {
                "beneficial": [],
                "harmful": []
              },
              "dental_risk_score": 0,
              "risk_level": "",
              "dental_warnings": [],
              "care_tips": []
            }

            The values for each field must be as follows:
            - "nutritional_breakdown": An object with the following fields, all as integers (in appropriate units, e.g., calories in kcal, others in grams or milligrams as contextually appropriate):
              - "calories": Non-negative integer
              - "carbohydrates": Non-negative integer
              - "sugar": Non-negative integer
              - "acids": Non-negative integer
              - "calcium": Non-negative integer
              - "vitamin_d": Non-negative integer
              - "phosphorus": Non-negative integer
            - "highlighted_nutrients": An object with:
              - "beneficial": List of strings from ["Calcium", "Vitamin D", "Phosphorus"] that are present in significant amounts (e.g., above a threshold like 10% of daily value)
              - "harmful": List of strings from ["Sugar", "Acids"] that are present in significant amounts (e.g., above a threshold like 5g for sugar, 1g for acids)
            - "dental_risk_score": An integer between 1 and 10, calculated based on:
              - Sugar level (e.g., >10g adds +3, 5-10g adds +2, <5g adds +1)
              - Acid content (e.g., >2g adds +3, 1-2g adds +2, <1g adds +1)
              - Stickiness of the food (e.g., high stickiness like caramel adds +2, moderate adds +1, none adds 0)
              - Frequency of similar meals (e.g., high frequency adds +2, moderate adds +1, low adds 0)
            - "risk_level": Must be one of "Low Risk", "Moderate Risk", or "High Risk", based on the dental_risk_score:
              - 1-3: "Low Risk"
              - 4-6: "Moderate Risk"
              - 7-10: "High Risk"
            - "dental_warnings": A list of strings from the following options, based on analysis:
              - "Sugary Food Warning": If sugar > 10g
              - "Acidic Food Erosion Alert": If acids > 2g
              - "Low-Calcium Alert": If calcium < 50mg
              - "Brushing Reminder": If sugar > 5g or food is sticky
            "care_tips": A list of 3–5 short actionable tips for dental care (strings), always based on the food item identified in the image — even if it's gum, candy, or a packaged item. The tips should reflect the dental impact of consuming the detected food.
            
            Respond only with "NO_FOOD_FOUND" or valid JSON. Do not add markdown, comments, or any explanation.
            """
}

enum SystemImage: String {
    case camera = "camera.fill"
    case gallery = "photo.on.rectangle.fill"
    case leftArrow = "chevron.left"
    case photo = "photo"
    case analyze = "waveform.path.ecg"
    case noImage = "photo.on.rectangle.angled"
}

enum icons: String {
    case logo = "iconLogo"
    case teethLogo = "teethLogo"
    case acid = "iconAcid"
    case calcium = "iconCalcium"
    case calories = "iconCalories"
    case carbohydrates = "iconcarbohydrates"
    case phosphorus = "iconPhosphorus"
    case sugar = "iconSugar"
    case dentalRisk = "iconDentalRisk"
}
