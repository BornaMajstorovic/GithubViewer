import SwiftUI

struct RowView: View {
    let leadingImageName: String
    let title: String
    let description: String
    let trailingImage: String?

    init(
        leadingImageName: String,
        title: String,
        description: String,
        trailingImage: String? = nil
    ) {
        self.leadingImageName = leadingImageName
        self.title = title
        self.description = description
        self.trailingImage = trailingImage
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image(systemName: leadingImageName)
                    .font(.system(size: 24))
                    .foregroundStyle(.gray.opacity(0.8))

                titleDescriptionView
                Spacer()

                if let trailingImage {
                    Image(systemName: trailingImage)
                        .font(.system(size: 24))
                        .foregroundStyle(.gray.opacity(0.8))
                }
            }
            Divider()
        }
    }

    private var titleDescriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.body)
                .foregroundStyle(.gray)

            Text(description)
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}
