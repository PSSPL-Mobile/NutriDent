
import SwiftUI

struct CustomPopup: View {
    let title: String
    let message: String
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    Image(icons.logo.rawValue)
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryAccent)
                }
                
                // Message
                Text(message)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                // OK Button
                Button(action: {
                    isPresented = false
                }) {
                    Text(AppConstants.ok)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.primaryAccent)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 10)
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
        }
        .transition(.scale)
        .animation(.spring(), value: isPresented)
    }
}
