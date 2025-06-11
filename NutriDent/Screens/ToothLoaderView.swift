
import SwiftUI

struct ToothLoaderView: View {
    @State private var animate = false

    var body: some View {
        VStack(spacing: 16) {
            Image(icons.teethLogo.rawValue)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .rotationEffect(.degrees(animate ? 360 : 0))
                .scaleEffect(animate ? 1.1 : 0.9)
                .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animate)

            Text(AppConstants.analyzingFoodImpact)
                .font(.headline)
                .foregroundColor(.white)
        }
        .onAppear {
            animate = true
        }
    }
}
