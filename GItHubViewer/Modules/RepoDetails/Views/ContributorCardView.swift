import SwiftUI

struct ContributorCardView: View {
    let contributor: UIModel.Contributor

    var body: some View {
        VStack(alignment: .leading) {
            Text(contributor.name)
                .font(.title3)
                .foregroundStyle(.gray)
            Spacer()
            Text("Contributions: \(contributor.numberOfContributions)")
                .font(.body)
                .foregroundStyle(.gray)
        }
        .padding(16)
        .frame(width: 150, height: 150)
        .background {
            RoundedRectangle(cornerSize: .init(width: 24, height: 24))
                .foregroundStyle(.gray.opacity(0.2))
        }
    }
}
