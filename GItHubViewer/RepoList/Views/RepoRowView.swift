import SwiftUI

struct RepoRowView: View {
    let repoName: String
    let ownerName: String
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            contentView
        }
    }

    var contentView: some View {
        VStack {
            Text(repoName)
                .font(.subheadline)
                .foregroundStyle(.white)

            Text(ownerName)
                .font(.body)
                .foregroundStyle(.white)
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background {
            backgroundView
        }

    }

    @ViewBuilder private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.gray.opacity(0.7))
        RoundedRectangle(cornerRadius: 12)
            .stroke(style: .init(lineWidth: 2))
            .foregroundStyle(
                .linearGradient(colors: [.gray, .clear], startPoint: .top, endPoint: .bottom)
            )
            .shadow(color: .gray.opacity(0.2), radius: 12, x: 4, y: 0)
    }
}
