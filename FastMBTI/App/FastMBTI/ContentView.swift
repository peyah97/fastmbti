import SwiftUI
import FastMBTICore

struct ContentView: View {
    @State private var engine: QuizEngine?
    @State private var loadError: String?

    var body: some View {
        NavigationStack {
            Group {
                if let engine {
                    if engine.isFinished, let result = engine.currentResult {
                        ResultView(result: result) {
                            self.engine = nil
                            load()
                        }
                    } else {
                        QuizView(engine: engine) { index in
                            var next = engine
                            if (try? next.answer(optionAt: index)) != nil {
                                self.engine = next
                            }
                        }
                    }
                } else if let loadError {
                    Text(loadError)
                } else {
                    ProgressView()
                }
            }
        }
        .task { load() }
    }

    private func load() {
        do {
            loadError = nil
            engine = try QuizEngine(tree: QuizTree.load())
        } catch {
            loadError = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
