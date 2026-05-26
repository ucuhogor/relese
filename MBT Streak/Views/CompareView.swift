import SwiftUI

struct CompareView: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 18) {
                        SectionTitle("Compare teams")
                        SportSelector()
                        FavoritesStrip()

                        HStack(spacing: 12) {
                            TeamPicker(title: "Team A", selection: $store.homeTeamID)
                            TeamPicker(title: "Team B", selection: $store.awayTeamID)
                        }

                        ComparisonPanel(comparison: store.comparison)
                        MatchupSignals(comparison: store.comparison)
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Compare")
        }
    }
}

struct TeamPicker: View {
    @EnvironmentObject private var store: StreakStore
    let title: String
    @Binding var selection: Team.ID

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
            Picker(title, selection: $selection) {
                ForEach(store.filteredForms) { form in
                    Text(form.team.shortName).tag(form.team.id)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct ComparisonPanel: View {
    let comparison: TeamComparison

    var body: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top, spacing: 12) {
                CompareTeamColumn(form: comparison.home)
                VStack(spacing: 8) {
                    Text("VS")
                        .font(.caption.bold())
                        .foregroundStyle(Theme.cleanWhite)
                        .frame(width: 38, height: 38)
                        .background(Theme.flameOrange, in: Circle())
                    Rectangle()
                        .fill(Theme.line)
                        .frame(width: 1, height: 128)
                }
                CompareTeamColumn(form: comparison.away)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(comparison.edge)
                    .font(.headline.bold())
                    .foregroundStyle(Theme.mostBlue)
                Text("Momentum combines result streaks, scoring consistency, defensive trend and recent match control.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct CompareTeamColumn: View {
    let form: TeamForm

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .topTrailing) {
                TeamMark(team: form.team, size: 64)
                FavoriteStarButton(team: form.team)
                    .offset(x: 18, y: -8)
            }
            Text(form.team.shortName)
                .font(.title2.weight(.black))
                .foregroundStyle(Theme.ink)
            Text(form.team.name)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 32)
            Text("\(form.momentum)")
                .font(.system(size: 34, weight: .black, design: .rounded))
                .foregroundStyle(form.trend.tint)
            MomentumBar(value: form.momentum, tint: form.trend.tint)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MatchupSignals: View {
    let comparison: TeamComparison

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Signal board")
            SignalRow(label: "Recent points", left: "\(comparison.home.points)", right: "\(comparison.away.points)", winnerLeft: comparison.home.points >= comparison.away.points)
            SignalRow(label: "Goal difference", left: signed(comparison.home.goalDifference), right: signed(comparison.away.goalDifference), winnerLeft: comparison.home.goalDifference >= comparison.away.goalDifference)
            SignalRow(label: "Form", left: comparison.home.formText, right: comparison.away.formText, winnerLeft: comparison.home.momentum >= comparison.away.momentum)
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }

    private func signed(_ value: Int) -> String {
        value > 0 ? "+\(value)" : "\(value)"
    }
}

struct SignalRow: View {
    let label: String
    let left: String
    let right: String
    let winnerLeft: Bool

    var body: some View {
        HStack {
            Text(left)
                .font(.subheadline.bold())
                .foregroundStyle(winnerLeft ? Theme.flameOrange : Theme.ink)
                .frame(width: 78, alignment: .leading)
            Text(label)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
            Text(right)
                .font(.subheadline.bold())
                .foregroundStyle(winnerLeft ? Theme.ink : Theme.flameOrange)
                .frame(width: 78, alignment: .trailing)
        }
        .padding(.vertical, 10)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Theme.line).frame(height: 1)
        }
    }
}
