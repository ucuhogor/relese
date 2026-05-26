import SwiftUI

struct AppBackground<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Theme.softBlue.ignoresSafeArea()
            content
        }
    }
}

struct HeaderPanel: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("MBT Streak")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                    Text("See the streak. Know the momentum.")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Theme.aqua)
                }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(Theme.cleanWhite)
                    .frame(width: 48, height: 48)
                    .background(Theme.flameOrange, in: RoundedRectangle(cornerRadius: 8))
            }

            HStack(spacing: 12) {
                MetricPill(title: "Teams", value: "\(store.filteredForms.count)")
                MetricPill(title: "Live games", value: "\(store.filteredLiveMatches.count)")
                MetricPill(title: "Favorites", value: "\(store.favoriteTeamIDs.count)")
            }
        }
        .foregroundStyle(Theme.cleanWhite)
        .padding(20)
        .background(LinearGradient.streakHeader, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct FavoriteStarButton: View {
    @EnvironmentObject private var store: StreakStore
    let team: Team

    var body: some View {
        Button {
            store.toggleFavorite(team)
        } label: {
            Image(systemName: store.isFavorite(team) ? "star.fill" : "star")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(store.isFavorite(team) ? Theme.flameOrange : Theme.mostBlue)
                .frame(width: 34, height: 34)
                .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(store.isFavorite(team) ? "Remove favorite" : "Add favorite")
    }
}

struct FavoritesStrip: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionTitle("Favorites", action: store.favoriteForms.isEmpty ? "Tap stars" : "\(store.favoriteForms.count) tracking")

            if store.favoriteForms.isEmpty {
                Text("Star any team to pin its logo, form and momentum here.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(store.favoriteForms) { form in
                            FavoriteChip(form: form)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }
}

struct FavoriteChip: View {
    let form: TeamForm

    var body: some View {
        HStack(spacing: 9) {
            TeamMark(team: form.team, size: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(form.team.shortName)
                    .font(.caption.bold())
                    .foregroundStyle(Theme.ink)
                Text("\(form.momentum) momentum")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(form.trend.tint)
            }
        }
        .padding(10)
        .frame(width: 142, alignment: .leading)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct MiniTeamLine: View {
    let team: Team?
    let fallback: String

    var body: some View {
        HStack(spacing: 8) {
            if let team {
                TeamMark(team: team, size: 28)
            } else {
                Text(fallback)
                    .font(.caption2.bold())
                    .foregroundStyle(Theme.cleanWhite)
                    .frame(width: 28, height: 28)
                    .background(Theme.mostBlue, in: Circle())
            }
            Text(team?.shortName ?? fallback)
                .font(.headline.bold())
        }
    }
}

struct MetricPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(.headline.bold())
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundStyle(Theme.cleanWhite.opacity(0.74))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Theme.cleanWhite.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
    }
}

struct SportSelector: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Sport.allCases) { sport in
                Button {
                    store.selectSport(sport)
                } label: {
                    Text(sport.rawValue)
                        .font(.caption.weight(.bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(store.selectedSport == sport ? Theme.mostBlue : Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(store.selectedSport == sport ? Theme.cleanWhite : Theme.mostBlue)
                }
                .buttonStyle(.plain)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

struct SectionTitle: View {
    let title: String
    let action: String?

    init(_ title: String, action: String? = nil) {
        self.title = title
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(Theme.ink)
            Spacer()
            if let action {
                Text(action)
                    .font(.caption.bold())
                    .foregroundStyle(Theme.flameOrange)
            }
        }
    }
}

struct TrendBadge: View {
    let trend: TrendKind
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: trend.iconName)
                .imageScale(.small)
            Text(text)
                .lineLimit(1)
                .minimumScaleFactor(0.72)
        }
        .font(.caption.bold())
        .foregroundStyle(trend == .scoring ? Theme.ink : Theme.cleanWhite)
        .padding(.vertical, 7)
        .padding(.horizontal, 10)
        .background(trend.tint, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct MomentumBar: View {
    let value: Int
    let tint: Color

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(Theme.line)
                Capsule()
                    .fill(tint)
                    .frame(width: max(10, proxy.size.width * CGFloat(value) / 100))
            }
        }
        .frame(height: 8)
    }
}

struct TeamMark: View {
    let team: Team
    let size: CGFloat

    var body: some View {
        Text(team.shortName)
            .font(.system(size: size * 0.28, weight: .black, design: .rounded))
            .foregroundStyle(Theme.cleanWhite)
            .frame(width: size, height: size)
            .background(
                ZStack {
                    Circle().fill(primaryColor)
                    Circle().stroke(secondaryColor, lineWidth: max(2, size * 0.05))
                    Rectangle()
                        .fill(Theme.flameOrange)
                        .frame(width: size * 0.9, height: 5)
                        .rotationEffect(.degrees(-22))
                }
            )
            .clipShape(Circle())
    }

    private var primaryColor: Color {
        let hue = Double((team.seed * 37) % 360) / 360
        return Color(hue: hue, saturation: 0.68, brightness: 0.46)
    }

    private var secondaryColor: Color {
        team.seed.isMultiple(of: 2) ? Theme.aqua : Theme.cleanWhite.opacity(0.82)
    }
}
