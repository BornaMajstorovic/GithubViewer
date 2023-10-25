import Foundation
import Dependencies

private enum RepoRepositoryKey: DependencyKey {
    static let liveValue: RepoRepository = LiveRepoRepository.shared
    static var testValue: RepoRepository = MockRepoRepository()
}

extension DependencyValues {
    var repoRepository: RepoRepository {
        get { self[RepoRepositoryKey.self] }
        set { self[RepoRepositoryKey.self] = newValue }
    }
}
