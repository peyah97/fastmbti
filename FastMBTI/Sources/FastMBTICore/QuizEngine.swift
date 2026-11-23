import Foundation

public struct QuizEngine: Sendable {
    public let tree: QuizTree
    public private(set) var currentID: String
    public private(set) var path: [String]

    public init(tree: QuizTree) throws {
        guard tree.node(id: tree.root) != nil else {
            throw QuizError.nodeNotFound(tree.root)
        }
        self.tree = tree
        self.currentID = tree.root
        self.path = []
    }

    public var currentNode: QuizNode? {
        tree.node(id: currentID)
    }

    public var isFinished: Bool {
        tree.isResult(currentID)
    }

    public var currentResult: ResultType? {
        tree.result(id: currentID)
    }

    @discardableResult
    public mutating func answer(optionAt index: Int) throws -> String {
        guard let node = currentNode else {
            throw QuizError.nodeNotFound(currentID)
        }
        guard node.options.indices.contains(index) else {
            throw QuizError.invalidState
        }
        let next = node.options[index].next
        guard tree.node(id: next) != nil || tree.isResult(next) else {
            throw QuizError.nodeNotFound(next)
        }
        path.append(currentID)
        currentID = next
        return next
    }
}
