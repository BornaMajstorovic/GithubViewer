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
            GrayBackgroundView()
        }
    }
}
