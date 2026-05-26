import Foundation

final class StreakStore: ObservableObject {
    @Published var selectedSport: Sport = .football
    @Published var forms: [TeamForm] = DemoStreakData.forms
    @Published var streaks: [StreakCard] = DemoStreakData.streaks
    @Published var liveMatches: [MatchResult] = DemoStreakData.liveMatches
    @Published var alerts: [StreakAlert] = DemoStreakData.alerts
    @Published var favoriteTeamIDs: Set<Team.ID> = [
        DemoStreakData.forms[0].team.id,
        DemoStreakData.forms[2].team.id,
        DemoStreakData.forms[10].team.id
    ]
    @Published var homeTeamID: Team.ID = DemoStreakData.forms[0].team.id
    @Published var awayTeamID: Team.ID = DemoStreakData.forms[1].team.id

    var filteredForms: [TeamForm] {
        forms.filter { $0.team.sport == selectedSport }
    }

    var filteredStreaks: [StreakCard] {
        streaks.filter { $0.team.sport == selectedSport }
    }

    var filteredLiveMatches: [MatchResult] {
        liveMatches.filter { $0.sport == selectedSport }
    }

    var liveNowMatches: [MatchResult] {
        filteredLiveMatches.filter(\.isLive)
    }

    var finalMatches: [MatchResult] {
        filteredLiveMatches.filter { !$0.isLive }
    }

    var favoriteForms: [TeamForm] {
        filteredForms.filter { favoriteTeamIDs.contains($0.team.id) }
    }

    var comparison: TeamComparison {
        let visible = filteredForms
        let home = visible.first { $0.team.id == homeTeamID } ?? visible.first ?? forms[0]
        let away = visible.first { $0.team.id == awayTeamID && $0.team.id != home.team.id } ?? visible.dropFirst().first ?? forms[1]
        return TeamComparison(home: home, away: away)
    }

    var recapBullets: [String] {
        [
            "Inter own the cleanest momentum profile: five wins, three clean wins, one conceded.",
            "City remain the most stable favorite with a 92 momentum score and five unbeaten.",
            "Arsenal's attack is the loud trend: goals in eight straight despite a mixed last five.",
            "Denver are the watchlist risk after three slow starts in the last five games."
        ]
    }

    func selectSport(_ sport: Sport) {
        selectedSport = sport
        let visible = forms.filter { $0.team.sport == sport }
        if let first = visible.first {
            homeTeamID = first.team.id
        }
        if let second = visible.dropFirst().first {
            awayTeamID = second.team.id
        }
    }

    func toggleAlert(_ alert: StreakAlert) {
        guard let index = alerts.firstIndex(where: { $0.id == alert.id }) else { return }
        alerts[index].isEnabled.toggle()
    }

    func addAlert(team: Team, trigger: String) {
        let cleanTrigger = trigger.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanTrigger.isEmpty else { return }
        alerts.insert(StreakAlert(team: team, trigger: cleanTrigger, isEnabled: true), at: 0)
        favoriteTeamIDs.insert(team.id)
    }

    func team(shortName: String) -> Team? {
        forms.first { $0.team.shortName == shortName && $0.team.sport == selectedSport }?.team
            ?? forms.first { $0.team.shortName == shortName }?.team
    }

    func isFavorite(_ team: Team) -> Bool {
        favoriteTeamIDs.contains(team.id)
    }

    func toggleFavorite(_ team: Team) {
        if favoriteTeamIDs.contains(team.id) {
            favoriteTeamIDs.remove(team.id)
        } else {
            favoriteTeamIDs.insert(team.id)
        }
    }
}
