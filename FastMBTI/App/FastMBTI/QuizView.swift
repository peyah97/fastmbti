import SwiftUI
import FastMBTICore

struct QuizView: View {
    let engine: QuizEngine
    let answer: (Int) -> Void

    var body: some View {
        VStack(spacing: 28) {
            if let node = engine.currentNode {
                ViewThatFits {
                    Text(String(localized: String.LocalizationValue(node.questionKey)))
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(String(localized: String.LocalizationValue(node.questionKey)))
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(spacing: 12) {
                    ForEach(node.options.indices, id: \.self) { index in
                        Button {
                            answer(index)
                        } label: {
                            Text(String(localized: String.LocalizationValue(node.options[index].labelKey)))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                        }
                        .buttonStyle(.borderedProminent)
                        .accessibilityIdentifier("option.\(index)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview("en") {
    QuizView(engine: try! QuizEngine(tree: QuizTree.load()), answer: { _ in })
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("zh-Hant") {
    QuizView(engine: try! QuizEngine(tree: QuizTree.load()), answer: { _ in })
        .environment(\.locale, Locale(identifier: "zh-Hant"))
}

#Preview("ja") {
    QuizView(engine: try! QuizEngine(tree: QuizTree.load()), answer: { _ in })
        .environment(\.locale, Locale(identifier: "ja"))
}

#Preview("ko") {
    QuizView(engine: try! QuizEngine(tree: QuizTree.load()), answer: { _ in })
        .environment(\.locale, Locale(identifier: "ko"))
}
