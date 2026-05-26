import SwiftUI

struct SettingsStatsPrivacyView: View {
    @EnvironmentObject private var store: StreakStore
    @State private var pushAlerts = true
    @State private var liveRefresh = true
    @State private var recapAfterRound = true
    @State private var analytics = false
    @State private var localOnly = true

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 16) {
                        SettingsHeader()
                        StatsPanel()
                        SettingsPanel(pushAlerts: $pushAlerts, liveRefresh: $liveRefresh, recapAfterRound: $recapAfterRound)
                        PrivacyPanel(analytics: $analytics, localOnly: $localOnly)
                        DataControlPanel()
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsHeader: View {
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "slider.horizontal.3")
                .font(.title2.bold())
                .foregroundStyle(Theme.cleanWhite)
                .frame(width: 52, height: 52)
                .background(Theme.flameOrange, in: RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 5) {
                Text("Control center")
                    .font(.title2.weight(.black))
                Text("Settings, stats and privacy in one place.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.cleanWhite.opacity(0.74))
            }
            Spacer()
        }
        .foregroundStyle(Theme.cleanWhite)
        .padding(18)
        .background(LinearGradient.streakHeader, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct StatsPanel: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Statistics", action: store.selectedSport.rawValue)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                StatTile(title: "Tracked teams", value: "\(store.filteredForms.count)", icon: "person.3.fill", tint: Theme.mostBlue)
                StatTile(title: "Streak cards", value: "\(store.filteredStreaks.count)", icon: "flame.fill", tint: Theme.flameOrange)
                StatTile(title: "Live matches", value: "\(store.filteredLiveMatches.count)", icon: "dot.radiowaves.left.and.right", tint: Theme.aqua)
                StatTile(title: "Favorites", value: "\(store.favoriteForms.count)", icon: "star.fill", tint: Color(red: 0.96, green: 0.66, blue: 0.12))
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Average momentum")
                        .font(.caption.bold())
                    Spacer()
                    Text("\(averageMomentum)")
                        .font(.caption.bold())
                        .foregroundStyle(Theme.flameOrange)
                }
                MomentumBar(value: averageMomentum, tint: Theme.flameOrange)
            }
            .padding(12)
            .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }

    private var averageMomentum: Int {
        let forms = store.filteredForms
        guard !forms.isEmpty else { return 0 }
        return forms.map(\.momentum).reduce(0, +) / forms.count
    }
}

struct StatTile: View {
    let title: String
    let value: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.headline.bold())
                .foregroundStyle(tint)
            Text(value)
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundStyle(Theme.ink)
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct SettingsPanel: View {
    @Binding var pushAlerts: Bool
    @Binding var liveRefresh: Bool
    @Binding var recapAfterRound: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("App settings")
            SettingToggleRow(icon: "bell.badge.fill", title: "Push streak alerts", detail: "Notify when tracked runs start, extend or break.", isOn: $pushAlerts)
            SettingToggleRow(icon: "arrow.clockwise", title: "Live refresh", detail: "Keep live match cards and momentum signals current.", isOn: $liveRefresh)
            SettingToggleRow(icon: "sparkles", title: "Smart recap", detail: "Show a compact recap after each round.", isOn: $recapAfterRound)
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct PrivacyPanel: View {
    @Binding var analytics: Bool
    @Binding var localOnly: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Privacy")
            SettingToggleRow(icon: "lock.shield.fill", title: "Local favorites", detail: "Favorites and alert choices stay on this iPhone.", isOn: $localOnly)
            SettingToggleRow(icon: "chart.bar.xaxis", title: "Product analytics", detail: "Share anonymous usage counts to improve ranking quality.", isOn: $analytics)
            PrivacyNote(text: "No betting account, contact list or precise location is required for this app experience.")
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct DataControlPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Data controls")
            DataControlRow(icon: "square.and.arrow.down", title: "Export favorites", detail: "Prepare a local copy of teams and alert rules.")
            DataControlRow(icon: "trash", title: "Clear local data", detail: "Remove favorites, toggles and alert preferences.")
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct SettingToggleRow: View {
    let icon: String
    let title: String
    let detail: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.headline.bold())
                .foregroundStyle(Theme.mostBlue)
                .frame(width: 34, height: 34)
                .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundStyle(Theme.ink)
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Theme.flameOrange)
        }
        .padding(.vertical, 8)
    }
}

struct PrivacyNote: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .foregroundStyle(Theme.aqua)
            Text(text)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct DataControlRow: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.headline.bold())
                    .foregroundStyle(icon == "trash" ? Theme.flameOrange : Theme.mostBlue)
                    .frame(width: 34, height: 34)
                    .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.subheadline.bold())
                        .foregroundStyle(Theme.ink)
                    Text(detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
