
import SwiftUICore

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
    
    static let primaryAccent = Color(hex: "4A90E2")
    static let beneficial = Color.green.opacity(0.2)
    static let harmful = Color.red.opacity(0.2)
    static let neutral = Color.gray.opacity(0.2)
}
