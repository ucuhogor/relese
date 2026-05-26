import Foundation
import SwiftUI

enum Sport: String, CaseIterable, Identifiable {
    case football = "Football"
    case basketball = "Basketball"
    case hockey = "Hockey"

    var id: String { rawValue }
}

enum TrendKind: String, Codable {
    case hot
    case scoring
    case defensive
    case slump
    case unbeaten

    var iconName: String {
        switch self {
        case .hot: "flame.fill"
        case .scoring: "soccerball"
        case .defensive: "shield.fill"
        case .slump: "arrow.down.right.circle.fill"
        case .unbeaten: "bolt.shield.fill"
        }
    }

    var tint: Color {
        switch self {
        case .hot: Theme.flameOrange
        case .scoring: Theme.aqua
        case .defensive: Theme.mostBlue
        case .slump: Color(red: 0.72, green: 0.14, blue: 0.18)
        case .unbeaten: Color(red: 0.12, green: 0.62, blue: 0.42)
        }
    }
}

struct Team: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let shortName: String
    let league: String
    let sport: Sport
    let seed: Int
}

struct MatchResult: Identifiable {
    let id = UUID()
    let homeTeam: Team
    let awayTeam: Team
    let homeScore: Int
    let awayScore: Int
    let clock: String
    let status: String
    let isLive: Bool
    let note: String
    let swingTeam: Team?

    var scoreline: String { "\(homeScore)-\(awayScore)" }
    var sport: Sport { homeTeam.sport }
    var leader: Team? {
        if homeScore == awayScore { return nil }
        return homeScore > awayScore ? homeTeam : awayTeam
    }
}

struct TeamForm: Identifiable {
    let id = UUID()
    let team: Team
    let points: Int
    let goalDifference: Int
    let recent: [String]
    let momentum: Int
    let trend: TrendKind
    let summary: String
    let nextFixture: String

    var formText: String { recent.joined(separator: " ") }
}

struct StreakCard: Identifiable {
    let id = UUID()
    let team: Team
    let title: String
    let detail: String
    let count: Int
    let trend: TrendKind
    let confidence: Int
}

struct StreakAlert: Identifiable {
    let id = UUID()
    let team: Team
    let trigger: String
    var isEnabled: Bool
}

struct TeamComparison {
    let home: TeamForm
    let away: TeamForm

    var edge: String {
        let delta = home.momentum - away.momentum
        if delta > 8 { return "\(home.team.shortName) has the sharper current trend" }
        if delta < -8 { return "\(away.team.shortName) has the sharper current trend" }
        return "Momentum is nearly even"
    }
}
