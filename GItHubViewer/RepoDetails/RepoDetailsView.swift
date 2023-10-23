import SwiftUI
import ComposableArchitecture

extension RepoDetails {
    struct RepoDetailsView: View {
        let store: Store<State, Action>

        var body: some View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    HStack {
                        Text("\(viewStore.repo.repoName)")
                        Spacer()
                        Text("by \(viewStore.repo.ownerName)")
                    }
                    .font(.title)
                    .foregroundStyle(.gray)
                    Text("Stars count: \(viewStore.repo.numberOfStars)")
                    Text("Fork count: \(viewStore.repo.numberOfForks)")
                    Text("Size: \(viewStore.repo.sizeOfRepo)")

                    Text("Contributors: \(viewStore.repo.contributorsUrlString)")
                }
            }
        }
    }
}
