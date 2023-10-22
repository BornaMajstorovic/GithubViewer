import SwiftUI
import ComposableArchitecture

extension RepoDetails {
    struct RepoDetailsView: View {
        let store: Store<State, Action>

        var body: some View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    HStack {
                        Text("\(viewStore.repo.name)")
                        Spacer()
                        Text("by \(viewStore.repo.owner.login)")
                    }
                    .font(.title)
                    .foregroundStyle(.gray)
                    Text("Stars count: \(viewStore.repo.stargazers_count)")
                    Text("Fork count: \(viewStore.repo.forks_count)")
                    Text("Size: \(viewStore.repo.size)")

                    Text("Contributors: ")
                }
            }
        }
    }
}
