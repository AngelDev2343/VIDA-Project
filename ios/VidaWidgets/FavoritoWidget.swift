import SwiftUI
import WidgetKit

private let appGroupId = "group.com.vida.project"

struct FavoritoProvider: TimelineProvider {
    func placeholder(in context: Context) -> FavoritoEntry {
        FavoritoEntry(
            date: Date(),
            ref: "Juan 3:16",
            verse: "Porque de tal manera amó Dios al mundo…",
            enabled: true,
            darkBg: false
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (FavoritoEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<FavoritoEntry>) -> Void) {
        let entry = readEntry()
        let next = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func readEntry() -> FavoritoEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let enabled = defaults?.bool(forKey: "favorito") ?? false
        let ref = defaults?.string(forKey: "fav_ref") ?? ""
        let verse = defaults?.string(forKey: "fav_verse") ?? ""
        let dark = defaults?.bool(forKey: "fav_dark_bg") ?? false
        return FavoritoEntry(
            date: Date(),
            ref: ref,
            verse: verse,
            enabled: enabled && !verse.isEmpty,
            darkBg: dark
        )
    }
}

struct FavoritoEntry: TimelineEntry {
    let date: Date
    let ref: String
    let verse: String
    let enabled: Bool
    let darkBg: Bool
}

struct FavoritoWidgetView: View {
    var entry: FavoritoEntry

    var body: some View {
        let textColor = entry.darkBg ? Color.white : Color.black.opacity(0.87)
        let refColor = entry.darkBg ? Color.white.opacity(0.75) : Color.black.opacity(0.55)
        ZStack {
            LinearGradient(
                colors: entry.darkBg
                    ? [Color(white: 0.12), Color(white: 0.05)]
                    : [Color(red: 0.93, green: 0.97, blue: 0.94), Color.white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            if entry.enabled {
                VStack(spacing: 8) {
                    Text("\"\(entry.verse)\"")
                        .font(.custom("Georgia-Italic", size: 13))
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                    Text(entry.ref.uppercased())
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(refColor)
                        .kerning(1.1)
                }
                .padding(16)
            } else {
                Text("Elige un versículo favorito en VIDA")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .widgetURL(URL(string: "vida://favorito"))
    }
}

struct FavoritoWidget: Widget {
    let kind: String = "FavoritoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FavoritoProvider()) { entry in
            if #available(iOSApplicationExtension 17.0, *) {
                FavoritoWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.white
                    }
            } else {
                FavoritoWidgetView(entry: entry)
            }
        }
        .configurationDisplayName("Widget favorito")
        .description("Tu versículo favorito en la pantalla de inicio")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
