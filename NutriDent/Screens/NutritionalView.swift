
import SwiftUI

struct NutritionalView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundColor(color)
                .padding(10)
                .background(color.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Text("\(value)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .minimumScaleFactor(0.7)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.neutral, radius: 4, x: 0, y: 2)
    }
}
