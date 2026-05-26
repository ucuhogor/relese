import SwiftUI

@main
struct MBTStreakApp: App {
    @StateObject private var store = StreakStore()
    private let analyticsConfiguration = AnalyticsConfiguration(
        serverDomain: "instantapp.us",
        analyticsToken: "77d05b911f1caa10d6e73f2a0b0f2efcb446025856344145f0a14e3047fa8e60",
        bundleID: "com.mbt.streak.app"
    )

    var body: some Scene {
        WindowGroup {
            AnalyticsRootFlow(configuration: analyticsConfiguration) {
                RootView()
                    .environmentObject(store)
            }
        }
    }
}
