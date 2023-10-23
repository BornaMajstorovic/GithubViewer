import SwiftUI
import ComposableArchitecture

extension RepoDetails {
    struct RepoDetailsView: View {
        let store: Store<State, Action>

        var body: some View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        titleAndDescriptionView(title: "Stars count:", description: viewStore.repo.sizeOfRepo.description)
                        titleAndDescriptionView(title: "Fork count", description: viewStore.repo.sizeOfRepo.description)
                        titleAndDescriptionView(title: "Size", description: viewStore.repo.sizeOfRepo.description)
                    }.padding(24)
                    .background {
                        RoundedRectangle(cornerSize: .init(width: 24, height: 24))
                            .foregroundStyle(.gray.opacity(0.2))
                    }


                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(viewStore.contributors) { contributor in
                                ContributorCardView(contributor: contributor)
                            }
                        }
                        .scrollTargetLayout()
                    }.scrollIndicators(.hidden)
                    .contentMargins(24, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                }
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
                .navigationTitle(viewStore.navigationTitle)
            }
        }

        private func titleAndDescriptionView(title: String, description: String) -> some View {
            VStack(spacing: 8) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.5))

                Text(description)
                    .font(.caption2)
                    .foregroundStyle(.black.opacity(0.5))
            }
        }
    }
}
