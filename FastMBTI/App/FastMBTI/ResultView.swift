import SwiftUI
import FastMBTICore

struct ResultView: View {
    let result: ResultType
    let restart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(result.id)
                .font(.system(size: 56, weight: .black, design: .rounded))
                .accessibilityIdentifier("result.\(result.id)")

            ViewThatFits {
                Text(String(localized: String.LocalizationValue(result.titleKey)))
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text(String(localized: String.LocalizationValue(result.titleKey)))
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }

            Text(String(localized: String.LocalizationValue(result.textKey)))
                .font(.body)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Button(action: restart) {
                Image(systemName: "arrow.clockwise")
                    .font(.title2)
            }
            .buttonStyle(.bordered)
            .accessibilityLabel(String(localized: "ui.restart"))
            .accessibilityIdentifier("restart")
        }
        .padding()
    }
}

#Preview("en") {
    ResultView(result: try! QuizTree.load().result(id: "INTJ")!, restart: {})
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("zh-Hant") {
    ResultView(result: try! QuizTree.load().result(id: "INTJ")!, restart: {})
        .environment(\.locale, Locale(identifier: "zh-Hant"))
}

#Preview("ja") {
    ResultView(result: try! QuizTree.load().result(id: "INTJ")!, restart: {})
        .environment(\.locale, Locale(identifier: "ja"))
}

#Preview("ko") {
    ResultView(result: try! QuizTree.load().result(id: "INTJ")!, restart: {})
        .environment(\.locale, Locale(identifier: "ko"))
}
