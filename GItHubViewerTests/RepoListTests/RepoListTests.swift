import XCTest
import ComposableArchitecture
@testable import GItHubViewer

@MainActor
final class RepoListTests: XCTestCase {
    var sut: TestStore<RepoList.State, RepoList.Action>!

    override func setUpWithError() throws {
        sut = TestStore(initialState: RepoList.State()) {
            RepoList()
        }
    }

    func testInitialLoad() async {
        await sut.send(.viewAppeared)
        await sut.receive(.fetchData)
        await sut.receive(.fetchDataResult([.mock])) {
            $0.loadingState = .idle
            $0.currentPage = 2
            $0.repos = [.mock]
        }
    }

    func testPagination() async {
        await sut.send(.viewAppeared)
        await sut.receive(.fetchData)
        await sut.receive(.fetchDataResult([.mock])) {
            $0.loadingState = .idle
            $0.currentPage = 2
            $0.repos = [.mock]
        }

        await sut.send(.listReachedBottom)

        await sut.receive(.fetchData)
        await sut.receive(.fetchDataResult([.mock])) {
            $0.loadingState = .idle
            $0.currentPage = 3
            $0.repos = [.mock, .mock]
        }

        await sut.send(.listReachedBottom)
        await sut.receive(.fetchData)
        await sut.receive(.binding(.set(\.$loadingState, .finished))) {
            $0.loadingState = .finished
        }
    }

}
