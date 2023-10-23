import SwiftUI

struct ContributorCardView: View {
    let contributor: UIModel.Contributor

    var body: some View {
        VStack(alignment: .leading) {
            Text(contributor.name)
                .font(.subheadline)
                .foregroundStyle(.white)
            Spacer()
            Text("Contributions: \(contributor.numberOfContributions)")
                .font(.body)
                .foregroundStyle(.white)
        }
        .padding(8)
        .frame(width: 125, height: 125)
        .background {
            GrayBackgroundView()
        }
    }
}
