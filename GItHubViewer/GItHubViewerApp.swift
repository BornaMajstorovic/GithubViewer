import SwiftUI
import ComposableArchitecture

@main
struct GItHubViewerApp: App {
    var body: some Scene {
        WindowGroup {
            MainApp.MainAppView(store: makeMainAppStore())
        }
    }
}

private extension GItHubViewerApp {
    func makeMainAppStore() -> Store<MainApp.State, MainApp.Action> {
        return StoreOf<MainApp>(initialState: MainApp.State.loading) {
            MainApp()
        }
    }
}
