import SwiftUI

struct LiveView: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 16) {
                        LiveTickerHeader()
                        SportSelector()
                        LiveSummaryPanel()
                        FavoritesStrip()

                        if !store.liveNowMatches.isEmpty {
                            SectionTitle("Live now", action: "\(store.liveNowMatches.count) in play")
                            ForEach(store.liveNowMatches) { match in
                                LiveMatchRow(match: match)
                            }
                        }

                        if !store.finalMatches.isEmpty {
                            SectionTitle("Finals", action: "Streak impact locked")
                            ForEach(store.finalMatches) { match in
                                LiveMatchRow(match: match)
                            }
                        }

                        if store.filteredLiveMatches.isEmpty {
                            EmptyLiveState()
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Live results")
        }
    }
}

struct LiveSummaryPanel: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        HStack(spacing: 10) {
            LiveMetricTile(title: "In play", value: "\(store.liveNowMatches.count)", tint: Theme.flameOrange)
            LiveMetricTile(title: "Final", value: "\(store.finalMatches.count)", tint: Theme.mostBlue)
            LiveMetricTile(title: "Impacts", value: "\(store.filteredLiveMatches.filter { $0.swingTeam != nil }.count)", tint: Theme.aqua)
        }
    }
}

struct LiveMetricTile: View {
    let title: String
    let value: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.title2.weight(.black))
                .foregroundStyle(tint)
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct LiveTickerHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Live momentum")
                    .font(.title2.weight(.black))
                Text("Results update the streak board as matches move.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.cleanWhite.opacity(0.76))
            }
            Spacer()
            Image(systemName: "dot.radiowaves.left.and.right")
                .font(.title2.bold())
                .foregroundStyle(Theme.aqua)
        }
        .foregroundStyle(Theme.cleanWhite)
        .padding(18)
        .background(LinearGradient.streakHeader, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct LiveMatchRow: View {
    @EnvironmentObject private var store: StreakStore
    let match: MatchResult

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    ScoreLine(team: match.homeTeam, score: match.homeScore, isLeader: match.leader?.id == match.homeTeam.id)
                    ScoreLine(team: match.awayTeam, score: match.awayScore, isLeader: match.leader?.id == match.awayTeam.id)
                }
                .foregroundStyle(Theme.ink)

                VStack(spacing: 8) {
                    Text(match.clock)
                        .font(.caption.bold())
                        .foregroundStyle(match.isLive ? Theme.cleanWhite : Theme.ink)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 9)
                        .background(match.isLive ? Theme.flameOrange : Theme.line, in: RoundedRectangle(cornerRadius: 8))
                    Text(match.status)
                        .font(.caption2.bold())
                        .foregroundStyle(.secondary)
                    FavoriteStarButton(team: match.homeTeam)
                }
                .frame(width: 74)
            }

            HStack(alignment: .top, spacing: 9) {
                Image(systemName: match.swingTeam == nil ? "equal.circle.fill" : "bolt.fill")
                    .foregroundStyle(match.swingTeam == nil ? Theme.mostBlue : Theme.flameOrange)
                Text(match.note)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(10)
            .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))

            if let swingTeam = match.swingTeam {
                TrendBadge(trend: trend(for: swingTeam), text: "\(swingTeam.shortName) impact")
            }
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }

    private func trend(for team: Team) -> TrendKind {
        store.forms.first { $0.team.id == team.id }?.trend ?? .hot
    }
}

struct ScoreLine: View {
    let team: Team
    let score: Int
    let isLeader: Bool

    var body: some View {
        HStack {
            MiniTeamLine(team: team, fallback: team.shortName)
            if isLeader {
                Image(systemName: "chevron.left")
                    .font(.caption.bold())
                    .foregroundStyle(Theme.flameOrange)
            }
            Spacer()
            Text("\(score)")
                .font(.title2.weight(.black))
                .foregroundStyle(isLeader ? Theme.flameOrange : Theme.ink)
        }
    }
}

struct EmptyLiveState: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "calendar.badge.clock")
                .font(.title2.bold())
                .foregroundStyle(Theme.mostBlue)
            Text("No matches for this sport right now")
                .font(.headline.bold())
                .foregroundStyle(Theme.ink)
            Text("Switch sports or check back when live fixtures are available.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}
