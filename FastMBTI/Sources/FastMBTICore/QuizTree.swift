import Foundation

public struct QuizOption: Codable, Sendable, Equatable {
    public let labelKey: String
    public let next: String
}

public struct QuizNode: Codable, Sendable, Equatable {
    public let id: String
    public let questionKey: String
    public let options: [QuizOption]
}

public struct ResultType: Codable, Sendable, Equatable {
    public let id: String
    public let titleKey: String
    public let textKey: String
}

public struct QuizTree: Codable, Sendable {
    public let root: String
    public let nodes: [QuizNode]
    public let types: [ResultType]

    public static func load() throws -> QuizTree {
        try load(from: .module)
    }

    public static func load(from bundle: Bundle) throws -> QuizTree {
        guard let url = bundle.url(forResource: "quizTree", withExtension: "json") else {
            throw QuizError.resourceMissing
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(QuizTree.self, from: data)
    }

    public func node(id: String) -> QuizNode? {
        nodes.first { $0.id == id }
    }

    public func result(id: String) -> ResultType? {
        types.first { $0.id == id }
    }

    public func isResult(_ id: String) -> Bool {
        result(id: id) != nil
    }
}

public enum QuizError: Error, Equatable {
    case resourceMissing
    case nodeNotFound(String)
    case invalidState
}
