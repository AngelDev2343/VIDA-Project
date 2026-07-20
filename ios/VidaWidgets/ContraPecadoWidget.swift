import SwiftUI
import WidgetKit

private let appGroupId = "group.com.vida.project"

struct ContraPecadoProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContraPecadoEntry {
        ContraPecadoEntry(date: Date(), phrase: "Dios sigue trabajando en ti", enabled: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (ContraPecadoEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ContraPecadoEntry>) -> Void) {
        let entry = readEntry()
        let next = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func readEntry() -> ContraPecadoEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let enabled = defaults?.bool(forKey: "contra_pecado") ?? false
        let phrase = defaults?.string(forKey: "phrase") ?? ""
        return ContraPecadoEntry(date: Date(), phrase: phrase, enabled: enabled && !phrase.isEmpty)
    }
}

struct ContraPecadoEntry: TimelineEntry {
    let date: Date
    let phrase: String
    let enabled: Bool
}

struct ContraPecadoWidgetView: View {
    var entry: ContraPecadoEntry

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.02, green: 0.22, blue: 0.16), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            if entry.enabled {
                VStack(spacing: 8) {
                    Text("\"\(entry.phrase)\"")
                        .font(.custom("Georgia-Italic", size: 15))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                    Text("CONTRA EL PECADO")
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundColor(.white.opacity(0.55))
                        .kerning(1.2)
                }
                .padding(16)
            } else {
                Text("Activa el widget en VIDA")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .widgetURL(URL(string: "vida://contrapecado"))
    }
}

struct ContraPecadoWidget: Widget {
    let kind: String = "ContraPecadoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContraPecadoProvider()) { entry in
            if #available(iOSApplicationExtension 17.0, *) {
                ContraPecadoWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black
                    }
            } else {
                ContraPecadoWidgetView(entry: entry)
            }
        }
        .configurationDisplayName("Contra pecado")
        .description("Frase diaria para recordar tu propósito")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
