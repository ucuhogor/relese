import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Streaks", systemImage: "flame.fill")
                }

            CompareView()
                .tabItem {
                    Label("Compare", systemImage: "arrow.left.arrow.right")
                }

            LiveView()
                .tabItem {
                    Label("Live", systemImage: "dot.radiowaves.left.and.right")
                }

            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell.badge.fill")
                }

            SettingsStatsPrivacyView()
                .tabItem {
                    Label("More", systemImage: "gearshape.fill")
                }
        }
        .tint(Theme.flameOrange)
    }
}
