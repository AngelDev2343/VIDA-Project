import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), phrase: "Dios sigue trabajando en ti")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), phrase: readPhrase())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), phrase: readPhrase())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    private func readPhrase() -> String {
        let defaults = UserDefaults(suiteName: "group.com.vida.project")
        return defaults?.string(forKey: "phrase") ?? ""
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let phrase: String
}

struct ContraPecadoWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 6) {
                Text("\"\(entry.phrase)\"")
                    .font(.custom("Georgia-Italic", size: 14))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                if !entry.phrase.isEmpty {
                    Text("CONTRA EL PECADO")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(.white.opacity(0.55))
                        .kerning(1)
                }
            }
            .padding(16)
        }
    }
}

@main
struct ContraPecadoWidget: Widget {
    let kind: String = "ContraPecadoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ContraPecadoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Contra pecado")
        .description("Frase diaria para recordar tu propósito")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
