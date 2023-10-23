import Foundation
import Dependencies

private enum RepoRepositoryKey: DependencyKey {
    static let liveValue: RepoRepository = LiveRepoRepository.shared

    static var previewValue: RepoRepository {
        unimplemented("AuthClient - preview unimplemented")
    }

    static var testValue: RepoRepository {
        unimplemented("AuthClient - test unimplemented")
    }
}

extension DependencyValues {
    var repoRepository: RepoRepository {
        get { self[RepoRepositoryKey.self] }
        set { self[RepoRepositoryKey.self] = newValue }
    }
}
