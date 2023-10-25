import SwiftUI

struct RepoRowView: View {
    let repoName: String
    let ownerName: String
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            RowView(leadingImageName: "doc.fill", title: repoName, description: ownerName, trailingImage: "arrow.right.circle")
        }
    }
}
