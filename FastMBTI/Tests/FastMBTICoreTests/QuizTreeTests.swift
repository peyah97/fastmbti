import XCTest
@testable import FastMBTICore

final class QuizTreeTests: XCTestCase {
    private var tree: QuizTree!

    override func setUpWithError() throws {
        tree = try QuizTree.load()
    }

    func testAllSixteenTypesReachableWithinThreeToSixQuestions() throws {
        var depths: [String: Int] = [:]
        var stack: [(String, Int)] = [(tree.root, 0)]

        while let (id, depth) = stack.popLast() {
            if tree.isResult(id) {
                depths[id] = min(depths[id] ?? Int.max, depth)
                continue
            }
            XCTAssertLessThan(depth, 6, "path too deep at \(id)")
            let node = try XCTUnwrap(tree.node(id: id), "missing node \(id)")
            for option in node.options {
                stack.append((option.next, depth + 1))
            }
        }

        XCTAssertEqual(depths.count, 16)
        XCTAssertEqual(Set(depths.keys), Set(tree.types.map(\.id)))
        XCTAssertEqual(depths.values.min(), 3)
        XCTAssertEqual(depths.values.max(), 6)
    }

    func testNoOrphansAndNoCycles() throws {
        var visited: Set<String> = []

        func visit(_ id: String, _ chain: Set<String>) throws {
            if tree.isResult(id) {
                visited.insert(id)
                return
            }
            XCTAssertFalse(chain.contains(id), "cycle at \(id)")
            let node = try XCTUnwrap(tree.node(id: id))
            visited.insert(id)
            for option in node.options {
                try visit(option.next, chain.union([id]))
            }
        }

        try visit(tree.root, [])
        XCTAssertEqual(
            visited,
            Set(tree.nodes.map(\.id)).union(Set(tree.types.map(\.id)))
        )
    }

    func testRationalIsRealBranchAfterImageFix() throws {
        let rational = try XCTUnwrap(tree.node(id: "rational"))
        XCTAssertEqual(rational.options.map(\.next), ["emotional", "emotional2"])

        let emotional = try XCTUnwrap(tree.node(id: "emotional"))
        XCTAssertEqual(emotional.options.count, 2)
        XCTAssertEqual(emotional.options.map(\.next), ["INFJ", "cry"])

        let emotional2 = try XCTUnwrap(tree.node(id: "emotional2"))
        XCTAssertEqual(emotional2.options.map(\.next), ["INFJ", "sure"])

        let sure = try XCTUnwrap(tree.node(id: "sure"))
        XCTAssertEqual(sure.options.first?.next, "stone")

        let picky = try XCTUnwrap(tree.node(id: "picky"))
        XCTAssertEqual(picky.options.first?.next, "cry")

        let cry = try XCTUnwrap(tree.node(id: "cry"))
        XCTAssertEqual(cry.options.first?.next, "INFP")
    }

    func testEngineWalkToINFJ() throws {
        var engine = try QuizEngine(tree: tree)
        for _ in 0..<4 {
            try engine.answer(optionAt: 0)
        }
        XCTAssertTrue(engine.isFinished)
        XCTAssertEqual(engine.currentResult?.id, "INFJ")
        XCTAssertEqual(engine.path.count, 4)
    }
}
