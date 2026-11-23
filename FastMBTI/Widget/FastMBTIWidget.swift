import WidgetKit
import SwiftUI

// 暫用寫死句子驗證骨架；§4 之後改讀 App Group + 句子庫
struct FastMBTIWidgetEntry: TimelineEntry {
    let date: Date
    let text: String
    let type: String
}

struct FastMBTIWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> FastMBTIWidgetEntry {
        FastMBTIWidgetEntry(date: Date(), text: "今天先不要當好人。", type: "INTJ")
    }

    func getSnapshot(in context: Context, completion: @escaping (FastMBTIWidgetEntry) -> Void) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<FastMBTIWidgetEntry>) -> Void) {
        completion(Timeline(entries: [placeholder(in: context)], policy: .atEnd))
    }
}

struct FastMBTIWidgetView: View {
    let entry: FastMBTIWidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("today's meme")
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(entry.text)
                .font(.system(size: 14, weight: .semibold))
                .minimumScaleFactor(0.8)
                .lineLimit(3)
            Text(entry.type)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(entry.date, style: .date)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct FastMBTIWidget: Widget {
    let kind: String = "FastMBTIWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FastMBTIWidgetProvider()) { entry in
            FastMBTIWidgetView(entry: entry)
        }
        .configurationDisplayName("today's meme")
        .description("每天一句，陪你認識自己的型。")
        .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}

@main
struct FastMBTIWidgetBundle: WidgetBundle {
    var body: some Widget {
        FastMBTIWidget()
    }
}
