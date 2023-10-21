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

            Text(ownerName)
                .font(.caption)
            Divider()
        }.background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray)
        }
        .frame(height: 60)
    }
}
