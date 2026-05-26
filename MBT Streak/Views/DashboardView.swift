import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 18) {
                        HeaderPanel()
                        SportSelector()
                        FavoritesStrip()

                        SectionTitle("Streak cards", action: "Momentum sorted")
                        ForEach(store.filteredStreaks) { card in
                            StreakCardView(card: card)
                        }

                        SectionTitle("Team form")
                        LazyVStack(spacing: 12) {
                            ForEach(store.filteredForms) { form in
                                TeamFormRow(form: form)
                            }
                        }

                        SmartRecapView()
                    }
                    .padding(16)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct StreakCardView: View {
    let card: StreakCard

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                TeamMark(team: card.team, size: 58)
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.team.name)
                        .font(.headline.bold())
                        .foregroundStyle(Theme.ink)
                    Text(card.team.league)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 8) {
                    FavoriteStarButton(team: card.team)
                    TrendBadge(trend: card.trend, text: "\(card.count)x")
                }
            }

            Text(card.title)
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundStyle(Theme.mostBlue)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            Text(card.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Text("Signal confidence")
                    .font(.caption.bold())
                    .foregroundStyle(Theme.ink)
                Spacer()
                Text("\(card.confidence)%")
                    .font(.caption.bold())
                    .foregroundStyle(card.trend.tint)
            }
            MomentumBar(value: card.confidence, tint: card.trend.tint)
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct TeamFormRow: View {
    let form: TeamForm

    var body: some View {
        HStack(spacing: 12) {
            TeamMark(team: form.team, size: 48)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(form.team.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(Theme.ink)
                        .lineLimit(1)
                    Spacer()
                    FavoriteStarButton(team: form.team)
                    Text("\(form.momentum)")
                        .font(.headline.bold())
                        .foregroundStyle(form.trend.tint)
                }
                HStack(spacing: 5) {
                    ForEach(Array(form.recent.enumerated()), id: \.offset) { _, result in
                        Text(result)
                            .font(.caption2.bold())
                            .foregroundStyle(result == "W" ? Theme.cleanWhite : Theme.ink)
                            .frame(width: 24, height: 24)
                            .background(result == "W" ? Theme.mostBlue : result == "L" ? Theme.flameOrange.opacity(0.2) : Theme.aqua.opacity(0.45), in: RoundedRectangle(cornerRadius: 6))
                    }
                    Spacer()
                    Text(form.nextFixture)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                MomentumBar(value: form.momentum, tint: form.trend.tint)
            }
        }
        .padding(14)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct SmartRecapView: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundStyle(Theme.flameOrange)
                Text("Smart recap")
                    .font(.headline.bold())
                Spacer()
            }
            .foregroundStyle(Theme.ink)

            ForEach(store.recapBullets, id: \.self) { bullet in
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(Theme.aqua)
                        .frame(width: 7, height: 7)
                        .padding(.top, 6)
                    Text(bullet)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}
