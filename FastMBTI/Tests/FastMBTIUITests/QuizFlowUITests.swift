import XCTest

final class QuizFlowUITests: XCTestCase {
    private var app: XCUIApplication!
    private var tree: QuizTreeFixture!
    private var catalogURL: URL!
    private var treeURL: URL!
    private var locale: String!

    override func setUpWithError() throws {
        continueAfterFailure = false

        locale = ProcessInfo.processInfo.environment["FASTMBTI_LOCALE"] ?? "zh-Hant"
        let projectRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        treeURL = projectRoot
            .appendingPathComponent("Sources/FastMBTICore/Resources/quizTree.json")
        catalogURL = projectRoot
            .appendingPathComponent("App/FastMBTI/Localizable.xcstrings")

        tree = try JSONDecoder().decode(
            QuizTreeFixture.self,
            from: Data(contentsOf: treeURL)
        )
        app = XCUIApplication()
        app.launchArguments = Self.arguments(for: locale)
    }

    private static func arguments(for locale: String) -> [String] {
        [
            "-AppleLanguages", "(\(locale))",
            "-AppleLocale", locale.replacingOccurrences(of: "-", with: "_")
        ]
    }

    func testRootIsLocalizedInZhHant() throws {
        app.launch()
        XCTAssertTrue(
            app.staticTexts[try localized("tree.root.q")].waitForExistence(timeout: 5),
            "root question is not zh-Hant"
        )
        XCTAssertTrue(
            app.buttons[try localized("tree.root.o1")].exists,
            "root option is not zh-Hant"
        )
    }

    func testAllSixteenPathsInZhHant() throws {
        for type in tree.types {
            let steps = try XCTUnwrap(tree.path(to: type.id), "no path to \(type.id)")
            app.launch()

            for (index, optionIndex) in steps.enumerated() {
                let button = app.buttons["option.\(optionIndex)"]
                XCTAssertTrue(
                    button.waitForExistence(timeout: 5),
                    "\(type.id) step \(index): option \(optionIndex) missing"
                )
                button.tap()
            }

            let result = app.staticTexts["result.\(type.id)"]
            XCTAssertTrue(result.waitForExistence(timeout: 5), "\(type.id): result not shown")
            XCTAssertEqual(result.label, type.id)
            XCTAssertTrue(
                app.staticTexts[try localized("type.\(type.id).title")].exists,
                "\(type.id): result title is not zh-Hant"
            )
            app.terminate()
        }
    }

    func testRestartButtonHasLocalizedLabel() throws {
        app.launch()
        for index in try XCTUnwrap(tree.path(to: "ESTP")) {
            app.buttons["option.\(index)"].tap()
        }
        let restart = app.buttons["restart"]
        XCTAssertTrue(restart.waitForExistence(timeout: 5))
        XCTAssertEqual(restart.label, try localized("ui.restart"))
    }

    func testCaptureZhHantScreenshots() throws {
        app.launch()

        let root = XCTAttachment(image: XCUIScreen.main.screenshot().image)
        root.name = "zh-root"
        add(root)

        for index in try XCTUnwrap(tree.path(to: "INTJ")) {
            app.buttons["option.\(index)"].tap()
        }
        let longest = XCTAttachment(image: XCUIScreen.main.screenshot().image)
        longest.name = "zh-result-INTJ"
        add(longest)

        app.terminate()
        app.launch()
        for index in try XCTUnwrap(tree.path(to: "ESTP")) {
            app.buttons["option.\(index)"].tap()
        }
        let shortest = XCTAttachment(image: XCUIScreen.main.screenshot().image)
        shortest.name = "zh-result-ESTP"
        add(shortest)
    }

    /// en / ja / ko with Dynamic Type `AccessibilityXL` as the concrete proxy
    /// for the spec's "button +30%, title +40%" expansion check.
    func testExpansionInThreeLocales() throws {
        for current in ["en", "ja", "ko"] {
            let expanded = XCUIApplication()
            expanded.launchArguments = Self.arguments(for: current) + [
                "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXL"
            ]
            expanded.launch()

            let rootQuestion = value("tree.root.q", locale: current)
            assertFits(
                expanded.staticTexts[rootQuestion],
                label: rootQuestion, in: expanded,
                "\(current) root question"
            )
            let rootNode = try XCTUnwrap(tree.node(id: tree.root))
            for (index, option) in rootNode.options.enumerated() {
                let label = value(option.labelKey, locale: current)
                assertFits(
                    expanded.buttons["option.\(index)"],
                    label: label, in: expanded,
                    "\(current) root option \(index)"
                )
            }

            let longestNode = try XCTUnwrap(tree.nodes.max {
                value($0.questionKey, locale: current).count < value($1.questionKey, locale: current).count
            })
            for index in try XCTUnwrap(tree.path(to: longestNode.id)) {
                expanded.buttons["option.\(index)"].tap()
            }
            let nodeQuestion = value(longestNode.questionKey, locale: current)
            assertFits(
                expanded.staticTexts[nodeQuestion],
                label: nodeQuestion, in: expanded,
                "\(current) longest question"
            )
            for (index, option) in longestNode.options.enumerated() {
                let label = value(option.labelKey, locale: current)
                assertFits(
                    expanded.buttons["option.\(index)"],
                    label: label, in: expanded,
                    "\(current) node option \(index)"
                )
            }

            expanded.terminate()
            expanded.launch()
            let longestType = try XCTUnwrap(tree.types.max {
                value($0.titleKey, locale: current).count + value($0.textKey, locale: current).count
                    < value($1.titleKey, locale: current).count + value($1.textKey, locale: current).count
            })
            for index in try XCTUnwrap(tree.path(to: longestType.id)) {
                expanded.buttons["option.\(index)"].tap()
            }
            let title = value(longestType.titleKey, locale: current)
            let text = value(longestType.textKey, locale: current)
            assertFits(expanded.staticTexts[title], label: title, in: expanded, "\(current) result title")
            assertFits(expanded.staticTexts[text], label: text, in: expanded, "\(current) result text")
            assertFits(
                expanded.buttons["restart"],
                label: value("ui.restart", locale: current), in: expanded,
                "\(current) restart button"
            )
            XCTAssertLessThanOrEqual(
                expanded.staticTexts[text].frame.maxY,
                expanded.buttons["restart"].frame.minY + 1,
                "\(current) result text overlaps restart button"
            )
            expanded.terminate()
        }
    }

    private func assertFits(
        _ element: XCUIElement,
        label expected: String,
        in app: XCUIApplication,
        _ message: String
    ) {
        XCTAssertTrue(element.waitForExistence(timeout: 5), "\(message): missing")
        XCTAssertEqual(element.label, expected, "\(message): text changed or truncated")
        let screen = app.windows.firstMatch.frame
        let frame = element.frame
        XCTAssertGreaterThan(frame.width, 0, "\(message): zero width")
        XCTAssertGreaterThan(frame.height, 0, "\(message): zero height")
        XCTAssertGreaterThanOrEqual(frame.minX, screen.minX - 1, "\(message): clipped left")
        XCTAssertLessThanOrEqual(frame.maxX, screen.maxX + 1, "\(message): clipped right")
        XCTAssertGreaterThanOrEqual(frame.minY, screen.minY - 1, "\(message): clipped top")
        XCTAssertLessThanOrEqual(frame.maxY, screen.maxY + 1, "\(message): clipped bottom")
    }

    private func value(_ key: String, locale: String) -> String {
        (try? localized(key, locale: locale)) ?? key
    }

    private func localized(_ key: String, locale: String? = nil) throws -> String {
        let json = try JSONSerialization.jsonObject(
            with: Data(contentsOf: catalogURL)
        ) as? [String: Any]
        let entry = (json?["strings"] as? [String: Any])?[key] as? [String: Any]
        let localization = (entry?["localizations"] as? [String: Any])?[locale ?? self.locale] as? [String: Any]
        let unit = localization?["stringUnit"] as? [String: Any]
        return try XCTUnwrap(unit?["value"] as? String, "missing value for \(key)")
    }
}

private struct QuizTreeFixture: Decodable {
    let root: String
    let nodes: [Node]
    let types: [Result]

    struct Node: Decodable {
        let id: String
        let questionKey: String
        let options: [Option]
    }

    struct Option: Decodable {
        let labelKey: String
        let next: String
    }

    struct Result: Decodable {
        let id: String
        let titleKey: String
        let textKey: String
    }

    func node(id: String) -> Node? {
        nodes.first { $0.id == id }
    }

    /// Option indices from root to any node or result id.
    func path(to id: String) -> [Int]? {
        var queue: [(String, [Int])] = [(root, [])]
        while !queue.isEmpty {
            let (current, path) = queue.removeFirst()
            if current == id { return path }
            guard let node = node(id: current) else { continue }
            for (index, option) in node.options.enumerated() {
                queue.append((option.next, path + [index]))
            }
        }
        return nil
    }
}
