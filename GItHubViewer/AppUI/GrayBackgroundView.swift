import SwiftUI

struct GrayBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.gray.opacity(0.7))
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: .init(lineWidth: 2))
                .foregroundStyle(
                    .linearGradient(colors: [.gray, .clear], startPoint: .top, endPoint: .bottom)
                )
                .shadow(color: .gray.opacity(0.2), radius: 8, x: 2, y: 0)
        }
    }
}
