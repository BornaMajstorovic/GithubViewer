import SwiftUI
import ComposableArchitecture

extension RepoDetails {
    struct RepoDetailsView: View {
        let store: Store<State, Action>

        var body: some View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        RowView(leadingImageName: "star.fill", title: "Stars count:", description: viewStore.repo.sizeOfRepo.description)
                        RowView(leadingImageName: "fork.knife.circle.fill", title: "Fork count", description: viewStore.repo.sizeOfRepo.description)
                        RowView(leadingImageName: "folder.fill", title: "Size", description: viewStore.repo.sizeOfRepo.description)
                    }
                    .padding(24)
                    .background {
                        RoundedRectangle(cornerSize: .init(width: 24, height: 24))
                            .foregroundStyle(.gray.opacity(0.2))
                    }
                    .padding(.horizontal, 24)

                    Spacer()

                    contributorsView(loadingState: viewStore.loadingState)
                        .frame(height: 150)
                }
                .padding(.vertical, 64)
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
                .navigationTitle(viewStore.navigationTitle)
            }
        }

        @ViewBuilder private func contributorsView(loadingState: LoadingState) -> some View {
            switch loadingState {
            case .idle, .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 64, height: 64)
            case .loaded(let contributors):
                contributorsLoadedView(contributors: contributors)
            case .failure:
                Text("Contributors fetch failed")
                    .font(.body)
                    .foregroundStyle(.red)
            }
        }

        @ViewBuilder private func contributorsLoadedView(contributors: [UIModel.Contributor]) -> some View {
            if contributors.isEmpty {
                contributorsEmptyView
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(contributors) { contributor in
                            ContributorCardView(contributor: contributor)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .contentMargins(24, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
            }
        }

        private var contributorsEmptyView: some View {
            HStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 36))
                Text("No data, check your internet connection, or try again later")
                    .font(.title2)
            }
            .foregroundStyle(.gray.opacity(0.8))
            .multilineTextAlignment(.center)
        }
    }
}
