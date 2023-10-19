import SwiftUI
import ComposableArchitecture

extension RepoDetails {
    struct RepoDetailsView: View {
        let store: Store<State, Action>

        var body: some View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                Text(viewStore.name)
            }
        }
    }
}
