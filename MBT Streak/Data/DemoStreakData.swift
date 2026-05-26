import Foundation

enum DemoStreakData {
    static let teams: [Team] = [
        Team(name: "Manchester City", shortName: "MCI", league: "Premier League", sport: .football, seed: 1),
        Team(name: "Arsenal", shortName: "ARS", league: "Premier League", sport: .football, seed: 2),
        Team(name: "Inter Milan", shortName: "INT", league: "Serie A", sport: .football, seed: 3),
        Team(name: "Real Madrid", shortName: "RMA", league: "LaLiga", sport: .football, seed: 4),
        Team(name: "Barcelona", shortName: "BAR", league: "LaLiga", sport: .football, seed: 5),
        Team(name: "Bayern Munich", shortName: "BAY", league: "Bundesliga", sport: .football, seed: 6),
        Team(name: "Paris Saint-Germain", shortName: "PSG", league: "Ligue 1", sport: .football, seed: 7),
        Team(name: "Liverpool", shortName: "LIV", league: "Premier League", sport: .football, seed: 8),
        Team(name: "AC Milan", shortName: "MIL", league: "Serie A", sport: .football, seed: 9),
        Team(name: "Borussia Dortmund", shortName: "BVB", league: "Bundesliga", sport: .football, seed: 10),
        Team(name: "Boston Celtics", shortName: "BOS", league: "NBA", sport: .basketball, seed: 11),
        Team(name: "Denver Nuggets", shortName: "DEN", league: "NBA", sport: .basketball, seed: 12),
        Team(name: "Los Angeles Lakers", shortName: "LAL", league: "NBA", sport: .basketball, seed: 13),
        Team(name: "Golden State Warriors", shortName: "GSW", league: "NBA", sport: .basketball, seed: 14),
        Team(name: "Milwaukee Bucks", shortName: "MIL", league: "NBA", sport: .basketball, seed: 15),
        Team(name: "Dallas Mavericks", shortName: "DAL", league: "NBA", sport: .basketball, seed: 16),
        Team(name: "Miami Heat", shortName: "MIA", league: "NBA", sport: .basketball, seed: 17),
        Team(name: "Phoenix Suns", shortName: "PHX", league: "NBA", sport: .basketball, seed: 18),
        Team(name: "Florida Panthers", shortName: "FLA", league: "NHL", sport: .hockey, seed: 19),
        Team(name: "New York Rangers", shortName: "NYR", league: "NHL", sport: .hockey, seed: 20),
        Team(name: "Toronto Maple Leafs", shortName: "TOR", league: "NHL", sport: .hockey, seed: 21),
        Team(name: "Edmonton Oilers", shortName: "EDM", league: "NHL", sport: .hockey, seed: 22),
        Team(name: "Colorado Avalanche", shortName: "COL", league: "NHL", sport: .hockey, seed: 23),
        Team(name: "Vegas Golden Knights", shortName: "VGK", league: "NHL", sport: .hockey, seed: 24),
        Team(name: "Boston Bruins", shortName: "BOS", league: "NHL", sport: .hockey, seed: 25),
        Team(name: "Dallas Stars", shortName: "DAL", league: "NHL", sport: .hockey, seed: 26)
    ]

    static let forms: [TeamForm] = [
        TeamForm(team: teams[0], points: 13, goalDifference: 9, recent: ["W", "W", "D", "W", "W"], momentum: 92, trend: .hot, summary: "Unbeaten in 5, scoring first in four straight.", nextFixture: "vs Chelsea"),
        TeamForm(team: teams[1], points: 11, goalDifference: 6, recent: ["W", "D", "W", "W", "L"], momentum: 78, trend: .scoring, summary: "Goals in every match across the last six.", nextFixture: "at Tottenham"),
        TeamForm(team: teams[2], points: 15, goalDifference: 11, recent: ["W", "W", "W", "W", "W"], momentum: 96, trend: .defensive, summary: "Three clean wins and only one goal conceded.", nextFixture: "vs Roma"),
        TeamForm(team: teams[3], points: 10, goalDifference: 4, recent: ["D", "W", "W", "L", "W"], momentum: 71, trend: .unbeaten, summary: "Late-match goals keep protecting points.", nextFixture: "at Sevilla"),
        TeamForm(team: teams[4], points: 12, goalDifference: 8, recent: ["W", "W", "L", "W", "D"], momentum: 82, trend: .scoring, summary: "Wide chance creation keeps the attack reliable.", nextFixture: "vs Valencia"),
        TeamForm(team: teams[5], points: 14, goalDifference: 13, recent: ["W", "W", "W", "D", "W"], momentum: 93, trend: .hot, summary: "Four multi-goal wins across the last five.", nextFixture: "at Leipzig"),
        TeamForm(team: teams[6], points: 9, goalDifference: 2, recent: ["L", "W", "D", "W", "L"], momentum: 58, trend: .slump, summary: "Transitions are sharp, but defensive gaps remain.", nextFixture: "vs Marseille"),
        TeamForm(team: teams[7], points: 12, goalDifference: 7, recent: ["W", "W", "D", "L", "W"], momentum: 79, trend: .unbeaten, summary: "Pressing wins are turning into early shots.", nextFixture: "vs Everton"),
        TeamForm(team: teams[8], points: 8, goalDifference: -1, recent: ["D", "L", "W", "D", "L"], momentum: 43, trend: .slump, summary: "Milan have conceded first in four of five.", nextFixture: "at Lazio"),
        TeamForm(team: teams[9], points: 10, goalDifference: 3, recent: ["W", "L", "W", "W", "D"], momentum: 66, trend: .scoring, summary: "Young attackers are creating steady second-half xG.", nextFixture: "vs Frankfurt"),
        TeamForm(team: teams[10], points: 12, goalDifference: 42, recent: ["W", "W", "W", "L", "W"], momentum: 88, trend: .hot, summary: "Bench scoring is up 18% over the last week.", nextFixture: "vs Knicks"),
        TeamForm(team: teams[11], points: 7, goalDifference: -8, recent: ["L", "W", "L", "L", "W"], momentum: 45, trend: .slump, summary: "Slow starts have created double-digit deficits.", nextFixture: "at Suns"),
        TeamForm(team: teams[12], points: 8, goalDifference: -14, recent: ["L", "L", "W", "D", "L"], momentum: 39, trend: .slump, summary: "Late rallies are masking rough defensive openings.", nextFixture: "vs Clippers"),
        TeamForm(team: teams[13], points: 11, goalDifference: 31, recent: ["W", "W", "D", "W", "L"], momentum: 74, trend: .scoring, summary: "Three-point volume is back above season average.", nextFixture: "at Kings"),
        TeamForm(team: teams[14], points: 10, goalDifference: 18, recent: ["W", "L", "W", "W", "D"], momentum: 70, trend: .unbeaten, summary: "Paint touches are stabilizing close games.", nextFixture: "vs Bulls"),
        TeamForm(team: teams[15], points: 13, goalDifference: 36, recent: ["W", "W", "W", "W", "L"], momentum: 86, trend: .hot, summary: "Half-court offense has scored 120+ in four straight.", nextFixture: "at Spurs"),
        TeamForm(team: teams[16], points: 9, goalDifference: 6, recent: ["D", "W", "L", "W", "W"], momentum: 62, trend: .defensive, summary: "Zone looks have slowed opponent runs.", nextFixture: "vs Hawks"),
        TeamForm(team: teams[17], points: 8, goalDifference: -5, recent: ["L", "W", "D", "L", "W"], momentum: 52, trend: .scoring, summary: "Shot quality is improving, but variance is high.", nextFixture: "vs Nuggets"),
        TeamForm(team: teams[18], points: 9, goalDifference: 5, recent: ["W", "L", "W", "D", "W"], momentum: 68, trend: .defensive, summary: "Goalie save rate is climbing under pressure.", nextFixture: "vs Rangers"),
        TeamForm(team: teams[19], points: 13, goalDifference: 10, recent: ["W", "W", "W", "L", "W"], momentum: 84, trend: .hot, summary: "Special teams have swung three straight games.", nextFixture: "at Panthers"),
        TeamForm(team: teams[20], points: 7, goalDifference: -3, recent: ["L", "D", "W", "L", "W"], momentum: 49, trend: .slump, summary: "Toronto are trading too many rush chances.", nextFixture: "vs Bruins"),
        TeamForm(team: teams[21], points: 12, goalDifference: 8, recent: ["W", "W", "L", "W", "W"], momentum: 81, trend: .scoring, summary: "Power-play scoring has landed in four straight.", nextFixture: "at Flames"),
        TeamForm(team: teams[22], points: 11, goalDifference: 6, recent: ["W", "D", "W", "L", "W"], momentum: 73, trend: .unbeaten, summary: "Top line possession is carrying road games.", nextFixture: "vs Wild"),
        TeamForm(team: teams[23], points: 6, goalDifference: -7, recent: ["L", "L", "W", "L", "D"], momentum: 36, trend: .slump, summary: "Vegas have allowed first-period goals in four games.", nextFixture: "at Kings"),
        TeamForm(team: teams[24], points: 10, goalDifference: 4, recent: ["W", "W", "D", "L", "W"], momentum: 65, trend: .defensive, summary: "Boston are limiting rebounds in front.", nextFixture: "at Maple Leafs"),
        TeamForm(team: teams[25], points: 12, goalDifference: 9, recent: ["W", "W", "W", "D", "L"], momentum: 80, trend: .hot, summary: "Dallas have closed three one-goal games calmly.", nextFixture: "vs Kraken")
    ]

    static let streaks: [StreakCard] = [
        StreakCard(team: teams[2], title: "5 wins running", detail: "Inter are controlling matches early and closing clean.", count: 5, trend: .hot, confidence: 94),
        StreakCard(team: teams[0], title: "5 unbeaten", detail: "City have not trailed at half-time in this streak.", count: 5, trend: .unbeaten, confidence: 91),
        StreakCard(team: teams[1], title: "Scored in 8 straight", detail: "Arsenal average 2.1 goals during the run.", count: 8, trend: .scoring, confidence: 87),
        StreakCard(team: teams[5], title: "4 multi-goal wins", detail: "Bayern are finishing early and keeping pressure high.", count: 4, trend: .hot, confidence: 90),
        StreakCard(team: teams[8], title: "Conceded first in 4", detail: "Milan keep playing from behind before the hour.", count: 4, trend: .slump, confidence: 78),
        StreakCard(team: teams[10], title: "4 wins in 5", detail: "Boston's second unit is stretching every lead.", count: 4, trend: .hot, confidence: 86),
        StreakCard(team: teams[11], title: "3 rough starts", detail: "Denver allowed the first 10 points in three games.", count: 3, trend: .slump, confidence: 76),
        StreakCard(team: teams[15], title: "120+ in 4 straight", detail: "Dallas are winning the half-court shot diet.", count: 4, trend: .scoring, confidence: 88),
        StreakCard(team: teams[18], title: "2 low-event wins", detail: "Florida are keeping opponents outside the slot.", count: 2, trend: .defensive, confidence: 82),
        StreakCard(team: teams[19], title: "3 special-team swings", detail: "Rangers power-play goals changed three games.", count: 3, trend: .hot, confidence: 84),
        StreakCard(team: teams[21], title: "Power play in 4", detail: "Edmonton keep turning pressure into goals.", count: 4, trend: .scoring, confidence: 89),
        StreakCard(team: teams[23], title: "4 first-period leaks", detail: "Vegas are chasing games too often lately.", count: 4, trend: .slump, confidence: 80)
    ]

    static let liveMatches: [MatchResult] = [
        MatchResult(homeTeam: teams[0], awayTeam: teams[1], homeScore: 2, awayScore: 1, clock: "72'", status: "Live", isLive: true, note: "City's unbeaten run is currently protected; Arsenal scoring streak remains alive.", swingTeam: teams[0]),
        MatchResult(homeTeam: teams[4], awayTeam: teams[3], homeScore: 1, awayScore: 1, clock: "61'", status: "Live", isLive: true, note: "Draw state keeps both form lines neutral, next goal flips matchup momentum.", swingTeam: nil),
        MatchResult(homeTeam: teams[2], awayTeam: teams[8], homeScore: 1, awayScore: 0, clock: "HT", status: "Half-time", isLive: true, note: "Inter are on track for another low-concession win; Milan conceded first again.", swingTeam: teams[2]),
        MatchResult(homeTeam: teams[5], awayTeam: teams[9], homeScore: 3, awayScore: 1, clock: "84'", status: "Live", isLive: true, note: "Bayern's multi-goal win streak is close to extending.", swingTeam: teams[5]),
        MatchResult(homeTeam: teams[7], awayTeam: teams[6], homeScore: 0, awayScore: 0, clock: "32'", status: "Live", isLive: true, note: "Liverpool pressure is high, but no streak impact until the first goal.", swingTeam: nil),
        MatchResult(homeTeam: teams[10], awayTeam: teams[14], homeScore: 88, awayScore: 79, clock: "Q3 04:12", status: "Live", isLive: true, note: "Boston bench scoring trend is carrying into another positive run.", swingTeam: teams[10]),
        MatchResult(homeTeam: teams[13], awayTeam: teams[17], homeScore: 67, awayScore: 64, clock: "Q2 01:44", status: "Live", isLive: true, note: "Golden State's shot-volume signal is active, but the margin is still volatile.", swingTeam: teams[13]),
        MatchResult(homeTeam: teams[15], awayTeam: teams[12], homeScore: 121, awayScore: 104, clock: "FT", status: "Final", isLive: false, note: "Dallas extended the 120+ scoring trend and stays hot.", swingTeam: teams[15]),
        MatchResult(homeTeam: teams[11], awayTeam: teams[17], homeScore: 108, awayScore: 116, clock: "FT", status: "Final", isLive: false, note: "Denver's slow-start risk converted into another loss signal.", swingTeam: teams[17]),
        MatchResult(homeTeam: teams[18], awayTeam: teams[19], homeScore: 2, awayScore: 2, clock: "P3 08:18", status: "Live", isLive: true, note: "Tie game: Florida defensive streak is under pressure late.", swingTeam: nil),
        MatchResult(homeTeam: teams[20], awayTeam: teams[24], homeScore: 1, awayScore: 3, clock: "P2 03:09", status: "Live", isLive: true, note: "Boston Bruins are strengthening the defensive-form signal.", swingTeam: teams[24]),
        MatchResult(homeTeam: teams[21], awayTeam: teams[23], homeScore: 4, awayScore: 2, clock: "FT", status: "Final", isLive: false, note: "Edmonton's power-play scoring trend survived another round.", swingTeam: teams[21])
    ]

    static let alerts: [StreakAlert] = [
        StreakAlert(team: teams[0], trigger: "Alert when unbeaten run reaches 6", isEnabled: true),
        StreakAlert(team: teams[1], trigger: "Alert if scoring streak breaks", isEnabled: true),
        StreakAlert(team: teams[5], trigger: "Alert when Bayern score 2+ again", isEnabled: true),
        StreakAlert(team: teams[8], trigger: "Alert if Milan concede first again", isEnabled: false),
        StreakAlert(team: teams[11], trigger: "Alert after another first-quarter deficit", isEnabled: false),
        StreakAlert(team: teams[15], trigger: "Alert when Dallas reach 120 points", isEnabled: true),
        StreakAlert(team: teams[18], trigger: "Alert after another low-event win", isEnabled: false),
        StreakAlert(team: teams[21], trigger: "Alert if Edmonton power play scores", isEnabled: true),
        StreakAlert(team: teams[23], trigger: "Alert if Vegas concede in period one", isEnabled: false)
    ]
}
